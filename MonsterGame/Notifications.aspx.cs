using MonsterGame.Common;
using MonsterGame.Controller;
using MonsterGame.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MonsterGame
{
    public partial class Notifications : System.Web.UI.Page
    {
        private User admin;
        private LoginController loginSystem = new LoginController();
        private ExtraController extraController = new ExtraController();
        protected void Page_Load(object sender, EventArgs e)
        {
            admin = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (admin == null))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            HfUserID.Value = (admin?.Id ?? 0).ToString();
            if (!IsPostBack)
            {
                if (loginSystem.IsSuperAdminLoggedIn())
                {
                    HfManage.Value = "true";
                }
                else
                {
                    HfManage.Value = "false";
                    BtnSave.Visible = false;
                    BtnAddNews.Visible = false;
                }
            }
        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            if (!IsValid) return;
            string title = TxtTitle.Text;
            string description = TxtDescription.Text;

            int? notificationID = ParseUtil.TryParseInt(HfNotificationID.Value);

            bool success = extraController.SaveNews(notificationID, title, description);
            if (success)
            {
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else
            {
                ServerValidator.IsValid = false;
                return;
            }
        }
    }
}