using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;

namespace MonsterSport.DAO
{
    public class WinnerDAO : BasicDAO
    {
        public WinnerDAO() { }
        public List<Winner> FindAll()
        {
            Table<Winner> table = GetContext().Winners;
            return table.ToList();
        }
        public Winner FindByID(int id)
        {
            return GetContext().Winners.Where(g => g.Id == id).FirstOrDefault();
        }
        public List<Winner> FindByGame(int gameID)
        {
            return GetContext().Winners.Where(g => g.GameID == gameID).ToList();
        }
        public bool Insert(Winner winner)
        {
            GetContext().Winners.InsertOnSubmit(winner);
            GetContext().SubmitChanges();
            return true;
        }

        public bool Update(Winner winner)
        {
            GetContext().SubmitChanges();
            GetContext().Refresh(RefreshMode.OverwriteCurrentValues, winner);
            return true;
        }
        public bool Delete(int id)
        {
            Winner winner = GetContext().Winners.SingleOrDefault(u => u.Id == id);
            GetContext().Winners.DeleteOnSubmit(winner);
            GetContext().SubmitChanges();
            return true;
        }
    }
}