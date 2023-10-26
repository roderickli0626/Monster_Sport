using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;

namespace MonsterSport.DAO
{
    public class GameDAO : BasicDAO
    {
        public GameDAO() { }

        public List<Game> FindAll()
        {
            Table<Game> table = GetContext().Games;
            return table.ToList();
        }
        public Game FindByID(int id)
        {
            return GetContext().Games.Where(g => g.Id == id).FirstOrDefault();
        }
        public bool Insert(Game game)
        {
            GetContext().Games.InsertOnSubmit(game);
            GetContext().SubmitChanges();
            return true;
        }

        public bool Update(Game game)
        {
            GetContext().SubmitChanges();
            GetContext().Refresh(RefreshMode.OverwriteCurrentValues, game);
            return true;
        }
        public bool Delete(int id)
        {
            Game game = GetContext().Games.SingleOrDefault(u => u.Id == id);
            GetContext().Games.DeleteOnSubmit(game);
            GetContext().SubmitChanges();
            return true;
        }
    }
}