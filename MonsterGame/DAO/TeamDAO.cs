using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;

namespace MonsterGame.DAO
{
    public class TeamDAO : BasicDAO
    {
        public TeamDAO() { }
        public List<Team> FindAll()
        {
            Table<Team> table = GetContext().Teams;
            return table.ToList();
        }
        public Team FindByID(int id)
        {
            return GetContext().Teams.Where(g => g.Id == id).FirstOrDefault();
        }
        public bool Insert(Team team)
        {
            GetContext().Teams.InsertOnSubmit(team);
            GetContext().SubmitChanges();
            return true;
        }

        public bool Update(Team team)
        {
            GetContext().SubmitChanges();
            GetContext().Refresh(RefreshMode.OverwriteCurrentValues, team);
            return true;
        }
        public bool Delete(int id)
        {
            Team team = GetContext().Teams.SingleOrDefault(u => u.Id == id);
            GetContext().Teams.DeleteOnSubmit(team);
            GetContext().SubmitChanges();
            return true;
        }
    }
}