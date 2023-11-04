using MonsterGame;
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
    public class PaymentController
    {
        PaymentResultDAO paymentResultDAO;
        public PaymentController() 
        {
            paymentResultDAO = new PaymentResultDAO();
        }

        public SearchResult Search(int start, int length, string searchVal, int userID)
        {
            SearchResult result = new SearchResult();
            IEnumerable<PaymentResult> paymentList = paymentResultDAO.FindByUser(userID);
            paymentList = paymentList.Where(p => p.PaypalTransition.Contains(searchVal));

            result.TotalCount = paymentList.Count();
            paymentList = paymentList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (PaymentResult payment in paymentList)
            {
                PaymentCheck paymentCheck = new PaymentCheck(payment);
                checks.Add(paymentCheck);
            }
            result.ResultList = checks;

            return result;
        }

        public bool Add(int userID, double amount, string paymentID)
        {
            PaymentResult paymentResult = new PaymentResult();
            paymentResult.UserID = userID;
            paymentResult.Amount = amount;
            paymentResult.DateOfPay = DateTime.Now;
            paymentResult.PaypalTransition = paymentID;
            return paymentResultDAO.Insert(paymentResult);
        }

    }
}