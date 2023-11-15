using MonsterGame.Controller;
using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MonsterGame.Util;
using MonsterGame.DAO;
using PayPal.Api;
using MonsterGame.Common;
using Microsoft.AspNet.SignalR;

namespace MonsterGame
{
    public partial class AdminGameDetail : System.Web.UI.Page
    {
        private User user;
        private Game game;
        private LoginController loginSystem = new LoginController();
        private GameController gameController = new GameController();
        private TicketController ticketController = new TicketController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!loginSystem.IsSuperAdminLoggedIn())
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int gameID = ParseUtil.TryParseInt(Request.Params["gameId"]) ?? 0;
            if (gameID != 0)
            {
                game = new GameDAO().FindByID(gameID);
            }
            HfGameID.Value = gameID.ToString();
            HfGameStatus.Value = game.Status.ToString();

            if (!IsPostBack)
            {
                LoadInfo();
                SetVisible();
            }
        }
        private void LoadInfo()
        {
            // Load Teams
            List<Team> teamList = new TeamsForGameDAO().FindByGame(game.Id).OrderBy(t => t.Team.Description).Select(t => t.Team).ToList();
            //List<Team> teamList = new TeamDAO().FindAll();
            ControlUtil.DataBind(ComboTeams, teamList, "Id", "Description", "0", "");

            //// Load Results
            //ComboResults.Items.Clear();
            //ComboResults.Items.Add(new ListItem("", ((int)RoundResult.N).ToString()));
            //ComboResults.Items.Add(new ListItem("WIN", ((int)RoundResult.W).ToString()));
            //ComboResults.Items.Add(new ListItem("DRAW", ((int)RoundResult.P).ToString()));
            //ComboResults.Items.Add(new ListItem("LOSE", ((int)RoundResult.L).ToString()));

            Prize.InnerText = "€ " + Math.Round(game.Prize ?? 0, 2);
            GameTitle.InnerText = "Game" + game.Id + " Details";
        }

        private void SetVisible()
        {
            //if (game.Status == (int)GameStatus.OPEN || game.Status == (int)GameStatus.STARTED)
            if (game.Status == (int)GameStatus.STARTED)
            {
                List<Ticket> ticketList = new TicketDAO().FindByGame(game.Id);
                if (ticketList.Count() == 0) BtnRound.Visible = false;
                else BtnRound.Visible = true;
            }
            else BtnRound.Visible = false;

            if (game.Status == (int)GameStatus.COMPLETED || game.Status == (int)GameStatus.CLOSED)
            {
                liWinner.Visible = true;
                DivWinners.Visible = true;
                List<double?> prizeList = new WinnerDAO().FindByGame(game.Id).Select(w => w.Prize).ToList();
                if (prizeList.Contains(null)) BtnPrize.Visible = true;
                else BtnPrize.Visible = false;
            }
            else
            {
                liWinner.Visible = false;
                DivWinners.Visible = false;
            }
        }

        protected void BtnRound_Click(object sender, EventArgs e)
        {
            int? currentRound = ParseUtil.TryParseInt(HfCurrentRound.Value);
            if (currentRound == null) return;
            
            bool success1 = gameController.AddNewRound(game.Id, currentRound);
            bool success2 = ticketController.AddNewRound(game.Id, currentRound);

            int remainedTickets = ticketController.GetRemainedTickets(game.Id, currentRound);
            if ((remainedTickets <= game.NumOfWinners && game.Status != (int)GameStatus.OPEN) || currentRound > game.NumberOfTeams)
            {
                game.Status = (int)GameStatus.COMPLETED;
                bool success = new GameDAO().Update(game);
                // Add Winners to Winner table and then Page Refresh
                if (success) SaveWinners();

                // Send Notification to All Users
                var hubContext = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
                hubContext.Clients.All.receiveRoundNotification("Game" + game.Id + " '" + game.Title + "' is Completed At Round" + currentRound + "!");

                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else if (game.Status == (int)GameStatus.STARTED)
            {
                game.Status = (int)GameStatus.TEAMCHOICE;
                bool success = new GameDAO().Update(game);

                // Send Notification to All Users
                var hubContext = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
                hubContext.Clients.All.receiveRoundNotification("New Round" + currentRound + " is Started!");

                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }

            // Send Notification to All Users
            var hubContext1 = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
            hubContext1.Clients.All.receiveRoundNotification("New Round" + currentRound + " is Started!");
        }

        private void SaveWinners()
        {
            WinnerController winnerController = new WinnerController();
            bool success = winnerController.AddWinners(game.Id);
        }

        protected void BtnPrize_Click(object sender, EventArgs e)
        {
            WinnerDAO winnerDAO = new WinnerDAO();
            UserDAO userDAO = new UserDAO();
            MovementDAO movementDAO = new MovementDAO();
            List<Winner> winners = winnerDAO.FindByGame(game.Id);
            double prize = game.Prize ?? 0;

            foreach (Winner winner in winners)
            {
                winner.Prize = prize * (winner.Rate / 100);
                winnerDAO.Update(winner);
                User user = userDAO.FindByID(winner.UserID ?? 0);
                if (user != null)
                {
                    // Add Balance of User
                    user.Balance = (user.Balance ?? 0) + winner.Prize;
                    userDAO.Update(user);

                    // Add A Movement
                    if (winner.Prize == 0) continue;
                    Movement movement = new Movement();
                    movement.UserID = user.Id;
                    movement.Amount = winner.Prize;
                    movement.Note = "Ticket" + winner.Note + "WIN - Game" + game.Id + " '" + game.Title + "'";
                    movement.Type = (int)MovementType.DEPOSIT;
                    movement.MoveDate = DateTime.Now;
                    movementDAO.Insert(movement);
                }
            }

            // Send Notification to All Users
            var hubContext = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
            hubContext.Clients.All.receivePrizeNotification("Awarded Prize!");

            SetVisible();
        }

        protected void BtnChangeTeam_Click(object sender, EventArgs e)
        {
            int? teamId = ControlUtil.GetSelectedValue(ComboTeams);
            int ticketResultId = ControlUtil.TryParseInt(HfTicketResultID.Value) ?? 0;
            bool success = false;
            if (ticketResultId != 0)
            {
                TicketResultDAO ticketResultDAO = new TicketResultDAO();
                TicketResult ticketResult = ticketResultDAO.FindByID(ticketResultId);
                if (ticketResult != null)
                {
                    Result result = new ResultDAO().FindByGame(game.Id).Where(r => r.TeamsForGame.TeamID == teamId).FirstOrDefault();
                    ticketResult.TeamID = teamId;
                    // Must Change TeamID and Team's RoundResult at the same time if can change team in all game status.
                    // Current can change team only in game status OPEN and TEAMCHOICE.
                    //ticketResult.RoundResult = result.RoundResult;
                    success = ticketResultDAO.Update(ticketResult);
                }
            }

            if (success)
            {
                // Send Notification to All Users
                var hubContext = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
                hubContext.Clients.All.receiveTeamChoiceNotification("Team Selected!");

                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else
            {
                ServerValidator.IsValid = false;
                return;
            }
        }

        protected void BtnResult_Click(object sender, EventArgs e)
        {
            //int roundResult = ControlUtil.GetSelectedValue(ComboResults) ?? 0;
            int roundResult = ParseUtil.TryParseInt(ResultOptions.SelectedValue) ?? 0;
            int resultID = ParseUtil.TryParseInt(HfResultID.Value) ?? 0;
            bool success = false;
            if (resultID != 0) {
                ResultDAO resultDAO = new ResultDAO();
                Result result = resultDAO.FindByID(resultID);
                if (result != null)
                {
                    result.RoundResult = roundResult;
                    success = resultDAO.Update(result);

                    TicketResultDAO ticketResultDAO = new TicketResultDAO();
                    List<TicketResult> ticketResults = ticketResultDAO.FindByGameAndTeamAndRound(result.TeamsForGame.GameID ?? 0, result.TeamsForGame.TeamID ?? 0, result.RoundNo ?? 0);
                    foreach(TicketResult ticketResult in ticketResults)
                    {
                        ticketResult.RoundResult = roundResult;
                        ticketResultDAO.Update(ticketResult);
                    }
                }
            }

            if (success)
            {
                // Send Notification to All Users
                var hubContext = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
                hubContext.Clients.All.receiveResultNotification("Result Added!");

                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else
            {
                ServerValidator1.IsValid = false;
                return;
            }
        }

        protected void BtnPercent_Click(object sender, EventArgs e)
        {
            double percent = ParseUtil.TryParseDouble(TxtPercent.Text) ?? 0;
            int winnerID = ParseUtil.TryParseInt(HfWinnerID.Value) ?? 0;

            bool success = new WinnerController().UpdateWinnerPercent(winnerID, percent);
            if (!success)
            {
                ServerValidator2.IsValid = false;
                return;
            }

            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }
    }
}