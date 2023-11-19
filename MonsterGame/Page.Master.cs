using MonsterGame.Controller;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonsterGame
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
                liDashboard.Visible = false;
                liUserGame.Visible = false;
                liLogin.Visible = false;
                liInfo.Visible = false;
                liBoard.Visible = false;
                liSetting.Visible = false;
                liContact.Visible = false;
                liName1.Visible = false;
                liName2.Visible = false;
                liEye.Visible = false;
                liName0.InnerText = "Super Admin";
                liName.InnerText = "Super Admin";
            }
            else if (loginSystem.IsAdminLoggedIn())
            {
                liAdminGame.Visible = false;
                liUserGame.Visible = false;
                liAdmin.Visible = false;
                liMovement.Visible = false;
                liLogin.Visible = false;
                liBoard.Visible = false;
                liBoards.Visible = false;
                liFeedback.Visible = false;
            }
            else if (loginSystem.IsMasterLoggedIn())
            {
                liAdminGame.Visible = false;
                liUserGame.Visible = false;
                liAdmin.Visible = false;
                liMaster.Visible = false;
                liMovement.Visible = false;
                liLogin.Visible = false;
                liBoard.Visible = false;
                liBoards.Visible = false;
                liFeedback.Visible = false;
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
                liBoard.Visible = false;
                liBoards.Visible = false;
                liFeedback.Visible = false;
            }
            else if (loginSystem.IsUserLoggedIn())
            {
                liDashboard.Visible = false;
                liAdminGame.Visible = false;
                liAdmin.Visible = false;
                liMaster.Visible = false;
                liAgency.Visible = false;
                liUser.Visible = false;
                liMovement.Visible = false;
                liLogin.Visible = false;
                liBoards.Visible = false;
                liFeedback.Visible = false;
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
                liExtra.Visible = false;
            }

            if (user != null)
            {
                liName0.InnerText = user.Name;
                liName1.InnerText = "|| balance:";
                liName2.InnerText = "€ " + Math.Round(user.Balance ?? 0, 2).ToString();
                liName.InnerText = user.Name;
            }
        }
    }
}