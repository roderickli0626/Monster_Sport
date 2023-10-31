using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;

namespace MonsterGame.DAO
{
    public class MovementDAO : BasicDAO
    {
        public MovementDAO() { }
        public List<Movement> FindAll()
        {
            Table<Movement> table = GetContext().Movements;
            return table.ToList();
        }
        public Movement FindByID(int id)
        {
            return GetContext().Movements.Where(g => g.Id == id).FirstOrDefault();
        }
        public List<Movement> FindByUser(int userID)
        {
            return GetContext().Movements.Where(g => g.UserID == userID).ToList();
        }
        public bool Insert(Movement movement)
        {
            GetContext().Movements.InsertOnSubmit(movement);
            GetContext().SubmitChanges();
            return true;
        }

        public bool Update(Movement movement)
        {
            GetContext().SubmitChanges();
            GetContext().Refresh(RefreshMode.OverwriteCurrentValues, movement);
            return true;
        }
        public bool Delete(int id)
        {
            Movement movement = GetContext().Movements.SingleOrDefault(u => u.Id == id);
            GetContext().Movements.DeleteOnSubmit(movement);
            GetContext().SubmitChanges();
            return true;
        }
    }
}