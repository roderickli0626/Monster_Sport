using Microsoft.AspNet.SignalR;
using MonsterGame.Common;
using MonsterGame.DAO;
using RestSharp;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Hosting;
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
                if (game.Status == (int)GameStatus.OPEN)
                {
                    List<Ticket> ticketList = new TicketDAO().FindByGame(game.Id);
                    if (ticketList.Count() < game.MinPlayers) continue;
                }

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
                    List<int> teamList = new TeamsForGameDAO().FindByGame(game.Id).OrderBy(t => t.Team.Description).Select(t => t.TeamID ?? 0).ToList();
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


                    // Send WhatsApp message with First Image of Game to All users of this game
                    List<User> userList = ticketList.Select(t => t.User).Distinct().ToList();
                    foreach (User user in userList)
                    {
                        string imageUrl = "~/Upload/Game/" + (string.IsNullOrEmpty(game.Image1) ? "default.jpg" : game.Image1);
                        string path = HostingEnvironment.MapPath(imageUrl);
                        byte[] AsBytes = File.ReadAllBytes(path);
                        string AsBase64String = Convert.ToBase64String(AsBytes);

                        SendWhatsAppMsg(user.Mobile, "Waiting for results.");

                        SendWhatsAppImg(user.Mobile, AsBase64String);
                    }
                }
            }


            // Send Game Started Notification
            var hubContext = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
            hubContext.Clients.All.receiveStartGameNotification("Game Started!");
        }

        private async Task SendWhatsAppMsg(string toPhoneNum, string message)
        {
            var url = "https://api.ultramsg.com/instance71748/messages/chat";
            var client = new RestClient(url);

            var request = new RestRequest(url, Method.Post);
            request.AddHeader("content-type", "application/x-www-form-urlencoded");
            request.AddParameter("token", "cq5s6q6y8hp7478g");
            request.AddParameter("to", toPhoneNum);
            request.AddParameter("body", message);

            RestResponse response = await client.ExecuteAsync(request);
            var output = response.Content;
            Console.WriteLine(output);
        }
        private async Task SendWhatsAppImg(string toPhoneNum, string imageBase64)
        {
            var url = "https://api.ultramsg.com/instance71748/messages/image";
            var client = new RestClient(url);

            var request = new RestRequest(url, Method.Post);
            request.AddHeader("content-type", "application/x-www-form-urlencoded");
            request.AddParameter("token", "cq5s6q6y8hp7478g");
            request.AddParameter("to", toPhoneNum);
            request.AddParameter("image", imageBase64);

            RestResponse response = await client.ExecuteAsync(request);
            var output = response.Content;
            Console.WriteLine(output);
        }
    }
}