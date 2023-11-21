using MonsterGame.Common;
using MonsterGame.Controller;
using MonsterGame.Model;
using MonsterGame.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonsterGame
{
    public partial class Summary : System.Web.UI.Page
    {
        private User user;
        private LoginController loginSystem = new LoginController();
        protected void Page_Load(object sender, EventArgs e)
        {
            user = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (user == null))
            {
                Response.Redirect("~/Login.aspx");
                return;                                                                 
            }

            if (!IsPostBack)
            {
                LoadStatus();
                LoadGroup();
            }
        }

        private void LoadStatus()
        {
            ComboStatus.Items.Clear();
            ComboStatus.Items.Add(new ListItem("TUTTI ...", "0"));
            ComboStatus.Items.Add(new ListItem("APERTO", ((int)GameStatus.OPEN).ToString()));
            ComboStatus.Items.Add(new ListItem("INIZIATO", ((int)GameStatus.STARTED).ToString()));
            ComboStatus.Items.Add(new ListItem("SCELTA TEAM", ((int)GameStatus.TEAMCHOICE).ToString()));
            ComboStatus.Items.Add(new ListItem("SOSPESO", ((int)GameStatus.SUSPENDED).ToString()));
            ComboStatus.Items.Add(new ListItem("CHIUSO", ((int)GameStatus.CLOSED).ToString()));
            ComboStatus.Items.Add(new ListItem("TERMINATO", ((int)GameStatus.COMPLETED).ToString()));
        }

        private void LoadGroup()
        {
            List<User> groupList = new UserController().FindChildren(user?.Id ?? 0).OrderBy(g => g.Role).ToList();
            List<UserCheck> resultList = new List<UserCheck>();
            foreach (User user in groupList)
            {
                UserCheck usercheck = new UserCheck(user);
                string role = "";
                if (user.Role == (int)Role.AGENCY) role = "R: ";
                else if (user.Role == (int)Role.MASTER) role = "M: ";
                else if (user.Role == (int)Role.ADMIN) role = "A: ";
                usercheck.fullTitle = role + user.Name;
                resultList.Add(usercheck);
            }

            if (loginSystem.IsSuperAdminLoggedIn())
            {
                ControlUtil.DataBind(ComboGroup, resultList, "Id", "fullTitle", "0", "Super Admin");
            }
            else
            {
                ControlUtil.DataBind(ComboGroup, resultList, "Id", "fullTitle", user.Id, user.Name);
            }
        }
    }
}