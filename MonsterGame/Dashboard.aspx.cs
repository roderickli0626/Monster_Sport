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
                if (loginSystem.IsSuperAdminLoggedIn())
                {
                    AllGameDiv.Visible = false;
                    AllGameSearchDiv.Visible = false;
                }
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
            ComboStatus.Items.Add(new ListItem("TUTTI", "0"));
            ComboStatus.Items.Add(new ListItem("APERTO", ((int)GameStatus.OPEN).ToString()));
            ComboStatus.Items.Add(new ListItem("INIZIATO", ((int)GameStatus.STARTED).ToString()));
            ComboStatus.Items.Add(new ListItem("SCELTA TEAM", ((int)GameStatus.TEAMCHOICE).ToString()));
            ComboStatus.Items.Add(new ListItem("SOSPESO", ((int)GameStatus.SUSPENDED).ToString()));
            ComboStatus.Items.Add(new ListItem("CHIUSO", ((int)GameStatus.CLOSED).ToString()));
            ComboStatus.Items.Add(new ListItem("TERMINATO", ((int)GameStatus.COMPLETED).ToString()));
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