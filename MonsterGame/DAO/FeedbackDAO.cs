using MonsterGame;
using MonsterGame.DAO;
using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;

namespace MonsterGame.DAO
{
    public class FeedbackDAO : BasicDAO
    {
        public FeedbackDAO() { }
        public List<Feedback> FindAll()
        {
            Table<Feedback> table = GetContext().Feedbacks;
            return table.ToList();
        }
        public Feedback FindByID(int id)
        {
            return GetContext().Feedbacks.Where(g => g.Id == id).FirstOrDefault();
        }
        public bool Insert(Feedback feedback)
        {
            GetContext().Feedbacks.InsertOnSubmit(feedback);
            GetContext().SubmitChanges();
            return true;
        }

        public bool Update(Feedback feedback)
        {
            GetContext().SubmitChanges();
            GetContext().Refresh(RefreshMode.OverwriteCurrentValues, feedback);
            return true;
        }
        public bool Delete(int id)
        {
            Feedback feedback = GetContext().Feedbacks.SingleOrDefault(u => u.Id == id);
            GetContext().Feedbacks.DeleteOnSubmit(feedback);
            GetContext().SubmitChanges();
            return true;
        }
    }
}