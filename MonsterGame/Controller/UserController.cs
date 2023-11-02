using MonsterGame;
using MonsterGame.Common;
using MonsterGame.Controller;
using MonsterGame.DAO;
using MonsterGame.Model;
using MonsterGame.Models;
using MonsterSport.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;

namespace MonsterSport.Controller
{
    public class UserController
    {
        UserDAO userDao;

        public UserController()
        {
            userDao = new UserDAO();
        }
        public SearchResult Search(int start, int length, string searchVal)
        {
            SearchResult result = new SearchResult();
            IEnumerable<User> adminList = userDao.FindAll().Where(u => u.Role == (int)Role.ADMIN);
            if (!string.IsNullOrEmpty(searchVal)) adminList = adminList.Where(x => x.Name.Contains(searchVal)).ToList();

            result.TotalCount = adminList.Count();
            adminList = adminList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (User user in adminList)
            {
                UserCheck usercheck = new UserCheck(user);
                checks.Add(usercheck);
            }
            result.ResultList = checks;

            return result;
        }
        public bool DeleteAdmin(int id)
        {
            User user = userDao.FindByID(id);
            if (user == null) return false;

            return userDao.Delete(id);
        }
        public bool SaveAdmin(int? adminID, string name, string surname, string nickname, string email, EncryptedPass pass, string mobile, string note)
        {
            User admin = userDao.FindByID(adminID ?? 0);
            if (admin == null)
            {
                User existAdmin = userDao.FindByEmail(email);
                if (existAdmin != null) return false;
                admin = new User();
                admin.Name = name;
                admin.Surname = surname;
                admin.NickName = nickname;
                admin.Email = email;
                admin.Mobile = mobile;
                admin.Note = note;
                admin.Password = pass?.Encrypted ?? "";
                admin.Role = (int)Role.ADMIN;
                
                return userDao.Insert(admin);
            }
            else
            {
                admin.Name = name;
                admin.Surname = surname;
                admin.NickName= nickname;
                admin.Email = email;
                admin.Mobile = mobile;
                admin.Note = note;
                if (pass != null)
                {
                    admin.Password = pass.Encrypted;
                }
                return userDao.Update(admin);
            }
        }
        public bool UpdateBalance(int? adminID, double amount)
        {
            User admin = userDao.FindByID(adminID ?? 0);
            if (admin == null) { return false; }
            admin.Balance = (admin.Balance ?? 0) + amount;
            bool success = userDao.Update(admin);
            if (amount == 0) return success;
            Movement movement = new Movement();
            movement.Amount = amount;
            movement.UserID = adminID;
            movement.MoveDate = DateTime.Now;

            if (amount > 0)
            {
                movement.Type = (int)MovementType.DEPOSIT;
            }
            else
            {
                movement.Type = (int)MovementType.WITHDRAWAL;
            }
            return new MovementDAO().Insert(movement);
        }
    }
}