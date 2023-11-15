using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame.Model
{
    public class TeamCheck
    {
        Team team;
        public TeamCheck() { }
        public TeamCheck(Team team) 
        { 
            this.team = team;
            if (team == null) return;
            Id = team.Id;
            Description = team.Description + "\t||\t" + team.Note;
        }

        public int Id
        {
            get; set;
        }
        public string Description
        {
            get; set;
        }
    }
}