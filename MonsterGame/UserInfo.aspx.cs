using MonsterGame.Common;
using MonsterGame.Controller;
using MonsterGame.Model;
using MonsterGame.Payment.Paypal;
using MonsterGame.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Ajax.Utilities;

namespace MonsterGame
{
    public partial class UserInfo : System.Web.UI.Page
    {
        private User user;
        private LoginController loginSystem = new LoginController();
        protected void Page_Load(object sender, EventArgs e)
        {
            user = loginSystem.GetCurrentUserAccount();
            if (user == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                SetVisible();
                LoadInfo();
                LoadUserGames();
            }
        }
        private void SetVisible()
        {
            if (user.Role != (int)Role.USER)
            {
                liGame.Visible = false;
                DivGameContent.Visible = false;
            }
        }
        private void LoadInfo()
        {
            Balance.InnerText = "€ " + Math.Round(user.Balance ?? 0, 2);
            List<Movement> movements = new MovementController().GetMovementList(user.Id);
            double deposit = 0;
            double withdraw = 0;
            foreach (Movement movement in movements)
            {
                if (user.Role == (int)Role.USER)
                {
                    if (movement.Type == (int)MovementType.DEPOSIT) deposit += (movement.Amount ?? 0);
                    else withdraw += Math.Abs(movement.Amount ?? 0);
                }
                else
                {
                    if (movement.UserID == user.Id)
                    {
                        if (movement.Type == (int)MovementType.DEPOSIT) deposit += (movement.Amount ?? 0);
                        else withdraw += Math.Abs(movement.Amount ?? 0);
                    }
                    else
                    {
                        if (movement.Type == (int)MovementType.DEPOSIT) withdraw += Math.Abs(movement.Amount ?? 0);
                        else deposit += Math.Abs(movement.Amount ?? 0);
                    }
                }
            }
            Deposit.InnerText = "€ " + Math.Round(deposit, 2);
            Withdraw.InnerText = "€ " + Math.Round(withdraw, 2);
        }
        private void LoadUserGames()
        {
            GameController gameController = new GameController();
            List<GameCheck> list = gameController.FindUserGames(user.Id);
            RepeaterGame.DataSource = list;
            RepeaterGame.DataBind();
        }

        protected void BtnPurchase_Click(object sender, EventArgs e)
        {
            //Pay with paypal
            double total = ParseUtil.TryParseDouble(TxtAmount.Text) ?? 0;
            if (total <= 0)
            {
                PaypalAmount.IsValid = false;
                return;
            }
            PaymentDetails pd = new PaymentDetails();
            pd.Set("ArticleNumber", "Article Number");

            Random zufall = new Random();
            DateTime dt = DateTime.Now;
            string invoiceNumber = dt.Year.ToString() + dt.Month.ToString() + dt.Day.ToString() + dt.Hour.ToString() + dt.Minute.ToString() + dt.Second.ToString() + Convert.ToString(zufall.Next(-100, 100)).PadLeft(2, '0');
            pd.Set("InvoiceNumber", invoiceNumber);
            pd.Set("ItemDescription", "Payment Detail Description");
            pd.Set("ItemName", "Name of Item");
            pd.Set("Quantity", "1");
            pd.Set("Total", total.ToString());
            pd.Set("Execute", "command to execute after payment");

            PaymentPrepare pp = new PaymentPrepare();
            pp.PaymentDetails = pd;
            pp.Description = "Payment description";
            string baseUrl = Request.Url.ToString().Substring(0, Request.Url.ToString().LastIndexOf("/"));
            pp.UrlCancel = baseUrl + "/PaymentCancel.aspx";
            pp.UrlReturn = baseUrl + "/PaymentComplete.aspx";

            var payment = pp.CreatePayment();
            string paymentId = payment.id;
            pd.Set(pd.PaymentId, paymentId);
            Session[paymentId] = pd;
            // Register JavaScript code to open PayPal payment URL in a new tab
            string script = "window.open('" + payment.GetApprovalUrl() + "', '_blank');";
            ScriptManager.RegisterStartupScript(this, GetType(), "OpenPayPalTab", script, true);
            //Response.Redirect(payment.GetApprovalUrl());
        }
    }
}