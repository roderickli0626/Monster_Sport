using Antlr.Runtime.Tree;
using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;

namespace MonsterSport.Model
{
    public class UserCheck
    {
        User user;
        public UserCheck() { }
        public UserCheck(User user)
        {
            this.user = user;
            if (user == null) return;
            Id = user.Id;
            Name = user.Name;
            NickName = user.NickName;
            Surname = user.Surname;
            Mobile = user.Mobile;
            Note = user.Note;
            Balance = user.Balance ?? 0;
            Email = user.Email;
            ParentID = user.ParentID ?? 0;
            Role = user.Role;
        }
        public int Id
        {
            get; set;
        }
        public string Name
        {
            get; set;
        }
        public string NickName
        {
            get; set;
        }
        public string Surname
        {
            get; set;
        }
        public string Email
        {
            get; set;
        }
        public string Mobile
        {
            get; set;
        }
        public string Note
        {
            get; set;
        }
        public int Role
        {
            get; set;
        }
        public int ParentID
        {
            get; set;
        }
        public double Balance
        {
            get; set;
        }
        public string admin
        {
            get; set;
        }
        public string master
        {
            get; set;
        }
        public string agency
        {
            get; set;
        }
    }
}