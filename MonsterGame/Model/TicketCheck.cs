using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;

namespace MonsterGame.Model
{
    public class TicketCheck
    {
        Ticket ticket;
        public TicketCheck() { }
        public TicketCheck(Ticket ticket)
        {
            this.ticket = ticket;
            if (ticket == null) return;
            Id = ticket.Id;
            UserId = ticket.UserID ?? 0;
            UserName = ticket.User.Name;
            GameId = ticket.GameID ?? 0;
            GameTitle = ticket.Game.Title;
            GetDate = ticket.GetDate?.ToString("dd/MM/yyyy HH.mm");
            Note = ticket.Note;
        }
        public int Id
        {
            get; set;
        }
        public int UserId
        {
            get; set;
        }
        public string UserName
        {
            get; set;
        }
        public int GameId
        {
            get; set;
        }
        public string GameTitle
        {
            get; set;
        }
        public string GetDate
        {
            get; set;
        }
        public string Note
        {
            get; set;
        }
        public List<TicketResultCheck> TicketResults
        {
            get; set;
        }


    }
}