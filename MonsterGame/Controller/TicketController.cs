using Antlr.Runtime.Tree;
using MonsterGame;
using MonsterGame.DAO;
using MonsterGame.Model;
using MonsterGame.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame.Controller
{
    public class TicketController
    {
        TicketDAO ticketDAO;
        TicketResultDAO ticketResultDAO;
        public TicketController() 
        { 
            ticketDAO = new TicketDAO();
            ticketResultDAO = new TicketResultDAO();
        }

        public List<TicketCheck> FindTickets(int gameID)
        {
            List<Ticket> ticketList = ticketDAO.FindByGame(gameID);
            List<TicketCheck> result = new List<TicketCheck>();
            foreach (Ticket ticket in ticketList)
            {
                TicketCheck ticketCheck = new TicketCheck(ticket);
                List<TicketResult> resultList = ticketResultDAO.FindByTicket(ticket.Id);
                List<TicketResultCheck> resutlCheckList = new List<TicketResultCheck>();
                foreach (TicketResult resultResult in resultList)
                {
                    TicketResultCheck ticketResultCheck = new TicketResultCheck(resultResult);
                    resutlCheckList.Add(ticketResultCheck);
                }
                ticketCheck.TicketResults = resutlCheckList;
                result.Add(ticketCheck);
            }
            return result;
        }

        public bool AddNewRound(int gameID, int? Round)
        {
            bool success = true;
            List<Ticket> ticketList = ticketDAO.FindByGame(gameID);
            foreach(Ticket ticket in ticketList)
            {
                TicketResult ticketResult = new TicketResult();
                ticketResult.TicketID = ticket.Id;
                ticketResult.RoundNo = Round;

                List<int?> roundResultList = ticketResultDAO.FindByTicket(ticket.Id).Select(t => t.RoundResult).ToList();
                if (roundResultList.Contains((int)RoundResult.L) || roundResultList.Count(i => i == (int)RoundResult.P) > 1 || roundResultList.Contains(null))
                {
                    ticketResult.RoundResult = null;
                }
                else
                {
                    ticketResult.RoundResult = (int)RoundResult.N;
                }

                success = ticketResultDAO.Insert(ticketResult);
            }

            return success;
        }

        public int GetRemainedTickets(int gameID, int? currentRound)
        {
            List<int?> currentRoundResult = ticketResultDAO.FindGameAndRound(gameID, currentRound).Select(t => t.RoundResult).ToList();

            int num = currentRoundResult.Count(i => i.HasValue);

            return num;
        }
    }
}