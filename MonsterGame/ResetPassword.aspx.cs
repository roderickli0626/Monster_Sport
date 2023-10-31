using MonsterGame.Controller;
using MonsterGame.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonsterGame
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        private string email;
        private string token;
        private UserDAO userDAO = new UserDAO();
        protected void Page_Load(object sender, EventArgs e)
        {
            email = Request.Params["email"];
            token = Request.Params["token"];
            if (email == null || token == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            User user = userDAO.FindByEmail(email);
            if (user == null) Response.Redirect("~/Login.aspx");
            string modelToken = user.ResetToken;
            DateTime? tokenExpire = user.ResetTokenExpiry;
            DateTime currentDateTime = DateTime.Now;
            if (tokenExpire < currentDateTime || modelToken != token) Response.Redirect("~/Login.aspx");
        }

        protected void ResetPW_Click(object sender, EventArgs e)
        {
            if (!IsValid) return;
            string password = TxtPassword.Text.Trim();
            string repeatPW = TxtRepeatPW.Text.Trim();

            if (password != repeatPW)
            {
                ServerValidator.IsValid = false; return;
            }

            User user = userDAO.FindByEmail(email);
            if (user == null) { return; }
            if (!string.IsNullOrEmpty(password)) user.Password = new CryptoController().EncryptStringAES(password);
            userDAO.Update(user);
            Response.Redirect("~/Login.aspx");
        }
    }
}