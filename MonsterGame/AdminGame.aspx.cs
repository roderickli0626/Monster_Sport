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
using MonsterGame.DAO;
using PayPal.Api;

namespace MonsterGame
{
    public partial class AdminGame : System.Web.UI.Page
    {
        private User user;
        private LoginController loginSystem = new LoginController();
        private GameController gameController = new GameController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!loginSystem.IsSuperAdminLoggedIn()) 
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                //LoadGames();
                LoadStatus();
                LoadTeams();
            }
        }
        private void LoadTeams()
        {
            List<Team> teams = new TeamDAO().FindAll();
            ControlUtil.DataBind(ComboTeams, teams, "Id", "Description");
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
            ComboModalStatus.Items.Clear();
            ComboModalStatus.Items.Add(new ListItem("OPEN", ((int)GameStatus.OPEN).ToString()));
            ComboModalStatus.Items.Add(new ListItem("STARTED", ((int)GameStatus.STARTED).ToString()));
            ComboModalStatus.Items.Add(new ListItem("TEAMCHOICE", ((int)GameStatus.TEAMCHOICE).ToString()));
            ComboModalStatus.Items.Add(new ListItem("SUSPENDED", ((int)GameStatus.SUSPENDED).ToString()));
            ComboModalStatus.Items.Add(new ListItem("CLOSED", ((int)GameStatus.CLOSED).ToString()));
            ComboModalStatus.Items.Add(new ListItem("COMPLETED", ((int)GameStatus.COMPLETED).ToString()));
        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            if (!IsValid) { return; }
            string title = TxtTitle.Text;
            DateTime? sdate = ParseUtil.TryParseDate(TxtStartDate.Text, "dd/MM/yyyy HH.mm");
            DateTime? edate = ParseUtil.TryParseDate(TxtEndDate.Text, "dd/MM/yyyy HH.mm");
            double fee = ParseUtil.TryParseDouble(TxtFee.Text) ?? 0;
            double tax = ParseUtil.TryParseDouble(TxtTax.Text) ?? 0;
            int status = ControlUtil.GetSelectedValue(ComboStatus) ?? (int)GameStatus.OPEN;
            int minPlayers = ParseUtil.TryParseInt(TxtMinPlayers.Text) ?? 0;
            int teamNum = ParseUtil.TryParseInt(TxtTeamNum.Text) ?? 0;
            string note = TxtNote.Text;
            double percent1 = ParseUtil.TryParseDouble(TxtPercent1.Text) ?? 0;
            double percent2 = ParseUtil.TryParseDouble(TxtPercent2.Text) ?? 0;
            double percent3 = ParseUtil.TryParseDouble(TxtPercent3.Text) ?? 0;
            double percent4 = ParseUtil.TryParseDouble(TxtPercent4.Text) ?? 0;
            double percent5 = ParseUtil.TryParseDouble(TxtPercent5.Text) ?? 0;
            int NumOfWinners = ParseUtil.TryParseInt(TxtWinners.Text) ?? 0;

            string[] selectedValues = Request.Form.GetValues(ComboTeams.UniqueID);
            List<int> teamList = new List<int>();
            foreach (string itemID in selectedValues)
            {
                int selectedValue = ParseUtil.TryParseInt(itemID) ?? 0;
                teamList.Add(selectedValue);
            }

            int? gameID = ParseUtil.TryParseInt(HfGameID.Value);
            bool success = gameController.SaveGame(gameID, title, sdate, edate, fee, tax, status, minPlayers, teamNum, note, percent1, percent2, percent3, percent4, percent5, NumOfWinners, teamList);
            if (!success)
            {
                ServerValidator.IsValid = false;
                return;
            }

            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }
    }
}