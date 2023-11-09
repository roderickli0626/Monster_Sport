using Microsoft.AspNet.SignalR;
using MonsterGame.Common;
using MonsterGame.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonsterGame
{
    public partial class TaskRunner : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Your function's implementation
            GameDAO gameDao = new GameDAO();
            List<Game> games = gameDao.FindAll();
            foreach (Game game in games)
            {
                if (game.Status == (int)GameStatus.OPEN || game.Status == (int)GameStatus.TEAMCHOICE)
                {
                    game.Status = (int)GameStatus.STARTED;
                    if (game.Status == (int)GameStatus.OPEN)
                    {
                        game.Prize = (game.Fee ?? 0) * (game.RealPlayers ?? 0) * (100 - (game.Tax ?? 0)) / 100;
                    }
                    gameDao.Update(game);

                    // Auto Team Choice For Each Tickets with Alphabetical Order in TicketResult
                    List<Ticket> ticketList = new TicketDAO().FindByGame(game.Id);
                    TicketResultDAO ticketResultDAO = new TicketResultDAO();
                    List<int> teamList = new TeamsForGameDAO().FindByGame(game.Id).Select(t => t.TeamID ?? 0).ToList();
                    foreach (Ticket ticket in ticketList)
                    {
                        List<TicketResult> ticketResults = ticketResultDAO.FindByTicket(ticket.Id);
                        List<int> assignedTeamList = ticketResults.Select(t => t.TeamID ?? 0).ToList();
                        if (ticketResults.Count() == 0) continue;
                        TicketResult lastticketResult = ticketResults[ticketResults.Count() - 1];
                        if (lastticketResult.RoundResult != null && lastticketResult.TeamID == null)
                        {
                            lastticketResult.TeamID = teamList.Where(i => !assignedTeamList.Contains(i)).FirstOrDefault();
                            ticketResultDAO.Update(lastticketResult);
                        }
                    }
                }
            }

            // Send Game Started Notification
            var hubContext = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
            hubContext.Clients.All.receiveStartGameNotification("Game Started!");

        }
    }
}