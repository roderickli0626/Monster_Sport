using MonsterGame;
using MonsterGame.DAO;
using MonsterGame.Model;
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

    }
}