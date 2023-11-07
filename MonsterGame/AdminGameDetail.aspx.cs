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
using MonsterGame.Common;

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
                // If Game status is Completed or Closed, but there is no Winner in the game, then add Winners to the game.
                // This case can occur when SA changed game status as Completed or Closed Manually in AdminGames.aspx page.
                // TODO
            }
        }
        private void LoadInfo()
        {
            // Load Teams
            List<Team> teamList = new TeamDAO().FindAll();
            ControlUtil.DataBind(ComboTeams, teamList, "Id", "Description", "0", "");

            // Load Results
            ComboResults.Items.Clear();
            ComboResults.Items.Add(new ListItem("", ((int)RoundResult.N).ToString()));
            ComboResults.Items.Add(new ListItem("WIN", ((int)RoundResult.W).ToString()));
            ComboResults.Items.Add(new ListItem("DRAW", ((int)RoundResult.P).ToString()));
            ComboResults.Items.Add(new ListItem("LOSE", ((int)RoundResult.L).ToString()));
        }

        private void SetVisible()
        {
            if (game.Status == (int)GameStatus.OPEN || game.Status == (int)GameStatus.STARTED) BtnRound.Visible = true;
            else BtnRound.Visible = false;

            if (game.Status == (int)GameStatus.COMPLETED || game.Status == (int)GameStatus.CLOSED)
            {
                liWinner.Visible = true;
                DivWinners.Visible = true;
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
            if (remainedTickets <= game.NumOfWinners)
            {
                game.Status = (int)GameStatus.COMPLETED;
                bool success = new GameDAO().Update(game);
                // Add Winners to Winner table and then Page Redirect? Refresh? or SetVisible?
                

                SetVisible();
                return;
            }
            else if (game.Status == (int)GameStatus.STARTED)
            {
                game.Status = (int)GameStatus.TEAMCHOICE;
                bool success = new GameDAO().Update(game);
                SetVisible();
                return;
            }
        }

        protected void BtnPrize_Click(object sender, EventArgs e)
        {

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
            int roundResult = ControlUtil.GetSelectedValue(ComboResults) ?? 0;
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
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else
            {
                ServerValidator1.IsValid = false;
                return;
            }
        }
    }
}