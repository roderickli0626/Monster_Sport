using MonsterGame.Controller;
using MonsterGame.DAO;
using MonsterGame.Models;
using MonsterGame;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Globalization;
using MonsterGame.Common;

namespace MonsterGame
{
    /// <summary>
    /// Summary description for DataService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class DataService : System.Web.Services.WebService
    {

        LoginController loginSystem = new LoginController();
        private JavaScriptSerializer serializer = new JavaScriptSerializer();

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void FindGames(int draw, int start, int length, string searchVal, int status)
        {
            User user = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && user == null) return;

            GameController gameController = new GameController();
            SearchResult searchResult = gameController.Search(start, length, searchVal, status);

            JSDataTable result = new JSDataTable();
            result.data = (IEnumerable<object>)searchResult.ResultList;
            result.draw = draw;
            result.recordsTotal = searchResult.TotalCount;
            result.recordsFiltered = searchResult.TotalCount;

            ResponseJson(result);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void DeleteGame(int id)
        {
            //Is Logged in?
            if (!loginSystem.IsSuperAdminLoggedIn()) return;

            GameController gameController = new GameController();
            bool success = gameController.DeleteGame(id);

            ResponseProc(success, "");
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void FindAdmins(int draw, int start, int length, string searchVal)
        {
            if (!loginSystem.IsSuperAdminLoggedIn()) return;

            UserController userController = new UserController();
            SearchResult searchResult = userController.Search(start, length, searchVal);

            JSDataTable result = new JSDataTable();
            result.data = (IEnumerable<object>)searchResult.ResultList;
            result.draw = draw;
            result.recordsTotal = searchResult.TotalCount;
            result.recordsFiltered = searchResult.TotalCount;

            ResponseJson(result);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void DeleteAdmin(int id)
        {
            //Is Logged in?
            if (!loginSystem.IsSuperAdminLoggedIn()) return;

            UserController userController = new UserController();
            bool success = userController.DeleteAdmin(id);

            ResponseProc(success, "");
        }
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void FindMasters(int draw, int start, int length, string searchVal)
        {
            User admin = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (admin == null || !loginSystem.IsAdminLoggedIn())) return;

            UserController userController = new UserController();
            SearchResult searchResult = userController.SearchMaster(start, length, searchVal, admin?.Id ?? 0);

            JSDataTable result = new JSDataTable();
            result.data = (IEnumerable<object>)searchResult.ResultList;
            result.draw = draw;
            result.recordsTotal = searchResult.TotalCount;
            result.recordsFiltered = searchResult.TotalCount;

            ResponseJson(result);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void DeleteMaster(int id)
        {
            //Is Logged in?
            User admin = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (admin == null || !loginSystem.IsAdminLoggedIn())) return;

            UserController userController = new UserController();
            bool success = userController.DeleteMaster(id, admin);

            ResponseProc(success, "");
        }
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void FindAgencies(int draw, int start, int length, string searchVal)
        {
            User admin = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (admin == null || !loginSystem.IsAdminLoggedIn()) && (admin == null || !loginSystem.IsMasterLoggedIn())) return;

            UserController userController = new UserController();
            SearchResult searchResult = userController.SearchAgencies(start, length, searchVal, admin?.Id ?? 0, admin?.Role ?? 0);

            JSDataTable result = new JSDataTable();
            result.data = (IEnumerable<object>)searchResult.ResultList;
            result.draw = draw;
            result.recordsTotal = searchResult.TotalCount;
            result.recordsFiltered = searchResult.TotalCount;

            ResponseJson(result);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void DeleteAgency(int id)
        {
            //Is Logged in?
            User admin = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (admin == null || !loginSystem.IsMasterLoggedIn())) return;

            UserController userController = new UserController();
            bool success = userController.DeleteAgency(id, admin);

            ResponseProc(success, "");
        }
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void FindUsers(int draw, int start, int length, string searchVal)
        {
            User admin = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (admin == null || !loginSystem.IsAdminLoggedIn()) && (admin == null || !loginSystem.IsMasterLoggedIn()) && (admin == null || !loginSystem.IsAgencyLoggedIn())) return;

            UserController userController = new UserController();
            SearchResult searchResult = userController.SearchUsers(start, length, searchVal, admin?.Id ?? 0, admin?.Role ?? 0);

            JSDataTable result = new JSDataTable();
            result.data = (IEnumerable<object>)searchResult.ResultList;
            result.draw = draw;
            result.recordsTotal = searchResult.TotalCount;
            result.recordsFiltered = searchResult.TotalCount;

            ResponseJson(result);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void DeleteUser(int id)
        {
            //Is Logged in?
            User admin = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (admin == null || !loginSystem.IsAgencyLoggedIn())) return;

            UserController userController = new UserController();
            bool success = userController.DeleteUser(id, admin);

            ResponseProc(success, "");
        }
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void FindMovements(int draw, int start, int length, string searchReceiver, string searchSender, string searchFrom, string searchTo)
        {
            if (!loginSystem.IsSuperAdminLoggedIn()) return;

            DateTime? from = null;
            DateTime? to = null;

            if (!string.IsNullOrEmpty(searchFrom))
                from = DateTime.ParseExact(searchFrom, "dd/MM/yyyy HH.mm", CultureInfo.InvariantCulture);

            if (!string.IsNullOrEmpty(searchTo))
                to = DateTime.ParseExact(searchTo, "dd/MM/yyyy HH.mm", CultureInfo.InvariantCulture);

            MovementController movementController = new MovementController();
            SearchResult searchResult = movementController.Search(start, length, searchReceiver, searchSender, from, to);

            JSDataTable result = new JSDataTable();
            result.data = (IEnumerable<object>)searchResult.ResultList;
            result.draw = draw;
            result.recordsTotal = searchResult.TotalCount;
            result.recordsFiltered = searchResult.TotalCount;

            ResponseJson(result);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void FindUserMovements(int draw, int start, int length, string searchTransfer, string searchFrom, string searchTo)
        {
            User user = loginSystem.GetCurrentUserAccount();
            if (user == null) return;

            DateTime? from = null;
            DateTime? to = null;

            if (!string.IsNullOrEmpty(searchFrom))
                from = DateTime.ParseExact(searchFrom, "dd/MM/yyyy HH.mm", CultureInfo.InvariantCulture);

            if (!string.IsNullOrEmpty(searchTo))
                to = DateTime.ParseExact(searchTo, "dd/MM/yyyy HH.mm", CultureInfo.InvariantCulture);

            MovementController movementController = new MovementController();
            SearchResult searchResult = movementController.SearchUserMovement(start, length, searchTransfer, from, to, user.Id);

            JSDataTable result = new JSDataTable();
            result.data = (IEnumerable<object>)searchResult.ResultList;
            result.draw = draw;
            result.recordsTotal = searchResult.TotalCount;
            result.recordsFiltered = searchResult.TotalCount;

            ResponseJson(result);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void DeleteMovement(int id)
        {
            //Is Logged in?
            if (!loginSystem.IsSuperAdminLoggedIn()) return;

            MovementController movementController = new MovementController();
            bool success = movementController.DeleteMovement(id);

            ResponseProc(success, "");
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void FindPayments(int draw, int start, int length, string searchVal)
        {
            User user = loginSystem.GetCurrentUserAccount();
            if (user == null) return;

            PaymentController paymentController = new PaymentController();
            SearchResult searchResult = paymentController.Search(start, length, searchVal, user.Id);

            JSDataTable result = new JSDataTable();
            result.data = (IEnumerable<object>)searchResult.ResultList;
            result.draw = draw;
            result.recordsTotal = searchResult.TotalCount;
            result.recordsFiltered = searchResult.TotalCount;

            ResponseJson(result);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void FindTickets(int gameID)
        {
            HttpResponse Response = Context.Response;
            ProcResult result = new ProcResult();
            Response.ContentType = "application/json; charset=utf-8";

            User user = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (user == null))
            {
                Response.Write(serializer.Serialize(result));
                return;
            }

            try
            {
                TicketController ticketController = new TicketController();
                result.data = ticketController.FindTickets(gameID);
                result.success = true;
                Response.Write(serializer.Serialize(result));
            }
            catch(Exception ex)
            {
                result.success = false;
                Response.Write(serializer.Serialize(result));
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void FindResults(int gameID)
        {
            HttpResponse Response = Context.Response;
            ProcResult result = new ProcResult();
            Response.ContentType = "application/json; charset=utf-8";

            User user = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (user == null))
            {
                Response.Write(serializer.Serialize(result));
                return;
            }

            try
            {
                GameController gameController = new GameController();
                result.data = gameController.FindResults(gameID);
                result.success = true;
                Response.Write(serializer.Serialize(result));
            }
            catch (Exception ex)
            {
                result.success = false;
                Response.Write(serializer.Serialize(result));
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void FindWinners(int draw, int start, int length, int gameID)
        {
            User user = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (user == null)) return;

            WinnerController winnerController = new WinnerController();
            SearchResult searchResult = winnerController.Search(start, length, gameID);

            JSDataTable result = new JSDataTable();
            result.data = (IEnumerable<object>)searchResult.ResultList;
            result.draw = draw;
            result.recordsTotal = searchResult.TotalCount;
            result.recordsFiltered = searchResult.TotalCount;

            ResponseJson(result);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void FindMyTickets(int gameID, int userID)
        {
            HttpResponse Response = Context.Response;
            ProcResult result = new ProcResult();
            Response.ContentType = "application/json; charset=utf-8";

            User user = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (user == null || !loginSystem.IsUserLoggedIn()))
            {
                Response.Write(serializer.Serialize(result));
                return;
            }

            try
            {
                TicketController ticketController = new TicketController();
                result.data = ticketController.FindMyTickets(gameID, userID);
                result.success = true;
                Response.Write(serializer.Serialize(result));
            }
            catch (Exception ex)
            {
                result.success = false;
                Response.Write(serializer.Serialize(result));
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void SecurityAction(int winResult, string security)
        {
            //Is Logged in?
            if (!loginSystem.IsSuperAdminLoggedIn()) return;

            bool success = ProcessAction(winResult, security);

            ResponseProc(success, "");
        }

        protected bool ProcessAction(int res, string sec)
        {
            ResultDAO resultDAO = new ResultDAO();
            Result result = resultDAO.FindByID(res);
            TicketResultDAO ticketResultDAO = new TicketResultDAO();
            List<TicketResult> ticketResults = ticketResultDAO.FindAll().Where(t => t.Ticket.GameID == result.TeamsForGame.GameID && t.Ticket.User.NickName.Contains(sec)).ToList();
            List<int> allTeamIDs = new TeamsForGameDAO().FindByGame(result.TeamsForGame.GameID ?? 0).Select(r => r.TeamID ?? 0).ToList();
            List<int> assignedTeamIDs = ticketResults.Select(t => t.TeamID ?? 0).ToList();
            TicketResult ticketResult = ticketResultDAO.FindGameAndRound(result.TeamsForGame.GameID ?? 0, result.RoundNo ?? 0).Where(t => t.Ticket.User.NickName.Contains(sec)).FirstOrDefault();
            if (ticketResult != null && ticketResult.RoundResult != (int)RoundResult.W)
            {
                assignedTeamIDs.Remove(ticketResult.TeamID ?? 0);
                int teamID = result.TeamsForGame.TeamID ?? 0;
                foreach(TicketResult ticRes in ticketResults)
                {
                    if (ticRes.TeamID == teamID && ticRes.Id != ticketResult.Id)
                    {
                        ticRes.TeamID = allTeamIDs.Where(i => !assignedTeamIDs.Contains(i)).FirstOrDefault();
                        ticRes.RoundResult = resultDAO.FindByGameAndTeamAndRound(ticRes.Ticket.GameID ?? 0, ticRes.TeamID ?? 0, ticRes.RoundNo ?? 0).RoundResult;
                        ticketResultDAO.Update(ticRes);
                    }
                }

                ticketResult.TeamID = teamID;
                ticketResult.RoundResult = (int)RoundResult.W;
                ticketResultDAO.Update(ticketResult);
            }

            return true;
        }
        protected void ResponseJson(Object result)
        {
            HttpResponse Response = Context.Response;
            Response.ContentType = "application/json; charset=utf-8";
            Response.Write(serializer.Serialize(result));
        }
        protected void ResponseJson(Object result, bool success)
        {
            HttpResponse Response = Context.Response;
            Response.ContentType = "application/json; charset=utf-8";
            Response.Write(serializer.Serialize(result));
            if (success)
            {
                Response.StatusCode = 200;
            }
            Response.Flush();
        }

        protected void ResponseProc(bool success, object data, string message = "")
        {
            ProcResult result = new ProcResult();
            result.success = success;
            result.data = data;
            result.message = message;
            ResponseJson(result, success);
        }
    }
}
