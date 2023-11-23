using Antlr.Runtime.Tree;
using MonsterGame;
using MonsterGame.Common;
using MonsterGame.Controller;
using MonsterGame.DAO;
using MonsterGame.Model;
using MonsterGame.Models;
using PayPal.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;

namespace MonsterGame.Controller
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
            if (!string.IsNullOrEmpty(searchVal)) adminList = adminList.Where(x => x.Name.ToLower().Contains(searchVal.ToLower())).ToList();

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
            if (!string.IsNullOrEmpty(searchVal)) masterList = masterList.Where(x => x.Name.ToLower().Contains(searchVal.ToLower())).ToList();

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
        public SearchResult SearchAgencies(int start, int length, string searchVal, int adminID, int role)
        {
            SearchResult result = new SearchResult();
            IEnumerable<User> agencyList = userDao.FindAll().Where(u => u.Role == (int)Role.AGENCY);
            if (adminID != 0)
            {
                if (role == (int)Role.MASTER) agencyList = agencyList.Where(m => m.ParentID == adminID).ToList();
                else agencyList = agencyList.Where(m => (m.User1?.ParentID ?? 0) == adminID).ToList();
            }
            if (!string.IsNullOrEmpty(searchVal)) agencyList = agencyList.Where(x => x.Name.ToLower().Contains(searchVal.ToLower())).ToList();

            result.TotalCount = agencyList.Count();
            agencyList = agencyList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (User user in agencyList)
            {
                UserCheck usercheck = new UserCheck(user);
                usercheck.master = user.User1?.Name ?? "Super Admin";
                usercheck.admin = user.User1?.User1?.Name ?? "Super Admin";
                checks.Add(usercheck);
            }
            result.ResultList = checks;

            return result;
        }
        public SearchResult SearchUsers(int start, int length, string searchVal, int adminID, int role)
        {
            SearchResult result = new SearchResult();
            IEnumerable<User> userList = userDao.FindAll().Where(u => u.Role == (int)Role.USER);
            if (adminID != 0)
            {
                if (role == (int)Role.AGENCY) userList = userList.Where(m => m.ParentID == adminID).ToList();
                else if (role == (int)Role.MASTER) userList = userList.Where(m => (m.User1?.ParentID ?? 0) == adminID).ToList();
                else userList = userList.Where(m => (m.User1?.User1?.ParentID ?? 0) == adminID).ToList();
            }
            if (!string.IsNullOrEmpty(searchVal)) userList = userList.Where(x => x.Name.ToLower().Contains(searchVal.ToLower())).ToList();

            result.TotalCount = userList.Count();
            userList = userList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (User user in userList)
            {
                UserCheck usercheck = new UserCheck(user);
                usercheck.agency = user.User1?.Name ?? "Super Admin";
                usercheck.master = user.User1?.User1?.Name ?? "Super Admin";
                usercheck.admin = user.User1?.User1?.User1?.Name ?? "Super Admin";
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
        public bool DeleteAgency(int id, User master)
        {
            User agency = userDao.FindByID(id);
            if (agency == null) return false;
            
            if (master != null)
            {
                if (master.Role == (int)Role.ADMIN) return false;
                double amount = agency.Balance ?? 0;
                master.Balance = (master.Balance ?? 0) + amount;
                bool success = userDao.Update(master);
                if (amount == 0) return success;
                Movement movement = new Movement();
                movement.UserID = master.Id;
                movement.Amount = agency.Balance ?? 0;
                movement.MoveDate = DateTime.Now;

                if (amount > 0)
                {
                    movement.Type = (int)MovementType.DEPOSIT;
                }
                else
                {
                    movement.Type = (int)MovementType.WITHDRAWAL;
                }
                movement.Note = "Agency " + agency.Name + " Deleted. Transfered agency's balance to master's balance.";
                new MovementDAO().Insert(movement);
            }
            return userDao.Delete(id);
        }
        public bool DeleteUser(int id, User agency)
        {
            User user = userDao.FindByID(id);
            if (user == null) return false;

            if (agency != null)
            {
                if (agency.Role == (int)Role.ADMIN || agency.Role == (int)Role.MASTER) return false;
                double amount = user.Balance ?? 0;
                agency.Balance = (agency.Balance ?? 0) + amount;
                bool success = userDao.Update(agency);
                if (amount == 0) return success;
                Movement movement = new Movement();
                movement.UserID = agency.Id;
                movement.Amount = user.Balance ?? 0;
                movement.MoveDate = DateTime.Now;

                if (amount > 0)
                {
                    movement.Type = (int)MovementType.DEPOSIT;
                }
                else
                {
                    movement.Type = (int)MovementType.WITHDRAWAL;
                }
                movement.Note = "User " + user.Name + " Deleted. Transfered user's balance to agency's balance.";
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
        public bool SaveAgency(int? agencyID, int adminID, string name, string surname, string nickname, string email, EncryptedPass pass, string mobile, string note)
        {
            User agency = userDao.FindByID(agencyID ?? 0);
            if (agency == null)
            {
                User existAgency = userDao.FindByEmail(email);
                if (existAgency != null) return false;
                agency = new User();
                agency.Name = name;
                agency.Surname = surname;
                agency.NickName = nickname;
                agency.Email = email;
                agency.Mobile = mobile;
                agency.Note = note;
                agency.Password = pass?.Encrypted ?? "";
                agency.Role = (int)Role.AGENCY;
                if (adminID != 0) agency.ParentID = adminID;

                return userDao.Insert(agency);
            }
            else
            {
                agency.Name = name;
                agency.Surname = surname;
                agency.NickName = nickname;
                agency.Email = email;
                agency.Mobile = mobile;
                agency.Note = note;
                if (pass != null)
                {
                    agency.Password = pass.Encrypted;
                }
                return userDao.Update(agency);
            }
        }
        public bool SaveUser(int? userID, int adminID, string name, string surname, string nickname, string email, EncryptedPass pass, string mobile, string note)
        {
            User user = userDao.FindByID(userID ?? 0);
            if (user == null)
            {
                User existUser = userDao.FindByEmail(email);
                if (existUser != null) return false;
                user = new User();
                user.Name = name;
                user.Surname = surname;
                user.NickName = nickname;
                user.Email = email;
                user.Mobile = mobile;
                user.Note = note;
                user.Password = pass?.Encrypted ?? "";
                user.Role = (int)Role.USER;
                if (adminID != 0) user.ParentID = adminID;

                return userDao.Insert(user);
            }
            else
            {
                user.Name = name;
                user.Surname = surname;
                user.NickName = nickname;
                user.Email = email;
                user.Mobile = mobile;
                user.Note = note;
                if (pass != null)
                {
                    user.Password = pass.Encrypted;
                }
                return userDao.Update(user);
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
        public bool UpdateAgencyBalance(int? agencyID, int adminID, double amount, string note)
        {
            User agency = userDao.FindByID(agencyID ?? 0);
            User admin = userDao.FindByID(adminID);
            if (agency == null) { return false; }
            agency.Balance = (agency.Balance ?? 0) + amount;
            if (admin != null)
            {
                admin.Balance = (admin.Balance ?? 0) - amount;
                userDao.Update(admin);
            }
            bool success = userDao.Update(agency);
            if (amount == 0) return success;
            Movement movement = new Movement();
            movement.Amount = amount;
            movement.UserID = agencyID;
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
        public bool UpdateUserBalance(int? userID, int adminID, double amount, string note)
        {
            User user = userDao.FindByID(userID ?? 0);
            User admin = userDao.FindByID(adminID);
            if (user == null) { return false; }
            user.Balance = (user.Balance ?? 0) + amount;
            if (admin != null)
            {
                admin.Balance = (admin.Balance ?? 0) - amount;
                userDao.Update(admin);
            }
            bool success = userDao.Update(user);
            if (amount == 0) return success;
            Movement movement = new Movement();
            movement.Amount = amount;
            movement.UserID = userID;
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

        public List<User> FindChildren(int userID)
        {
            List<User> result = new List<User>();
            if (userID == 0)
            {
                result = userDao.FindAll().Where(u => u.Role != (int)Role.USER).ToList();
            }
            else
            {
                User user = userDao.FindByID(userID);
                if (user.Role == (int)Role.AGENCY) { return result; }
                result = userDao.FindByParentID(userID);
                foreach (User child in result)
                {
                    result = result.Concat(FindChildren(child.Id)).ToList();
                }
            }

            return result;
        }
    }
}