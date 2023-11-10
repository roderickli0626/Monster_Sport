using MonsterGame.Common;
using MonsterGame.Controller;
using MonsterGame.DAO;
using MonsterGame.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonsterGame
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private User user;
        private LoginController loginSystem = new LoginController();
        protected void Page_Load(object sender, EventArgs e)
        {
            user = loginSystem.GetCurrentUserAccount();
            if (user != null || loginSystem.IsSuperAdminLoggedIn())
            {
                InDiv.Visible = false;
            }
            else
            {
                OutDiv.Visible = false;
                AllGameDiv.Visible = false;
                AllGameSearchDiv.Visible = false;
            }

            if (!IsPostBack)
            {
                LoadGames();
                LoadStatus();
            }
        }

        private void LoadStatus()
        {
            ComboStatus.Items.Clear();
            ComboStatus.Items.Add(new ListItem("ALL STATUS", "0"));
            ComboStatus.Items.Add(new ListItem("OPEN", ((int)GameStatus.OPEN).ToString()));
            ComboStatus.Items.Add(new ListItem("STARTED", ((int)GameStatus.STARTED).ToString()));
            ComboStatus.Items.Add(new ListItem("TEAMCHOICE", ((int)GameStatus.TEAMCHOICE).ToString()));
            ComboStatus.Items.Add(new ListItem("SUSPENDED", ((int)GameStatus.SUSPENDED).ToString()));
            ComboStatus.Items.Add(new ListItem("CLOSED", ((int)GameStatus.CLOSED).ToString()));
            ComboStatus.Items.Add(new ListItem("COMPLETED", ((int)GameStatus.COMPLETED).ToString()));
        }

        private void LoadGames()
        {
            GameController gameController = new GameController();
            List<GameCheck> list = gameController.FindOpenGames();
            RepeaterGame.DataSource = list;
            RepeaterGame.DataBind();
        }
    }
}