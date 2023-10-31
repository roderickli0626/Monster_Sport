using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;

namespace MonsterGame.DAO
{
    public class TicketResultDAO : BasicDAO
    {
        public TicketResultDAO() { }
        public List<TicketResult> FindAll()
        {
            Table<TicketResult> table = GetContext().TicketResults;
            return table.ToList();
        }
        public TicketResult FindByID(int id)
        {
            return GetContext().TicketResults.Where(g => g.Id == id).FirstOrDefault();
        }
        public TicketResult FindByGameAndTeamAndRound(int gameID, int teamID, int round)
        {
            return GetContext().TicketResults.Where(g => g.Ticket.Game.Id == gameID && g.TeamID == teamID && g.RoundNo == round).FirstOrDefault();
        }
        public List<TicketResult> FindByTicket(int ticketID)
        {
            return GetContext().TicketResults.Where(g => g.TicketID == ticketID).ToList();
        }
        public bool Insert(TicketResult ticketResult)
        {
            GetContext().TicketResults.InsertOnSubmit(ticketResult);
            GetContext().SubmitChanges();
            return true;
        }

        public bool Update(TicketResult ticketResult)
        {
            GetContext().SubmitChanges();
            GetContext().Refresh(RefreshMode.OverwriteCurrentValues, ticketResult);
            return true;
        }
        public bool Delete(int id)
        {
            TicketResult ticketResult = GetContext().TicketResults.SingleOrDefault(u => u.Id == id);
            GetContext().TicketResults.DeleteOnSubmit(ticketResult);
            GetContext().SubmitChanges();
            return true;
        }
    }
}