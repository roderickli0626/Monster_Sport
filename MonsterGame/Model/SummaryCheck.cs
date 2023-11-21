using MonsterGame;
using MonsterGame.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace MonsterGame.Model
{
    public class SummaryCheck
    {
        User user;
        public SummaryCheck() { }
        public SummaryCheck(User user)
        {
            this.user = user;
            if (user == null) { return; }
            Id = user.Id;
            if (user.Role == (int)Role.USER) { fullTitle = user.Id.ToString() + "\t  U: " + user.Name; }
            else if (user.Role == (int)Role.AGENCY) { fullTitle = user.Id.ToString() + "\t  R: " + user.Name; }
            else if (user.Role == (int)Role.MASTER) { fullTitle = user.Id.ToString() + "\t  M: " + user.Name; }
            else if (user.Role == (int)Role.ADMIN) { fullTitle = user.Id.ToString() + "\t  A: " + user.Name; }
            else fullTitle = "";
            ParentID = user.ParentID ?? 0;
        }
        public int Id
        {
            get; set;
        }
        public string fullTitle
        {
            get; set;
        }

        public double Amount
        {
            get; set;
        }
        public double Prize
        {
            get; set;
        }
        public double Utile
        {
            get; set;
        }
        public int Tickets
        {
            get; set;
        }
        public int Players
        {
            get; set;
        }
        public int ParentID
        {
            get; set;
        }
    }
}