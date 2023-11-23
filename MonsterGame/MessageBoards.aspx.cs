using MonsterGame.Controller;
using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MonsterGame.Model;
using MonsterGame.Common;
using MonsterGame.Util;

namespace MonsterGame
{
    public partial class MessageBoards : System.Web.UI.Page
    {
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
                LoadGames();
                LoadStatus();
            }
        }

        private void LoadGames()
        {
            int status = ControlUtil.GetSelectedValue(ComboStatus) ?? 0;
            GameController gameController = new GameController();
            List<GameCheck> list = gameController.FindAll(0, "", 0);
            if (status == 1) list = list.Where(g => g.AllowedBoard == true).ToList();
            if (status == 2) list = list.Where(g => g.AllowedBoard == false).ToList();
            RepeaterGame.DataSource = list;
            RepeaterGame.DataBind();
        }
        private void LoadStatus()
        {
            ComboStatus.Items.Clear();
            ComboStatus.Items.Add(new ListItem("Tutte", "0"));
            ComboStatus.Items.Add(new ListItem("ABILITATE", "1"));
            ComboStatus.Items.Add(new ListItem("DISABILITATE", "2"));
        }
        protected void ComboStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadGames();
        }
    }
}