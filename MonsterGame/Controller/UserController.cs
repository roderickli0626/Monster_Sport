using Antlr.Runtime.Tree;
using MonsterGame;
using MonsterGame.Common;
using MonsterGame.Controller;
using MonsterGame.DAO;
using MonsterGame.Model;
using MonsterGame.Models;
using MonsterSport.Model;
using PayPal.Api;
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
        public SearchResult SearchMaster(int start, int length, string searchVal, int adminID)
        {
            SearchResult result = new SearchResult();
            IEnumerable<User> masterList = userDao.FindAll().Where(u => u.Role == (int)Role.MASTER);
            if (adminID != 0) masterList = masterList.Where(m => m.ParentID == adminID).ToList();
            if (!string.IsNullOrEmpty(searchVal)) masterList = masterList.Where(x => x.Name.Contains(searchVal)).ToList();

            result.TotalCount = masterList.Count();
            masterList = masterList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (User user in masterList)
            {
                UserCheck usercheck = new UserCheck(user);
                usercheck.admin = user.User1?.Name ?? "Super Admin";
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
        public bool DeleteMaster(int id, User admin)
        {
            User master = userDao.FindByID(id);
            if (master == null) return false;
            if (admin != null)
            {
                double amount = master.Balance ?? 0;
                admin.Balance = (admin.Balance ?? 0) + amount;
                bool success = userDao.Update(admin);
                if (amount == 0) return success;
                Movement movement = new Movement();
                movement.UserID = admin.Id;
                movement.Amount = master.Balance ?? 0;
                movement.MoveDate = DateTime.Now;
                
                if (amount > 0)
                {
                    movement.Type = (int)MovementType.DEPOSIT;
                }
                else
                {
                    movement.Type = (int)MovementType.WITHDRAWAL;
                }
                movement.Note = "Master " + master.Name + " Deleted. Transfered master's balance to admin's balance.";
                new MovementDAO().Insert(movement);
            }
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
        public bool SaveMaster(int? masterID, int adminID, string name, string surname, string nickname, string email, EncryptedPass pass, string mobile, string note)
        {
            User master = userDao.FindByID(masterID ?? 0);
            if (master == null)
            {
                User existMaster = userDao.FindByEmail(email);
                if (existMaster != null) return false;
                master = new User();
                master.Name = name;
                master.Surname = surname;
                master.NickName = nickname;
                master.Email = email;
                master.Mobile = mobile;
                master.Note = note;
                master.Password = pass?.Encrypted ?? "";
                master.Role = (int)Role.MASTER;
                if (adminID != 0) master.ParentID = adminID;

                return userDao.Insert(master);
            }
            else
            {
                master.Name = name;
                master.Surname = surname;
                master.NickName = nickname;
                master.Email = email;
                master.Mobile = mobile;
                master.Note = note;
                if (pass != null)
                {
                    master.Password = pass.Encrypted;
                }
                return userDao.Update(master);
            }
        }
        public bool UpdateBalance(int? adminID, double amount, string note)
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
            movement.Note = note;

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
        public bool UpdateMasterBalance(int? masterID, int adminID, double amount, string note)
        {
            User master = userDao.FindByID(masterID ?? 0);
            User admin = userDao.FindByID(adminID);
            if (master == null) { return false; }
            master.Balance = (master.Balance ?? 0) + amount;
            if (admin != null)
            {
                admin.Balance = (admin.Balance ?? 0) - amount;
                userDao.Update(admin);
            }
            bool success = userDao.Update(master);
            if (amount == 0) return success;
            Movement movement = new Movement();
            movement.Amount = amount;
            movement.UserID = masterID;
            movement.MoveDate = DateTime.Now;
            movement.Note = note;
            if (adminID != 0) movement.SenderID = adminID;

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