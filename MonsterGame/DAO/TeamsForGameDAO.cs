using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;

namespace MonsterGame.DAO
{
    public class TeamsForGameDAO : BasicDAO
    {
        public TeamsForGameDAO() { }
        public List<TeamsForGame> FindAll()
        {
            Table<TeamsForGame> table = GetContext().TeamsForGames;
            return table.ToList();
        }
        public TeamsForGame FindByID(int id)
        {
            return GetContext().TeamsForGames.Where(g => g.Id == id).FirstOrDefault();
        }
        public List<TeamsForGame> FindByGame(int gameID)
        {
            return GetContext().TeamsForGames.Where(g => g.GameID == gameID).ToList();
        }
        public bool Insert(TeamsForGame teamsForGame)
        {
            GetContext().TeamsForGames.InsertOnSubmit(teamsForGame);
            GetContext().SubmitChanges();
            return true;
        }

        public bool Update(TeamsForGame teamsForGame)
        {
            GetContext().SubmitChanges();
            GetContext().Refresh(RefreshMode.OverwriteCurrentValues, teamsForGame);
            return true;
        }
        public bool Delete(int id)
        {
            TeamsForGame teamsForGame = GetContext().TeamsForGames.SingleOrDefault(u => u.Id == id);
            GetContext().TeamsForGames.DeleteOnSubmit(teamsForGame);
            GetContext().SubmitChanges();
            return true;
        }

        public bool DeleteByGame(int gameID)
        {
            List<TeamsForGame> teams = GetContext().TeamsForGames.Where(t => t.GameID == gameID).ToList();
            GetContext().TeamsForGames.DeleteAllOnSubmit(teams);
            GetContext().SubmitChanges();
            return true;
        }
    }
}