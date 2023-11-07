using MonsterGame;
using MonsterGame.Common;
using MonsterGame.DAO;
using MonsterGame.Model;
using MonsterGame.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace MonsterSport.Controller
{
    public class WinnerController
    {
        WinnerDAO winnerDao;
        TicketDAO ticketDao;
        TicketResultDAO ticketResultDao;
        public WinnerController()
        {
            winnerDao = new WinnerDAO();
            ticketDao = new TicketDAO();
            ticketResultDao = new TicketResultDAO();
        }

        public SearchResult Search(int start, int length, int gameID)
        {
            SearchResult result = new SearchResult();
            IEnumerable<Winner> winnerList = winnerDao.FindAll().Where(w => w.GameID == gameID);

            result.TotalCount = winnerList.Count();
            winnerList = winnerList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (Winner winner in winnerList)
            {
                WinnerCheck winnercheck = new WinnerCheck(winner);
                checks.Add(winnercheck);
            }
            result.ResultList = checks;

            return result;
        }

        public bool UpdateWinnerPercent(int winnerID, double percent)
        {
            Winner winner = winnerDao.FindByID(winnerID);
            if (winner == null) return false;
            winner.Rate = percent;
            return winnerDao.Update(winner);
        }

        public bool AddWinners(int gameID)
        {
            List<Winner> winners = winnerDao.FindByGame(gameID);
            if (winners.Count() != 0) { return false; }
            Game game = new GameDAO().FindByID(gameID);
            List<Ticket> allTickets = ticketDao.FindByGame(gameID);
            List<Ticket> remainedTickets = new List<Ticket>();
            foreach (Ticket ticket in allTickets)
            {
                List<TicketResult> ticketResults = ticketResultDao.FindByTicket(ticket.Id);
                List<int?> roundResults = ticketResults.Select(t => t.RoundResult).ToList();
                if (roundResults.Contains((int)RoundResult.L) || roundResults.Count(i => i == (int)RoundResult.P) > 1 || roundResults.Contains(null))
                {
                    continue;
                }
                else remainedTickets.Add(ticket);
            }

            if (remainedTickets.Count() > 0)
            {
                List<double> percents = new List<double>();
                if (remainedTickets.Count() == game.NumOfWinners)
                {
                    percents.Add(game.PercentForFirst ?? 0);
                    percents.Add(game.PercentForSecond ?? 0);
                    percents.Add(game.PercentForThird ?? 0);
                    percents.Add(game.PercentForForth ?? 0);
                    percents.Add(game.PercentForFifth ?? 0);
                }
                else
                {
                    percents.Add(0);
                    percents.Add(0);
                    percents.Add(0);
                    percents.Add(0);
                    percents.Add(0);
                }
                foreach (Ticket ticket in remainedTickets)
                {
                    Winner winner = new Winner();
                    winner.GameID = gameID;
                    winner.UserID = ticket.UserID;
                    winner.WinDate = DateTime.Now;
                    winner.Rate = percents[remainedTickets.IndexOf(ticket)];

                    winnerDao.Insert(winner);
                }
            }
            else
            {
                foreach (Ticket ticket in allTickets)
                {
                    List<TicketResult> ticketResults = ticketResultDao.FindByTicket(ticket.Id);
                    int? roundResult = ticketResults[ticketResults.Count - 2].RoundResult;
                    if (!roundResult.HasValue) { continue; }
                    else remainedTickets.Add(ticket);
                }
                foreach (Ticket ticket in remainedTickets)
                {
                    Winner winner = new Winner();
                    winner.GameID = gameID;
                    winner.UserID = ticket.UserID;
                    winner.WinDate = DateTime.Now;
                    winner.Rate = 0;

                    winnerDao.Insert(winner);
                }
            }
            return true;
        }
    }
}