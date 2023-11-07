using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;

namespace MonsterGame.Model
{
    public class WinnerCheck
    {
        Winner winner;
        public WinnerCheck() { }
        public WinnerCheck(Winner winner)
        {
            this.winner = winner;
            if (winner == null) return;
            Id = winner.Id;
            UserId = winner.UserID ?? 0;
            Winner = winner.User.Name;
            GameId = winner.GameID ?? 0;
            GameTitle = winner.Game.Title;
            Prize = winner.Prize;
            Percent = winner.Rate ?? 0;
            WinDate = winner.WinDate?.ToString("dd/MM/yyyy HH.mm");
            Note = winner.Note;
        }

        public int Id
        {
            get; set;
        }
        public int UserId
        {
            get; set;
        }
        public string Winner
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
        public double? Prize
        {
            get; set;
        }
        public double Percent
        {
            get; set;
        }
        public string WinDate
        {
            get; set;
        }
        public string Note
        {
            get; set;
        }
    }
}