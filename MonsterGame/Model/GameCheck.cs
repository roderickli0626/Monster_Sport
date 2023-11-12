using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame.Model
{
    public class GameCheck
    {
        Game game;
        public GameCheck() { }
        public GameCheck(Game game) 
        { 
            this.game = game;
            if (game == null) return;
            Id = game.Id;
            NumberOfTeams = game.NumberOfTeams ?? 0;
            MinPlayers = game.MinPlayers ?? 0;
            RealPlayers = game.RealPlayers ?? 0;
            Fee = game.Fee ?? 0;
            Tax = game.Tax ?? 0;
            Status = game.Status ?? 0;
            Title = game.Title;
            Note = game.Note;
            StartDate = game.StartDate?.ToString("dd/MM/yyyy HH.mm");
            EndDate = game.EndDate?.ToString("dd/MM/yyyy HH.mm");
            Percent1 = game.PercentForFirst ?? 0;
            Percent2 = game.PercentForSecond ?? 0;
            Percent3 = game.PercentForThird ?? 0;
            Percent4 = game.PercentForForth ?? 0;
            Percent5 = game.PercentForFifth ?? 0;
            Winners = game.NumOfWinners ?? 0;
            Prize = Math.Round(game.Prize ?? 0, 2);
        }
        public int Id
        {
            get; set;
        }
        public int NumberOfTeams 
        {
            get; set;
        }
        public int MinPlayers
        {
            get; set;
        }
        public int RealPlayers
        {
            get; set;
        }
        public double Fee
        {
            get; set;
        }
        public double Tax
        {
            get; set;
        }
        public double Percent1
        {
            get; set;
        }
        public double Percent2
        {
            get; set;
        }
        public double Percent3
        {
            get; set;
        }
        public double Percent4
        {
            get; set;
        }
        public double Percent5
        {
            get; set;
        }
        public int Winners
        {
            get; set;
        }
        public double Prize
        {
            get; set;
        }
        public int Round
        {
            get; set;
        }
        public int Status
        {
            get; set;
        }
        public string Title
        {
            get; set;
        }
        public string Note
        {
            get; set;
        }
        public string Mark
        {
            get; set;
        }
        public string MyMark
        {
            get; set;
        }
        public string Image
        {
            get; set;
        }
        public string ButtonTitle
        {
            get; set;
        }
        public List<int> TeamList
        {
            get; set;
        }
        public string StartDate { get; set; }
        public string EndDate { get; set; }

    }
}