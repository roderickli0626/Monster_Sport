using MonsterGame.Common;
using MonsterGame.Controller;
using MonsterGame.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame
{
    public class GlobalTimerModule : IHttpModule
    {
        private System.Timers.Timer timer;
        /// <summary>
        /// You will need to configure this module in the Web.config file of your
        /// web and register it with IIS before being able to use it. For more information
        /// see the following link: https://go.microsoft.com/?linkid=8101007
        /// </summary>
        #region IHttpModule Members

        public void Dispose()
        {
            timer.Stop();
            timer.Dispose();
        }

        public void Init(HttpApplication context)
        {
            timer = new System.Timers.Timer();
            timer.Interval = CalculateIntervalUntilNextFridayAt6PM();
            timer.Elapsed += TimerElapsed;
            timer.Start();
        }

        #endregion

        public void OnLogRequest(Object source, EventArgs e)
        {
            //custom logging logic can go here
        }
        private void TimerElapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            if (DateTime.Now.DayOfWeek == DayOfWeek.Friday && DateTime.Now.Hour == 18 && DateTime.Now.Minute == 0)
            {
                // Call your function here
                StartGames();
            }

            // Calculate the interval until the next Friday at 18:00
            timer.Interval = CalculateIntervalUntilNextFridayAt6PM();
        }

        private double CalculateIntervalUntilNextFridayAt6PM()
        {
            DateTime nextFriday = DateTime.Now.AddDays((int)DayOfWeek.Friday - (int)DateTime.Now.DayOfWeek);
            nextFriday = new DateTime(nextFriday.Year, nextFriday.Month, nextFriday.Day, 18, 0, 0);
            if (nextFriday < DateTime.Now)
            {
                nextFriday = nextFriday.AddDays(7);
            }
            return (nextFriday - DateTime.Now).TotalMilliseconds;
        }

        private void StartGames()
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
                        TicketResult lastticketResult = ticketResults[ticketResults.Count()-1];
                        if (lastticketResult.RoundResult != null && lastticketResult.TeamID == null)
                        {
                            lastticketResult.TeamID = teamList.Where(i => !assignedTeamList.Contains(i)).FirstOrDefault();
                            ticketResultDAO.Update(lastticketResult);
                        }
                    }
                }
            }
        }
    }
}
