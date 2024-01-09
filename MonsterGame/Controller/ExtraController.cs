using MonsterGame.Common;
using MonsterGame.DAO;
using MonsterGame.Model;
using MonsterGame.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame.Controller
{
    public class ExtraController
    {
        private GameBoardDAO boardDAO;
        private FeedbackDAO feedbackDAO;
        private NotificationDAO notificationDAO;

        private List<SummaryCheck> userSummary;
        private List<SummaryCheck> agencySummary;
        private List<SummaryCheck> masterSummary;
        private List<SummaryCheck> adminSummary;
        public ExtraController() 
        { 
            boardDAO = new GameBoardDAO();
            feedbackDAO = new FeedbackDAO();
            notificationDAO = new NotificationDAO();
        }

        public SearchResult SearchNews(int start, int length, string searchVal)
        {
            SearchResult result = new SearchResult();
            IEnumerable<Notification> notificationList = notificationDAO.FindAll().OrderByDescending(n => n.CreatedDate);
            if (!string.IsNullOrEmpty(searchVal)) notificationList = notificationList.Where(x => x.Title.ToLower().Contains(searchVal.ToLower())).ToList();

            result.TotalCount = notificationList.Count();
            notificationList = notificationList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (Notification notification in notificationList)
            {
                NotificationCheck notificationcheck = new NotificationCheck(notification);
                checks.Add(notificationcheck);
            }
            result.ResultList = checks;

            return result;
        }

        public bool SaveNews(int? notificationID, string title, string description, string ImageTitle)
        {
            Notification notification = notificationDAO.FindByID(notificationID ?? 0);
            if (notification == null)
            {
                Notification newNotification = new Notification();
                newNotification.Title = title;
                newNotification.Description = description;
                newNotification.CreatedDate = DateTime.Now;
                newNotification.IsNew = true;
                newNotification.Image = ImageTitle;
                return notificationDAO.Insert(newNotification);
            }
            else 
            {
                notification.Title = title;
                notification.Description = description;
                notification.IsNew = true;
                notification.CreatedDate = DateTime.Now;
                if (!string.IsNullOrEmpty(ImageTitle)) notification.Image = ImageTitle;
                return notificationDAO.Update(notification);
            }
        }

        public bool DeleteNews(int id)
        {
            Notification item = notificationDAO.FindByID(id);
            if (item == null) return false;

            return notificationDAO.Delete(id);
        }

        public bool SaveFeedback(string title, string description, int userID)
        {
            Feedback feedback = new Feedback();
            feedback.Title = title;
            feedback.Description = description;
            feedback.Creater = userID;
            feedback.CreatedDate = DateTime.Now;
            feedback.IsNew = true;
            return feedbackDAO.Insert(feedback);
        }

        public SearchResult SearchFeedbacks(int start, int length, string searchVal)
        {
            SearchResult result = new SearchResult();
            IEnumerable<Feedback> feedbackList = feedbackDAO.FindAll();
            if (!string.IsNullOrEmpty(searchVal)) feedbackList = feedbackList.Where(x => x.Title.ToLower().Contains(searchVal.ToLower())).ToList();

            result.TotalCount = feedbackList.Count();
            feedbackList = feedbackList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (Feedback feedback in feedbackList)
            {
                FeedbackCheck feedbackcheck = new FeedbackCheck(feedback);
                checks.Add(feedbackcheck);
            }
            result.ResultList = checks;

            return result;
        }
        public bool DeleteFeedback(int id)
        {
            Feedback item = feedbackDAO.FindByID(id);
            if (item == null) return false;

            return feedbackDAO.Delete(id);
        }
        public bool UpdateFeedback(int id)
        {
            Feedback item = feedbackDAO.FindByID(id);
            if (item == null) return false;
            item.IsNew = false;
            return feedbackDAO.Update(item);
        }
        public bool UpdateNews(int id)
        {
            Notification item = notificationDAO.FindByID(id);
            if (item == null) return false;
            item.IsNew = false;
            return notificationDAO.Update(item);
        }

        public SearchResult SearchBoards(int start, int length, string searchVal, int gameID)
        {
            SearchResult result = new SearchResult();
            IEnumerable<GameBoard> boardList = boardDAO.FindAll().Where(g => g.GameID == gameID);
            if (!string.IsNullOrEmpty(searchVal)) boardList = boardList.Where(x => x.Title.ToLower().Contains(searchVal.ToLower())).ToList();

            result.TotalCount = boardList.Count();
            boardList = boardList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (GameBoard board in boardList)
            {
                GameBoardCheck boardCheck = new GameBoardCheck(board);
                checks.Add(boardCheck);
            }
            result.ResultList = checks;

            return result;
        }
        public bool DeleteBoard(int id)
        {
            GameBoard item = boardDAO.FindByID(id);
            if (item == null) return false;

            return boardDAO.Delete(id);
        }
        public bool UpdateBoard(int id)
        {
            GameBoard item = boardDAO.FindByID(id);
            if (item == null) return false;
            item.IsNew = false;
            return boardDAO.Update(item);
        }

        public bool SaveBoard(int? boardID, int? gameID, int userID, string title, string description)
        {
            GameBoard board = boardDAO.FindByID(boardID ?? 0);
            if (board == null)
            {
                if (gameID == null) { return false; }
                GameBoard newBoard = new GameBoard();
                newBoard.Title = title;
                newBoard.Description = description;
                newBoard.CreatedDate = DateTime.Now;
                newBoard.GameID = gameID;
                newBoard.IsNew = true;
                if (userID != 0) newBoard.Creater = userID;
                return boardDAO.Insert(newBoard);
            }
            else
            {
                board.Title = title;
                board.Description = description;
                board.IsNew = true;
                return boardDAO.Update(board);
            }
        }

        public SearchResult SearchSummary(int start, int length, int ownerID, int status, DateTime? from, DateTime? to)
        {
            SearchResult result = new SearchResult();
            User user = new UserDAO().FindByID(ownerID);
            if (ownerID != 0 && user == null) { return result; }
            GetSummary(status, from , to);
            if (ownerID == 0)
            {
                List<int> directUserIDs = new UserDAO().FindAll().Where(u => u.User1 == null).Select(u => u.Id).ToList();
                List<SummaryCheck> checks = new List<SummaryCheck>();
                checks.AddRange(adminSummary.Where(a => directUserIDs.Contains(a.Id)));
                checks.AddRange(masterSummary.Where(m => directUserIDs.Contains(m.Id)));
                checks.AddRange(agencySummary.Where(r => directUserIDs.Contains(r.Id)));
                checks.AddRange(userSummary.Where(u => directUserIDs.Contains(u.Id)));

                result.TotalCount = checks.Count();
                checks = checks.Skip(start).Take(length).ToList();
                result.ResultList = checks;

                //result.TotalCount = adminSummary.Count();
                //adminSummary = adminSummary.Skip(start).Take(length).ToList();
                //result.ResultList = adminSummary;
            }
            else if (user.Role == (int)Role.ADMIN)
            {
                masterSummary = masterSummary.Where(m => m.ParentID == user.Id).ToList();
                result.TotalCount = masterSummary.Count();
                masterSummary = masterSummary.Skip(start).Take(length).ToList();
                result.ResultList = masterSummary;
            }
            else if (user.Role ==  (int)Role.MASTER)
            {
                agencySummary = agencySummary.Where(a => a.ParentID == user.Id).ToList();
                result.TotalCount = agencySummary.Count();
                agencySummary = agencySummary.Skip(start).Take(length).ToList();
                result.ResultList = agencySummary;
            }
            else if (user.Role == (int)Role.AGENCY)
            {
                userSummary = userSummary.Where(u => u.ParentID == user.Id).ToList();
                result.TotalCount = userSummary.Count();
                userSummary = userSummary.Skip(start).Take(length).ToList();
                result.ResultList = userSummary;
            }

            return result;
        }

        private void GetSummary(int status, DateTime? from, DateTime? to)
        {
            List<User> allUsers = new UserDAO().FindAll().Where(u => u.Role == (int)Role.USER).ToList();
            userSummary = new List<SummaryCheck>();
            foreach (User user in allUsers)
            {
                SummaryCheck summaryCheck = new SummaryCheck(user);

                List<Ticket> ticketList = new TicketDAO().FindByUser(user.Id).ToList();

                if (from != null) ticketList = ticketList.Where(u => u.GetDate >= from.Value).ToList();
                if (to != null) ticketList = ticketList.Where(u => u.GetDate <= to.Value).ToList();
                if (status != 0) ticketList = ticketList.Where(x => x.Game.Status == status).ToList();

                if (ticketList.Count() == 0) { continue; }

                summaryCheck.Tickets = ticketList.Count();
                summaryCheck.Players = 1;
                summaryCheck.Amount = ticketList.Sum(t => t.Game.Fee ?? 0);
                summaryCheck.Amount = Math.Round(summaryCheck.Amount, 2);

                List<int> gameList = ticketList.Select(t => t.Game.Id).ToList();
                List<Winner> winnerList = new WinnerDAO().FindAll().Where(w => w.UserID == user.Id).ToList();
                summaryCheck.Prize = winnerList.Where(x => gameList.Contains(x.GameID ?? 0)).Sum(w => w.Prize) ?? 0;
                summaryCheck.Prize = Math.Round(summaryCheck.Prize, 2);
                summaryCheck.Utile = summaryCheck.Amount - summaryCheck.Prize;
                summaryCheck.Utile = Math.Round(summaryCheck.Utile, 2);

                userSummary.Add(summaryCheck);
            }

            List<User> allAgency = new UserDAO().FindAll().Where(u => u.Role == (int)Role.AGENCY).ToList();
            agencySummary = new List<SummaryCheck>();
            foreach(User agency in allAgency)
            {
                SummaryCheck agencySummaryCheck = new SummaryCheck(agency);
                List<SummaryCheck> summaryChecks = userSummary.Where(u => u.ParentID == agency.Id).ToList();
                agencySummaryCheck.Tickets = summaryChecks.Sum(t => t.Tickets);
                agencySummaryCheck.Players = summaryChecks.Sum(t => t.Players);
                agencySummaryCheck.Amount = summaryChecks.Sum(t => t.Amount);
                agencySummaryCheck.Prize = summaryChecks.Sum(t => t.Prize);
                agencySummaryCheck.Utile = summaryChecks.Sum(t => t.Utile);

                agencySummary.Add(agencySummaryCheck);
            }

            List<User> allMasters = new UserDAO().FindAll().Where(u => u.Role == (int)Role.MASTER).ToList();
            masterSummary = new List<SummaryCheck>();
            foreach (User master in allMasters)
            {
                SummaryCheck masterSummaryCheck = new SummaryCheck(master);
                List<SummaryCheck> summaryChecks = agencySummary.Where(u => u.ParentID == master.Id).ToList();
                masterSummaryCheck.Tickets = summaryChecks.Sum(t => t.Tickets);
                masterSummaryCheck.Players = summaryChecks.Sum(t => t.Players);
                masterSummaryCheck.Amount = summaryChecks.Sum(t => t.Amount);
                masterSummaryCheck.Prize = summaryChecks.Sum(t => t.Prize);
                masterSummaryCheck.Utile = summaryChecks.Sum(t => t.Utile);

                masterSummary.Add(masterSummaryCheck);
            }

            List<User> allAdmins = new UserDAO().FindAll().Where(u => u.Role == (int)Role.ADMIN).ToList();
            adminSummary = new List<SummaryCheck>();
            foreach (User admin in allAdmins)
            {
                SummaryCheck adminSummaryCheck = new SummaryCheck(admin);
                List<SummaryCheck> summaryChecks = masterSummary.Where(u => u.ParentID == admin.Id).ToList();
                adminSummaryCheck.Tickets = summaryChecks.Sum(t => t.Tickets);
                adminSummaryCheck.Players = summaryChecks.Sum(t => t.Players);
                adminSummaryCheck.Amount = summaryChecks.Sum(t => t.Amount);
                adminSummaryCheck.Prize = summaryChecks.Sum(t => t.Prize);
                adminSummaryCheck.Utile = summaryChecks.Sum(t => t.Utile);

                adminSummary.Add(adminSummaryCheck);
            }
        }
    }
}