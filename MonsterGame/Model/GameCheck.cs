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
        public string Image
        {
            get; set;
        }
        public string ButtonTitle
        {
            get; set;
        }
        public string StartDate { get; set; }
        public string EndDate { get; set; }

    }
}