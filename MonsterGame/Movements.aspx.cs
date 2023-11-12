using MonsterGame.Controller;
using MonsterGame.DAO;
using MonsterGame.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonsterGame
{
    public partial class Movements : System.Web.UI.Page
    {
        private User user;
        private LoginController loginSystem = new LoginController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!loginSystem.IsSuperAdminLoggedIn())
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadTransfers();
            }
        }

        private void LoadTransfers()
        {
            List<User> users = new UserDAO().FindAll().OrderBy(u => u.Name).ToList();
            ControlUtil.DataBind(ComboReceiver, users, "Name", "Name", "", "RECEIVER");
            ControlUtil.DataBind(ComboSender, users, "Name", "Name", "", "SENDER");
        }
    }
}