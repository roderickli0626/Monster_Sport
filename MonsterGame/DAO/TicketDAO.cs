using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Net.Sockets;
using System.Web;

namespace MonsterGame.DAO
{
    public class TicketDAO : BasicDAO
    {
        public TicketDAO() { }
        public List<Ticket> FindAll()
        {
            Table<Ticket> table = GetContext().Tickets;
            return table.ToList();
        }
        public Ticket FindByID(int id)
        {
            return GetContext().Tickets.Where(g => g.Id == id).FirstOrDefault();
        }
        public List<Ticket> FindByGame(int gameID)
        {
            return GetContext().Tickets.Where(g => g.GameID == gameID).ToList();
        }
        public bool Insert(Ticket ticket)
        {
            GetContext().Tickets.InsertOnSubmit(ticket);
            GetContext().SubmitChanges();
            return true;
        }

        public bool Update(Ticket ticket)
        {
            GetContext().SubmitChanges();
            GetContext().Refresh(RefreshMode.OverwriteCurrentValues, ticket);
            return true;
        }
        public bool Delete(int id)
        {
            Ticket ticket = GetContext().Tickets.SingleOrDefault(u => u.Id == id);
            GetContext().Tickets.DeleteOnSubmit(ticket);
            GetContext().SubmitChanges();
            return true;
        }
    }
}