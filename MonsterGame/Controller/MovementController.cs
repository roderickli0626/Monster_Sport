using MonsterGame;
using MonsterGame.Common;
using MonsterGame.DAO;
using MonsterGame.Model;
using MonsterGame.Models;
using MonsterSport.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterSport.Controller
{
    public class MovementController
    {
        private MovementDAO movementDAO;
        public MovementController() 
        { 
            movementDAO = new MovementDAO();
        }
        public SearchResult Search(int start, int length, string receiver, string sender, DateTime? from, DateTime? to)
        {
            SearchResult result = new SearchResult();
            IEnumerable<Movement> movementList = movementDAO.FindAll();
            movementList = movementList.Where(m => m.User.Name.Contains(receiver) && ((m.User1?.Name ?? "").Contains(sender)));

            if (from != null)
                movementList = movementList.Where(u => u.MoveDate >= from.Value);

            if (to != null)
                movementList = movementList.Where(u => u.MoveDate <= to.Value);

            result.TotalCount = movementList.Count();
            movementList = movementList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (Movement movement in movementList)
            {
                MovementCheck usercheck = new MovementCheck(movement);
                checks.Add(usercheck);
            }
            result.ResultList = checks;

            return result;
        }
        public bool DeleteMovement(int id)
        {
            Movement movement = movementDAO.FindByID(id);
            if (movement == null) return false;

            return movementDAO.Delete(id);
        }
    }
}