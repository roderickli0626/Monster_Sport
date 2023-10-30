﻿using MonsterSport.Controller;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonsterSport
{
    public partial class Page : System.Web.UI.MasterPage
    {
        private User user;
        private LoginController loginSystem = new LoginController();
        protected void Page_Load(object sender, EventArgs e)
        {
            user = loginSystem.GetCurrentUserAccount();

            if (loginSystem.IsSuperAdminLoggedIn())
            {
                liUserGame.Visible = false;
                liLogin.Visible = false;
                liInfo.Visible = false;
                liName.InnerText = "Super Admin";
            }
            else if (loginSystem.IsAdminLoggedIn())
            {
                liAdminGame.Visible = false;
                liUserGame.Visible = false;
                liAdmin.Visible = false;
                liMovement.Visible = false;
                liLogin.Visible = false;
            }
            else if (loginSystem.IsMasterLoggedIn())
            {
                liAdminGame.Visible = false;
                liUserGame.Visible = false;
                liAdmin.Visible = false;
                liMaster.Visible = false;
                liMovement.Visible = false;
                liLogin.Visible = false;
            }
            else if (loginSystem.IsAgencyLoggedIn())
            {
                liAdminGame.Visible = false;
                liUserGame.Visible = false;
                liAdmin.Visible = false;
                liMaster.Visible = false;
                liAgency.Visible = false;
                liMovement.Visible = false;
                liLogin.Visible = false;
            }
            else if (loginSystem.IsUserLoggedIn())
            {
                liAdminGame.Visible = false;
                liAdmin.Visible = false;
                liMaster.Visible = false;
                liAgency.Visible = false;
                liUser.Visible = false;
                liMovement.Visible = false;
                liLogin.Visible = false;
            }
            else
            {
                liAdminGame.Visible = false;
                liUserGame.Visible = false;
                liAdmin.Visible = false;
                liMaster.Visible = false;
                liAgency.Visible = false;
                liUser.Visible = false;
                liMovement.Visible = false;
                liUserInfo.Visible = false;
            }

            if (user != null)
            {
                liName.InnerText = user.Name;
            }
        }
    }
}