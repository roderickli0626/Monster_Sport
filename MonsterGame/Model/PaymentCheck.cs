using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame.Model
{
    public class PaymentCheck
    {
        PaymentResult paymentResult;
        public PaymentCheck() { }
        public PaymentCheck(PaymentResult paymentResult)
        {
            this.paymentResult = paymentResult;
            if (paymentResult == null) { return; }
            Id = paymentResult.Id;
            PayDate = paymentResult.DateOfPay?.ToString("dd/MM/yyyy HH.mm");
            Amount = Math.Round(paymentResult.Amount ?? 0, 2);
            Transition = paymentResult.PaypalTransition;
            Note = paymentResult.Note;
        }
        public int Id
        {
            get; set;
        }
        public string PayDate
        {
            get; set;
        }
        public double Amount
        {
            get; set;
        }
        public string Transition
        {
            get; set;
        }
        public string Note
        {
            get; set;
        }
    }
}