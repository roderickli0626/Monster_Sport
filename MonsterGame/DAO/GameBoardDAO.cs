using MonsterGame;
using MonsterGame.DAO;
using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;

namespace MonsterGame.DAO
{
    public class GameBoardDAO : BasicDAO
    {
        public GameBoardDAO() { }
        public List<GameBoard> FindAll()
        {
            Table<GameBoard> table = GetContext().GameBoards;
            return table.ToList();
        }
        public List<GameBoard> FindByGame(int gameID)
        {
            return GetContext().GameBoards.Where(g => g.GameID == gameID).ToList();
        }
        public GameBoard FindByID(int id)
        {
            return GetContext().GameBoards.Where(g => g.Id == id).FirstOrDefault();
        }
        public int Insert(GameBoard gameboard)
        {
            GetContext().GameBoards.InsertOnSubmit(gameboard);
            GetContext().SubmitChanges();
            return gameboard.Id;
        }

        public bool Update(GameBoard gameboard)
        {
            GetContext().SubmitChanges();
            GetContext().Refresh(RefreshMode.OverwriteCurrentValues, gameboard);
            return true;
        }
        public bool Delete(int id)
        {
            GameBoard gameboard = GetContext().GameBoards.SingleOrDefault(u => u.Id == id);
            GetContext().GameBoards.DeleteOnSubmit(gameboard);
            GetContext().SubmitChanges();
            return true;
        }
    }
}