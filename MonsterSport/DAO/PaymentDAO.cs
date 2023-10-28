using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;

namespace MonsterSport.DAO
{
    public class PaymentResultDAO : BasicDAO
    {
        public PaymentResultDAO() { }
        public List<PaymentResult> FindAll()
        {
            Table<PaymentResult> table = GetContext().PaymentResults;
            return table.ToList();
        }
        public PaymentResult FindByID(int id)
        {
            return GetContext().PaymentResults.Where(g => g.Id == id).FirstOrDefault();
        }
        public List<PaymentResult> FindByUser(int userID)
        {
            return GetContext().PaymentResults.Where(g => g.UserID == userID).ToList();
        }
        public bool Insert(PaymentResult paymentResult)
        {
            GetContext().PaymentResults.InsertOnSubmit(paymentResult);
            GetContext().SubmitChanges();
            return true;
        }

        public bool Update(PaymentResult paymentResult)
        {
            GetContext().SubmitChanges();
            GetContext().Refresh(RefreshMode.OverwriteCurrentValues, paymentResult);
            return true;
        }
        public bool Delete(int id)
        {
            PaymentResult paymentResult = GetContext().PaymentResults.SingleOrDefault(u => u.Id == id);
            GetContext().PaymentResults.DeleteOnSubmit(paymentResult);
            GetContext().SubmitChanges();
            return true;
        }
    }
}