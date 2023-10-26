using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;

namespace MonsterSport.DAO
{
    public class PaymentDAO : BasicDAO
    {
        public PaymentDAO() { }
        public List<Payment> FindAll()
        {
            Table<Payment> table = GetContext().Payments;
            return table.ToList();
        }
        public Payment FindByID(int id)
        {
            return GetContext().Payments.Where(g => g.Id == id).FirstOrDefault();
        }
        public List<Payment> FindByUser(int userID)
        {
            return GetContext().Payments.Where(g => g.UserID == userID).ToList();
        }
        public bool Insert(Payment payment)
        {
            GetContext().Payments.InsertOnSubmit(payment);
            GetContext().SubmitChanges();
            return true;
        }

        public bool Update(Payment payment)
        {
            GetContext().SubmitChanges();
            GetContext().Refresh(RefreshMode.OverwriteCurrentValues, payment);
            return true;
        }
        public bool Delete(int id)
        {
            Payment payment = GetContext().Payments.SingleOrDefault(u => u.Id == id);
            GetContext().Payments.DeleteOnSubmit(payment);
            GetContext().SubmitChanges();
            return true;
        }
    }
}