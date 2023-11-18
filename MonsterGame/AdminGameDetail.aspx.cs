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
using MonsterGame.Model;
using System.IO;

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
                //
                LoadStatus();
                //
                LoadInfo();
                SetVisible();
            }
        }

        private void LoadStatus()
        {
            ComboModalStatus.Items.Clear();
            ComboModalStatus.Items.Add(new ListItem("APERTO", ((int)GameStatus.OPEN).ToString()));
            ComboModalStatus.Items.Add(new ListItem("INIZIATO", ((int)GameStatus.STARTED).ToString()));
            ComboModalStatus.Items.Add(new ListItem("SCELTA TEAM", ((int)GameStatus.TEAMCHOICE).ToString()));
            ComboModalStatus.Items.Add(new ListItem("SOSPESO", ((int)GameStatus.SUSPENDED).ToString()));
            ComboModalStatus.Items.Add(new ListItem("CHIUSO", ((int)GameStatus.CLOSED).ToString()));
            ComboModalStatus.Items.Add(new ListItem("TERMINATO", ((int)GameStatus.COMPLETED).ToString()));
        }
        private void LoadInfo()
        {
            // Load Teams
            List<Team> teamList = new TeamsForGameDAO().FindByGame(game.Id).OrderBy(t => t.Team.Description).Select(t => t.Team).ToList();
            //List<Team> teamList = new TeamDAO().FindAll();
            ControlUtil.DataBind(ComboTeams, teamList, "Id", "Description", "0", "");

            Prize.InnerText = "€ " + Math.Round(game.Prize ?? 0, 2);
            GameTitle.InnerText = "Torneo nr " + game.Id + ": Dettagli";

            GameImage.Attributes["src"] = "~/Upload/Game/" + (string.IsNullOrEmpty(game.Image1) ? "default.jpg" : game.Image1);
            GameNote.InnerText = game.Note;

            // Load Modal Info
            TxtTitle.Text = game.Title;
            TxtStartDate.Text = game.StartDate?.ToString("dd/MM/yyyy HH.mm");
            TxtEndDate.Text = game.EndDate?.ToString("dd/MM/yyyy HH.mm");
            TxtFee.Text = game.Fee.ToString();
            TxtTax.Text = game.Tax.ToString();
            ControlUtil.SelectValue(ComboModalStatus, game.Status);
            TxtMinPlayers.Text = game.MinPlayers.ToString();
            TxtTeamNum.Text = game.NumberOfTeams.ToString();
            TxtNote.Text = game.Note;
            TxtPercent1.Text = game.PercentForFirst.ToString();
            TxtPercent2.Text = game.PercentForSecond.ToString();
            TxtPercent3.Text = game.PercentForThird.ToString();
            TxtPercent4.Text = game.PercentForForth.ToString();
            TxtPercent5.Text = game.PercentForFifth.ToString();
            TxtWinners.Text = game.NumOfWinners.ToString();
            GameImage1.Attributes["src"] = "~/Upload/Game/" + (string.IsNullOrEmpty(game.Image1) ? "default.jpg" : game.Image1);
            GameImage2.Attributes["src"] = "~/Upload/Game/" + (string.IsNullOrEmpty(game.Image2) ? "default.jpg" : game.Image2);
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
                hubContext.Clients.All.receiveRoundNotification("Torneo " + game.Id + " '" + game.Title + "' terminato al Turno: " + currentRound + "!");

                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else if (game.Status == (int)GameStatus.STARTED)
            {
                game.Status = (int)GameStatus.TEAMCHOICE;
                bool success = new GameDAO().Update(game);

                // Send Notification to All Users
                var hubContext = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
                hubContext.Clients.All.receiveRoundNotification("Un nuovo Turno " + currentRound + " è appena iniziato!");

                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }

            // Send Notification to All Users
            var hubContext1 = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
            hubContext1.Clients.All.receiveRoundNotification("Un nuovo Turno " + currentRound + " è appena iniziato!");
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
                    movement.Note = "Ticket " + winner.Note + " VINCENTE TORNEO " + game.Id + " '" + game.Title + "'";
                    movement.Type = (int)MovementType.DEPOSIT;
                    movement.MoveDate = DateTime.Now;
                    movementDAO.Insert(movement);
                }
            }

            // Send Notification to All Users
            var hubContext = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
            hubContext.Clients.All.receivePrizeNotification("Premi assegnati!");

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
                hubContext.Clients.All.receiveTeamChoiceNotification("Squadra Selezionata!");

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
                hubContext.Clients.All.receiveResultNotification("Risultato Aggiunto!");

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

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            if (!IsValid) { return; }
            string title = TxtTitle.Text;
            DateTime? sdate = ParseUtil.TryParseDate(TxtStartDate.Text, "dd/MM/yyyy HH.mm");
            DateTime? edate = ParseUtil.TryParseDate(TxtEndDate.Text, "dd/MM/yyyy HH.mm");
            double fee = ParseUtil.TryParseDouble(TxtFee.Text) ?? 0;
            double tax = ParseUtil.TryParseDouble(TxtTax.Text) ?? 0;
            int status = ControlUtil.GetSelectedValue(ComboModalStatus) ?? (int)GameStatus.OPEN;
            int minPlayers = ParseUtil.TryParseInt(TxtMinPlayers.Text) ?? 0;
            int teamNum = ParseUtil.TryParseInt(TxtTeamNum.Text) ?? 0;
            string note = TxtNote.Text;
            double percent1 = ParseUtil.TryParseDouble(TxtPercent1.Text) ?? 0;
            double percent2 = ParseUtil.TryParseDouble(TxtPercent2.Text) ?? 0;
            double percent3 = ParseUtil.TryParseDouble(TxtPercent3.Text) ?? 0;
            double percent4 = ParseUtil.TryParseDouble(TxtPercent4.Text) ?? 0;
            double percent5 = ParseUtil.TryParseDouble(TxtPercent5.Text) ?? 0;
            int NumOfWinners = ParseUtil.TryParseInt(TxtWinners.Text) ?? 0;

            bool WinnerValid = false;
            if (NumOfWinners == 1 && percent1 > 0 && percent2 == 0 && percent3 == 0 && percent4 == 0 && percent5 == 0) WinnerValid = true;
            else if (NumOfWinners == 2 && percent1 > 0 && percent2 > 0 && percent3 == 0 && percent4 == 0 && percent5 == 0) WinnerValid = true;
            else if (NumOfWinners == 3 && percent1 > 0 && percent2 > 0 && percent3 > 0 && percent4 == 0 && percent5 == 0) WinnerValid = true;
            else if (NumOfWinners == 4 && percent1 > 0 && percent2 > 0 && percent3 > 0 && percent4 > 0 && percent5 == 0) WinnerValid = true;
            else if (NumOfWinners == 5 && percent1 > 0 && percent2 > 0 && percent3 > 0 && percent4 > 0 && percent5 > 0) WinnerValid = true;
            else if (NumOfWinners > 5) WinnerValid = true;

            if ((percent1 + percent2 + percent3 + percent4 + percent5) != 100 || !WinnerValid)
            {
                ServerValidator3.IsValid = false;
                return;
            }

            List<int> teamList = new List<int>();

            int? gameID = ParseUtil.TryParseInt(HfGameID.Value);
            //Image Save
            string imageTitle1 = UploadImage(HfGameImage1);
            string imageTitle2 = UploadImage(HfGameImage2);

            bool success = gameController.SaveGame(gameID, title, sdate, edate, fee, tax, status, minPlayers, teamNum, note, percent1, percent2, percent3, percent4, percent5, NumOfWinners, teamList, imageTitle1, imageTitle2);
            if (!success)
            {
                ServerValidator4.IsValid = false;
                return;
            }

            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        private string UploadImage(HiddenField hiddenField)
        {
            string base64String = hiddenField.Value;
            if (string.IsNullOrEmpty(base64String)) return "";
            // Extract the file extension from the Base64 string
            // Extract image format and data from the Base64 string
            string[] base64Data = base64String.Split(',');
            string imageFormat = base64Data[0].Split('/')[1].Split(';')[0];
            byte[] imageData = Convert.FromBase64String(base64Data[1]);

            // Generate a unique filename
            string filename = Guid.NewGuid().ToString() + "." + imageFormat;

            // Save the byte array as an image to a specific folder
            string path = Server.MapPath("~/Upload/Game/" + filename);
            File.WriteAllBytes(path, imageData);

            return filename;
        }
    }
}