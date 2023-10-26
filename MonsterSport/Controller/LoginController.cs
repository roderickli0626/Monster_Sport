using MonsterSport.Common;
using MonsterSport.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;

namespace MonsterSport.Controller
{
    public class EncryptedPass
    {
        public string Encrypted { get; set; }
        public string UnEncrypted { get; set; }

    }
    public class LoginController
    {
        private UserDAO userDao;

        public LoginController()
        {
            userDao = new UserDAO();
        }

        public LoginCode LoginAndSaveSession(string email, EncryptedPass pass)
        {
            string SuperAdminEmail = System.Configuration.ConfigurationManager.AppSettings["AdminUserName"];
            string SuperAdminPass = System.Configuration.ConfigurationManager.AppSettings["AdminPassword"];

            if (email.CompareTo(SuperAdminEmail) == 0 && pass.UnEncrypted.CompareTo(SuperAdminPass) == 0)
            {
                new SessionController().SetSuperAdmin();
                new SessionController().SetCurrentUserId(0);
                new SessionController().SetCurrentUserEmail(email);
                new SessionController().SetPassword(pass);
                new SessionController().SetTimeout(60 * 24 * 7 * 2);
                return LoginCode.Success;
            }

            User user = userDao.FindByEmail(email);
            if (user == null) { return LoginCode.Failed; }
            string modelPW = new CryptoController().DecryptStringAES(user.Password);
            if (pass.UnEncrypted.CompareTo(modelPW) == 0)
            {
                if (user.IsAdmin == true)
                {
                    new SessionController().SetAdmin();
                }
                else
                {
                    new SessionController().SetUser();
                }

                new SessionController().SetCurrentUserId(user.Id);
                new SessionController().SetCurrentUserEmail(user.Email);
                new SessionController().SetPassword(pass);
                new SessionController().SetTimeout(60 * 24 * 7 * 2);

                return LoginCode.Success;
            }
            else
            {
                return LoginCode.Failed;
            }

        }
        public bool IsSuperAdminLoggedIn()
        {
            return new SessionController().GetSuperAdmin() == true;
        }
        public bool IsAdminLoggedIn()
        {
            return new SessionController().GetAdmin() == true;
        }
        public bool IsUserLoggedIn()
        {
            return new SessionController().GetUser() == true;
        }

        public User GetCurrentUserAccount()
        {
            User user = null;
            int? id = new SessionController().GetCurrentUserId();
            if (id == null) return null;
            user = userDao.FindByID(id.Value);
            return user;
        }

        public bool RegisterModel(string name, string email, EncryptedPass pass)
        {
            User user = userDao.FindByEmail(email);
            if (user != null)
            {
                return false;
            }
            user = new User();
            user.Name = name;
            user.Email = email;
            user.Password = pass.Encrypted;

            bool result = userDao.Insert(user);

            return result;
        }
    }
}