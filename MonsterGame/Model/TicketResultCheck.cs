using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame.Model
{
    public class TicketResultCheck
    {
        TicketResult ticketResult;
        public TicketResultCheck() { }
        public TicketResultCheck(TicketResult ticketResult)
        {
            this.ticketResult = ticketResult;
            if (ticketResult == null ) { return; }
            Id = ticketResult.Id;
            TicketId = ticketResult.TicketID ?? 0;
            RoundNo = ticketResult.RoundNo ?? 0;
            TeamID = ticketResult.TeamID ?? 0;
            TeamName = ticketResult.Team?.Description ?? "";
            RoundResult = ticketResult.RoundResult;
            Note = ticketResult.Note;
        }

        public int Id
        {
            get; set;
        }
        public int TicketId
        {
            get; set;
        }
        public int RoundNo
        {
            get; set;
        }
        public int TeamID
        {
            get; set;
        }
        public string TeamName
        {
            get; set;
        }
        public int? RoundResult
        {
            get; set;
        }
        public string Note
        {
            get; set;
        }
    }
}