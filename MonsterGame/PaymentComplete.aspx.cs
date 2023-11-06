using MonsterGame;
using MonsterGame.Controller;
using MonsterGame.Payment.Paypal;
using MonsterGame.Util;
using MonsterGame.Controller;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonsterGame
{
    public partial class PaymentComplete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User user = new LoginController().GetCurrentUserAccount();
            if (user == null)
            {
                Response.Redirect("~/UserInfo.aspx");
                return;
            }

            string paymentId = string.Empty;
            if (!String.IsNullOrEmpty(Request.QueryString["paymentId"]))
                paymentId = Request.QueryString["paymentId"];

            string token = "-";
            if (!String.IsNullOrEmpty(Request.QueryString["token"]))
                token = Request.QueryString["token"];

            string PayerId = "-";
            if (!String.IsNullOrEmpty(Request.QueryString["PayerID"]))
                PayerId = Request.QueryString["PayerID"];

            Label label = new Label();
            label.Text = "Pagamento Id: " + paymentId + "<br />";
            divPaymentDetails.Controls.Add(label);

            label = new Label();
            label.Text = "Cliente Id: " + PayerId + "<br />";
            divPaymentDetails.Controls.Add(label);

            label = new Label();
            label.Text = "Numero Fattura: " + GetPaymentDetails(paymentId, "InvoiceNumber") + "<br />";
            divPaymentDetails.Controls.Add(label);

            label = new Label();
            label.Text = "Item Name: " + GetPaymentDetails(paymentId, "ItemName") + "<br />";
            divPaymentDetails.Controls.Add(label);

            UserController userController = new UserController();
            PaymentController paymentController = new PaymentController();
            MovementController movementController = new MovementController();
            double amount = ParseUtil.TryParseDouble(GetPaymentDetails(paymentId, "Total")) ?? 0;
            user.Balance = (user.Balance ?? 0) + amount;
            paymentController.Add(user.Id, amount, paymentId);
            movementController.Add(user.Id, amount);
        }

        string GetPaymentDetails(string paymentId, string key)
        {
            PaymentDetails pd = (PaymentDetails)Session[paymentId];

            string value = pd.GetString(key);
            if (String.IsNullOrEmpty(value))
                return string.Empty;
            else
                return value;
        }
    }
}