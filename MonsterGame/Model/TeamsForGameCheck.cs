using MonsterGame;
using MonsterGame.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame.Model
{
    public class TeamsForGameCheck
    {
        TeamsForGame teamsForGame;
        public TeamsForGameCheck() { }
        public TeamsForGameCheck(TeamsForGame teamsForGame)
        {
            this.teamsForGame = teamsForGame;
            if (teamsForGame == null) { return; }
            Id = teamsForGame.Id;
            TeamId = teamsForGame.TeamID ?? 0;
            TeamName = teamsForGame.Team.Description;
            GameId = teamsForGame.GameID ?? 0;
            GameTitle = teamsForGame.Game.Title;
            Note = teamsForGame.Note;
        }
        public int Id
        {
            get; set;
        }
        public int TeamId
        {
            get; set;
        }
        public string TeamName
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
        public string Note
        {
            get; set;
        }
        public List<ResultCheck> Results
        {
            get; set;
        }
    }
}