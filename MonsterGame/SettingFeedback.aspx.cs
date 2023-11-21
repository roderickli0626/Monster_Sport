using MonsterGame.Controller;
using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MonsterGame.DAO;

namespace MonsterGame
{
    public partial class SettingFeedback : System.Web.UI.Page
    {
        private User user;
        private LoginController loginSystem = new LoginController();
        private ExtraController extraController = new ExtraController();
        protected void Page_Load(object sender, EventArgs e)
        {
            user = loginSystem.GetCurrentUserAccount();
            if (user == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            string currentPassword = TxtCurrent.Text.Trim();
            string password = TxtPassword.Text.Trim();
            string confirmPW = TxtConfirmPW.Text.Trim();

            if (password != confirmPW)
            {
                ServerValidator2.IsValid = false;
                return;
            }

            if (user.Password != new CryptoController().EncryptStringAES(currentPassword))
            {
                ServerValidator.IsValid = false;
                return;
            }

            user.Password = new CryptoController().EncryptStringAES(password);
            bool success = new UserDAO().Update(user);
            if (!success)
            {
                ServerValidator.IsValid = false;
                return;
            }
            Response.Redirect("~/SettingFeedback.aspx");
        }

        protected void BtnFeedback_Click(object sender, EventArgs e)
        {
            if (!IsValid) 
            {
                return; 
            }
            string title = TxtTitle.Text;
            string description = TxtDescription.Text;

            bool success = extraController.SaveFeedback(title, description, user.Id);
            if (!success)
            {
                ServerValidator1.IsValid = false;
                return;
            }
            Response.Redirect("~/SettingFeedback.aspx");
        }
    }
}