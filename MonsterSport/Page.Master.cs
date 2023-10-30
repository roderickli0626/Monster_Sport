using MonsterSport.Controller;
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

            }
            else if (loginSystem.IsAdminLoggedIn())
            {

            }
            else if (loginSystem.IsMasterLoggedIn())
            {

            }
            else if (loginSystem.IsAgencyLoggedIn())
            {

            }
            else if (loginSystem.IsUserLoggedIn())
            { 

            }
            else
            {

            }
        }
    }
}