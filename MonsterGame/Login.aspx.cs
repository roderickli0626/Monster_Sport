﻿using MonsterGame.Common;
using MonsterGame.Controller;
using MonsterGame.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonsterGame
{
    public partial class Login : System.Web.UI.Page
    {
        LoginController loginSystem = new LoginController();
        protected void Page_Load(object sender, EventArgs e)
        {
            string email = Request.Params["email"];
            string password = Request.Params["pass"];
            if (!string.IsNullOrEmpty(email) && !string.IsNullOrEmpty(password))
            {
                // Auto Login
                EncryptedPass pass = new EncryptedPass() { Encrypted = new CryptoController().EncryptStringAES(password), UnEncrypted = password };
                LoginUser(email, pass);
            }

            if (!IsPostBack)
            {
                SessionController sessionController = new SessionController();
                sessionController.LogoutUser();
            }
        }

        protected void BtnLogIn_Click(object sender, EventArgs e)
        {
            if (!IsValid) { return; }

            string email = TxtEmail.Text;
            string password = TxtPassword.Text;
            EncryptedPass pass = new EncryptedPass() { Encrypted = new CryptoController().EncryptStringAES(password), UnEncrypted = password };

            LoginUser(email, pass);
        }

        private void LoginUser(string email, EncryptedPass pass)
        {
            LoginCode loginStatus = loginSystem.LoginAndSaveSession(email, pass);

            if (loginStatus == LoginCode.Success)
            {
                if (loginSystem.IsSuperAdminLoggedIn())
                {
                    Response.Redirect("~/AdminGame.aspx");
                }
                else if (loginSystem.IsUserLoggedIn())
                {
                    Response.Redirect("~/UserGame.aspx");
                }
                else 
                {
                    Response.Redirect("~/Dashboard.aspx");
                }
            }
            else
            {
                ServerValidator.IsValid = false;
                return;
            }
        }
    }
}