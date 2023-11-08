using Antlr.Runtime.Tree;
using MonsterGame;
using MonsterGame.DAO;
using MonsterGame.Model;
using MonsterGame.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.CodeDom.Compiler;
using System.Runtime.Serialization;
using System.Data.SqlClient;

namespace MonsterGame.Controller
{
    public class TicketController
    {
        TicketDAO ticketDAO;
        TicketResultDAO ticketResultDAO;
        public TicketController() 
        { 
            ticketDAO = new TicketDAO();
            ticketResultDAO = new TicketResultDAO();
        }

        public List<TicketCheck> FindTickets(int gameID)
        {
            List<Ticket> ticketList = ticketDAO.FindByGame(gameID);
            List<TicketCheck> result = new List<TicketCheck>();
            foreach (Ticket ticket in ticketList)
            {
                TicketCheck ticketCheck = new TicketCheck(ticket);
                List<TicketResult> resultList = ticketResultDAO.FindByTicket(ticket.Id);
                List<TicketResultCheck> resutlCheckList = new List<TicketResultCheck>();
                foreach (TicketResult resultResult in resultList)
                {
                    TicketResultCheck ticketResultCheck = new TicketResultCheck(resultResult);
                    resutlCheckList.Add(ticketResultCheck);
                }
                ticketCheck.TicketResults = resutlCheckList;
                result.Add(ticketCheck);
            }
            return result;
        }

        public List<TicketCheck> FindMyTickets(int gameID, int userID)
        {
            List<Ticket> ticketList = ticketDAO.FindByGameAndUser(gameID, userID);
            List<TicketCheck> result = new List<TicketCheck>();
            foreach (Ticket ticket in ticketList)
            {
                TicketCheck ticketCheck = new TicketCheck(ticket);
                List<TicketResult> resultList = ticketResultDAO.FindByTicket(ticket.Id);
                List<TicketResultCheck> resutlCheckList = new List<TicketResultCheck>();
                foreach (TicketResult resultResult in resultList)
                {
                    TicketResultCheck ticketResultCheck = new TicketResultCheck(resultResult);
                    resutlCheckList.Add(ticketResultCheck);
                }
                ticketCheck.TicketResults = resutlCheckList;
                result.Add(ticketCheck);
            }
            return result;
        }

        public bool AddNewRound(int gameID, int? Round)
        {
            bool success = true;
            List<Ticket> ticketList = ticketDAO.FindByGame(gameID);
            foreach(Ticket ticket in ticketList)
            {
                TicketResult ticketResult = new TicketResult();
                ticketResult.TicketID = ticket.Id;
                ticketResult.RoundNo = Round;

                List<int?> roundResultList = ticketResultDAO.FindByTicket(ticket.Id).Select(t => t.RoundResult).ToList();
                if (roundResultList.Contains((int)RoundResult.L) || roundResultList.Count(i => i == (int)RoundResult.P) > 1 || roundResultList.Contains(null))
                {
                    ticketResult.RoundResult = null;
                }
                else
                {
                    ticketResult.RoundResult = (int)RoundResult.N;
                }

                success = ticketResultDAO.Insert(ticketResult);
            }

            return success;
        }

        public int GetRemainedTickets(int gameID, int? currentRound)
        {
            List<int?> currentRoundResult = ticketResultDAO.FindGameAndRound(gameID, currentRound).Select(t => t.RoundResult).ToList();

            int num = currentRoundResult.Count(i => i.HasValue);

            return num;
        }

        public bool AddNewTickets(int userID, int gameID)
        {
            bool success = true;
            if (userID == 0 || gameID == 0) { return false; }
            Ticket ticket = new Ticket();
            ticket.UserID = userID;
            ticket.GameID = gameID;
            ticket.GetDate = DateTime.Now;
            int ticketID = ticketDAO.Insert(ticket);

            List<TicketResult> ticketResults = ticketResultDAO.FindGameAndRound(gameID, 1);
            if (ticketResults.Count > 0)
            {
                TicketResult result = new TicketResult();
                result.TicketID = ticketID;
                result.RoundNo = 1;
                result.RoundResult = (int)RoundResult.N;

                success = ticketResultDAO.Insert(result);
            }

            // Increase Game's RealPlayer
            // This Action needs to TRANSACTION ISOLATION LEVEL SERIALIZABLE because Many users can increase at the sametime.
            //var a = new MappingDataContext(System.Configuration.ConfigurationManager.ConnectionStrings["MonsterConnectionString"].ConnectionString);

            //GameDAO gameDAO = new GameDAO();
            //Game game = gameDAO.FindByID(gameID);
            //game.RealPlayers = (game.RealPlayers ?? 0) + 1;
            //gameDAO.Update(game);

            using (SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MonsterConnectionString"].ConnectionString))
            {
                // Open the connection
                string sqlCommand = @"SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
                                BEGIN TRANSACTION;
                                UPDATE Game SET RealPlayers = IIF(RealPlayers IS NULL, 1, RealPlayers+1) WHERE Id = @gameID;
                                COMMIT TRANSACTION;";

                using (SqlCommand command = new SqlCommand(sqlCommand, connection))
                {
                    command.Parameters.AddWithValue("@gameID", gameID);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }

            return success;
        }
    }
}