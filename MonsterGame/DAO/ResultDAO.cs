using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;

namespace MonsterGame.DAO
{
    public class ResultDAO : BasicDAO
    {
        public ResultDAO() { }
        public List<Result> FindAll()
        {
            Table<Result> table = GetContext().Results;
            return table.ToList();
        }
        public Result FindByID(int id)
        {
            return GetContext().Results.Where(g => g.Id == id).FirstOrDefault();
        }
        public Result FindByGameAndTeamAndRound(int gameID, int teamID, int round)
        {
            return GetContext().Results.Where(g => g.TeamsForGame.Game.Id == gameID && g.TeamsForGame.TeamID == teamID && g.RoundNo == round).FirstOrDefault();
        }
        public List<Result> FindByGame(int gameID)
        {
            return GetContext().Results.Where(g => g.TeamsForGame.Game.Id == gameID).ToList();
        }
        public List<Result> FindByTeamsForGame(int teamsForGameID)
        {
            return GetContext().Results.Where(g => g.TeamForGameID == teamsForGameID).ToList();
        }
        public bool Insert(Result result)
        {
            GetContext().Results.InsertOnSubmit(result);
            GetContext().SubmitChanges();
            return true;
        }

        public bool Update(Result result)
        {
            GetContext().SubmitChanges();
            GetContext().Refresh(RefreshMode.OverwriteCurrentValues, result);
            return true;
        }
        public bool Delete(int id)
        {
            Result result = GetContext().Results.SingleOrDefault(u => u.Id == id);
            GetContext().Results.DeleteOnSubmit(result);
            GetContext().SubmitChanges();
            return true;
        }
    }
}