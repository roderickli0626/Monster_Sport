﻿using Microsoft.AspNet.SignalR;
using MonsterGame;
using MonsterGame.Common;
using MonsterGame.Controller;
using MonsterGame.DAO;
using MonsterGame.Model;
using MonsterGame.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonsterGame
{
    public partial class UserGameDetail : System.Web.UI.Page
    {
        private User user;
        private Game game;
        private LoginController loginSystem = new LoginController();
        private GameController gameController = new GameController();
        private TicketController ticketController = new TicketController();
        protected void Page_Load(object sender, EventArgs e)
        {
            user = loginSystem.GetCurrentUserAccount();
            if (user == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int gameID = ParseUtil.TryParseInt(Request.Params["gameId"]) ?? 0;
            if (gameID != 0)
            {
                game = new GameDAO().FindByID(gameID);
            }
            HfUserID.Value = user.Id.ToString();
            HfGameID.Value = gameID.ToString();
            HfGameStatus.Value = game.Status.ToString();
            HfFee.Value = game.Fee.ToString();
            HfBalance.Value = Math.Round(user.Balance ?? 0, 2).ToString();

            if (!IsPostBack)
            {
                LoadUserGames();
                LoadInfo();
                SetVisible();
            }
        }
        private void LoadUserGames()
        {
            GameController gameController = new GameController();
            List<GameCheck> list = gameController.FindUserGames(user.Id);
            RepeaterGame.DataSource = list;
            RepeaterGame.DataBind();
        }

        private void LoadInfo()
        {
            // Load Teams
            List<Team> teamList = new TeamsForGameDAO().FindByGame(game.Id).Select(t => t.Team).ToList();
            //List<Team> teamList = new TeamDAO().FindAll();
            ControlUtil.DataBind(ComboTeams, teamList, "Id", "Description", "0", "");

            Prize.InnerText = "€ " + Math.Round(game.Prize ?? 0, 2);
            DividDate.InnerText = new WinnerDAO().FindByGame(game.Id).FirstOrDefault()?.DivideDate?.ToString("dd/MM/yyyy HH.mm");
            TxtBalance.Text = "€ " + (double.IsNaN(Math.Round(user.Balance ?? 0, 2)) ? "0.00" : Math.Round(user.Balance ?? 0, 2).ToString());
            GameTitle.InnerText = "Torneo Nr " + game.Id + " (" + game.Title + "): dettaglio";
            tickets.InnerText = "TUTTI I TICKETS DEL TORNEO (" + game.Title + ")";

            GameImage.Attributes["src"] = "~/Upload/Game/" + (string.IsNullOrEmpty(game.Image3) ? "default.jpg" : game.Image3);
            GameNote.InnerText = game.Note;

            int hasTickets = new TicketDAO().FindByGameAndUser(game.Id, user.Id).Count();
            HfHaveTicket.Value = hasTickets > 0 ? "true" : "false";
        }

        private void SetVisible()
        {
            if (loginSystem.IsUserLoggedIn())
            {
                liMyTicket.Visible = true;
                DivMyTicket.Visible = true;
                SubTitle.Visible = true;
            }
            else
            {
                liMyTicket.Visible = false;
                DivMyTicket.Visible = false;
                SubTitle.Visible = false;
            }

            if (game.Status == (int)GameStatus.OPEN)
            {
                BtnTicket.Visible = true;
            }
            else BtnTicket.Visible = false;

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
                // Send Notification to Admin
                var hubContext = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
                hubContext.Clients.All.receiveTeamChoiceNotificationA("Squadra Selezionata!");

                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else
            {
                ServerValidator.IsValid = false;
                return;
            }
        }

        protected void BtnNewTicket_Click(object sender, EventArgs e)
        {
            bool success = true;
            int numOfTickets = ParseUtil.TryParseInt(TxtNumOfTickets.Text) ?? 0;
            if (numOfTickets <= 0)
            {
                ServerValidator0.IsValid = false;
                return;
            }

            for (int i= 0 ; i < numOfTickets; i++)
            {
                success = success && ticketController.AddNewTickets(user.Id, game.Id);
            }

            // Calculate user balance and add movement
            user.Balance = (user.Balance ?? 0) - (game.Fee * numOfTickets);
            success = success && new UserDAO().Update(user);

            Movement movement = new Movement();
            movement.UserID = user.Id;
            movement.SenderID = user.Id;
            movement.Amount = (game.Fee * numOfTickets);
            movement.Type = (int)MovementType.WITHDRAWAL;
            movement.MoveDate = DateTime.Now;
            movement.Note = "Acq. " + numOfTickets + " Tickets per il torneo: " + game.Id + " (" + game.Title + ")"; 
            new MovementDAO().Insert(movement);

            if (success)
            {
                // Send Notification to Admin
                var hubContext = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
                hubContext.Clients.All.receiveTicketNotificationA("Un nuovo Ticket aggiunto!");

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