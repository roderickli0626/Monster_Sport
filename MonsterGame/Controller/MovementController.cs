using MonsterGame;
using MonsterGame.Common;
using MonsterGame.DAO;
using MonsterGame.Model;
using MonsterGame.Models;
using MonsterGame.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame.Controller
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
            IEnumerable<Movement> movementList = movementDAO.FindAll().OrderByDescending(m => m.MoveDate);
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

        public SearchResult SearchUserMovement(int start, int length, string transfer, DateTime? from, DateTime? to, int userID)
        {
            SearchResult result = new SearchResult();
            IEnumerable<Movement> movementList = movementDAO.FindByUser(userID).OrderByDescending(m => m.MoveDate);
            movementList = movementList.Where(m => m.User.Name.ToLower().Contains(transfer.ToLower()) || ((m.User1?.Name.ToLower() ?? "").Contains(transfer.ToLower())));

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
                if (usercheck.ReceiverID == userID)
                {
                    usercheck.Transfer = usercheck.Sender;
                }
                else
                {
                    usercheck.Transfer = usercheck.Receiver;
                    if (usercheck.Type == (int)MovementType.WITHDRAWAL)
                    {
                        usercheck.Type = (int)MovementType.DEPOSIT;
                        usercheck.Amount = Math.Abs(usercheck.Amount);
                    }
                    else
                    {
                        usercheck.Type = (int)MovementType.WITHDRAWAL;
                        usercheck.Amount = 0 - (usercheck.Amount);
                    }
                }
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
        public List<Movement> GetMovementList(int userId)
        {
            List<Movement> result = movementDAO.FindByUser(userId);
            return result;
        }

        public bool Add(int userID, double amount)
        {
            Movement movement = new Movement();
            movement.UserID = userID;
            movement.Amount = amount;
            movement.MoveDate = DateTime.Now;
            movement.SenderID = userID;
            movement.Type = (int)MovementType.DEPOSIT;
            movement.Note = "Purchased with paypal";
            return movementDAO.Insert(movement);
        }
    }
}