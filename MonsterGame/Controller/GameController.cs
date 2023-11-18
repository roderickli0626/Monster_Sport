using MonsterGame.Common;
using MonsterGame.DAO;
using MonsterGame.Model;
using MonsterGame.Models;
using MonsterGame.Common;
using MonsterGame.Model;
using PayPal.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Collections;

namespace MonsterGame.Controller
{
    public class GameController
    {
        private GameDAO gameDao;
        private TeamsForGameDAO teamForGameDao;
        private ResultDAO resultDao;

        public GameController()
        {
            gameDao = new GameDAO();
            teamForGameDao = new TeamsForGameDAO();
            resultDao = new ResultDAO();
        }

        public SearchResult Search(int start, int length, string searchVal, int status)
        {
            SearchResult result = new SearchResult();
            IEnumerable<Game> gameList = gameDao.FindAll().OrderByDescending(g => g.RealPlayers).ThenBy(g => g.Id);
            if (status != 0) gameList = gameList.Where(x => x.Status == status).ToList();
            if (!string.IsNullOrEmpty(searchVal)) gameList = gameList.Where(x => x.Title.ToLower().Contains(searchVal.ToLower())).ToList();

            result.TotalCount = gameList.Count();
            gameList = gameList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (Game game in gameList)
            {
                GameCheck gameCheck = AddData(game);
                List<TeamsForGame> teamList = new TeamsForGameDAO().FindByGame(game.Id).ToList();
                gameCheck.TeamList = teamList.Select(t => t.TeamID ?? 0).ToList();

                TeamsForGame teamsForGame = new TeamsForGameDAO().FindByGame(game.Id).FirstOrDefault();
                Result r = new ResultDAO().FindByTeamsForGame(teamsForGame.Id).LastOrDefault();

                gameCheck.Round = r?.RoundNo ?? 0;
                checks.Add(gameCheck);
            }
            result.ResultList = checks;

            return result;
        }
        public List<GameCheck> FindAll(int status, string search, int userID)
        {
            List<int> myGameIDs = new TicketDAO().FindByUser(userID).Select(t => t.GameID ?? 0).ToList();
            List<Game> gameList = gameDao.FindAll();
            if (status != 0) gameList = gameList.Where(x => x.Status == status).ToList();
            if (!string.IsNullOrEmpty(search)) gameList = gameList.Where(x => x.Title.ToLower().Contains(search.ToLower())).ToList();

            List<GameCheck> result = new List<GameCheck>();
            foreach (Game game in gameList)
            {
                GameCheck check = AddData(game);
                if (myGameIDs.Contains(game.Id))
                {
                    check.MyMark = "my-card";
                }
                result.Add(check);
            }
            return result;
        }
        public List<GameCheck> FindUserGames(int userID)
        {
            List<int> gameIDs = new TicketDAO().FindByUser(userID).Select(t => t.GameID ?? 0).ToList();
            List<Game> gameList = gameDao.FindAll().Where(g => gameIDs.Contains(g.Id)).ToList();

            List<GameCheck> result = new List<GameCheck>();
            foreach (Game game in gameList)
            {
                GameCheck check = AddData(game);
                result.Add(check);
            }
            return result;
        }
        private GameCheck AddData(Game game)
        {
            GameCheck check = new GameCheck(game);
            switch (game.Status)
            {
                case 1:
                    {
                        check.Image = "gamemark1.jpg";
                        check.Mark = "<div class=\"ribbon blue\"><span>APERTO</span></div>";
                        check.ButtonTitle = "Play Now";
                    }
                    break;
                case 2:
                    {
                        check.Image = "gamemark2.jpg";
                        check.Mark = "<div class=\"ribbon red\"><span>INIZIATO</span></div>";
                        check.ButtonTitle = "Dettagli";
                    }
                    break;
                case 3:
                    {
                        check.Image = "gamemark3.jpg";
                        check.Mark = "<div class=\"ribbon red\"><span>SCELTA TEAM</span></div>";
                        check.ButtonTitle = "Dettagli";
                    }
                    break;
                case 4:
                    {
                        check.Image = "gamemark4.jpg";
                        check.Mark = "<div class=\"ribbon red\"><span>SOSPESO</span></div>";
                        check.ButtonTitle = "Dettagli";
                    }
                    break;
                case 5:
                    {
                        check.Image = "gamemark5.jpg";
                        check.Mark = "<div class=\"ribbon red\"><span>CHIUSO</span></div>";
                        check.ButtonTitle = "Dettagli";
                    }
                    break;
                case 6:
                    {
                        check.Image = "gamemark6.jpg";
                        check.Mark = "<div class=\"ribbon\"><span>TERMINATO</span></div>";
                        check.ButtonTitle = "Dettagli";
                    }
                    break;
            }
            return check;
        }

        public List<GameCheck> FindOpenGames()
        {
            List<Game> gameList = gameDao.FindAll().Where(g => g.Status == (int)GameStatus.OPEN).ToList();
            List<GameCheck> result = new List<GameCheck>();
            int index = 0;
            foreach (Game game in gameList)
            {
                index++;
                GameCheck check = new GameCheck(game);
                check.Mark = "<div class=\"ribbon blue\"><span>APERTO</span></div>";
                switch (index % 8)
                {
                    case 1:
                        {
                            check.Image = "gamemark1.jpg";
                        }
                        break;
                    case 2:
                        {
                            check.Image = "gamemark2.jpg";
                        }
                        break;
                    case 3:
                        {
                            check.Image = "gamemark3.jpg";
                        }
                        break;
                    case 4:
                        {
                            check.Image = "gamemark4.jpg";
                        }
                        break;
                    case 5:
                        {
                            check.Image = "gamemark5.jpg";
                        }
                        break;
                    case 6:
                        {
                            check.Image = "gamemark6.jpg";
                        }
                        break;
                    case 7:
                        {
                            check.Image = "gamemark7.jpg";
                        }
                        break;
                    case 0:
                        {
                            check.Image = "gamebg.jpeg";
                        }
                        break;
                }
                result.Add(check);
            }
            return result;
        }

        public bool DeleteGame(int id)
        {
            Game item = gameDao.FindByID(id);
            if (item == null) return false;

            return gameDao.Delete(id);
        }

        public bool SaveGame(int? gameID, string title, DateTime? sdate, DateTime? edate, double fee, double tax, 
            int status, int minPlayers, int teamNum, string note, double percent1, double percent2, double percent3, 
            double percent4, double percent5, int numOfWinners, List<int> teamList, string image1, string image2)
        {
            Game game = gameDao.FindByID(gameID ?? 0);
            if (game == null)
            {
                game = new Game();
                game.Title = title;
                game.Note = note;
                game.Fee = fee; 
                game.Tax = tax;
                game.MinPlayers = minPlayers; 
                game.NumberOfTeams = teamNum;
                game.StartDate = sdate;
                game.EndDate = edate;
                //game.Status = status;
                game.Status = (int)GameStatus.OPEN;
                game.PercentForFirst = percent1;
                game.PercentForSecond = percent2;
                game.PercentForThird = percent3;
                game.PercentForForth = percent4;
                game.PercentForFifth = percent5;
                game.NumOfWinners = numOfWinners;
                game.Image1 = image1;
                game.Image2 = image2;

                int savedGameID =  gameDao.Insert(game);
                foreach (int teamID in teamList)
                {
                    TeamsForGame teamsForGame = new TeamsForGame();
                    teamsForGame.TeamID = teamID;
                    teamsForGame.GameID = savedGameID;
                    teamForGameDao.Insert(teamsForGame);
                }

                // Create First Round for New Game
                AddNewRound(savedGameID, 1);

                return true;
            }
            else
            {
                game.Title = title;
                game.Note = note;
                game.Fee = fee;
                game.Tax = tax;
                game.MinPlayers = minPlayers;
                game.NumberOfTeams = teamNum;
                game.StartDate = sdate;
                game.EndDate = edate;
                game.Status = status;
                game.PercentForFirst = percent1;
                game.PercentForSecond = percent2;
                game.PercentForThird = percent3;
                game.PercentForForth = percent4;
                game.PercentForFifth = percent5;
                game.NumOfWinners = numOfWinners;
                if (!string.IsNullOrEmpty(image1)) game.Image1 = image1;
                if (!string.IsNullOrEmpty(image2)) game.Image2 = image2;

                List<int> existedTeamList = teamForGameDao.FindByGame(game.Id).Select(t => t.TeamID ?? 0).ToList();
                bool areEqual = existedTeamList.OrderBy(x => x).SequenceEqual(teamList.OrderBy(x => x));
                if (teamList.Count != 0 && !areEqual)
                {
                    teamForGameDao.DeleteByGame(game.Id);
                    foreach (int teamID in teamList)
                    {
                        TeamsForGame teamsForGame = new TeamsForGame();
                        teamsForGame.TeamID = teamID;
                        teamsForGame.GameID = gameID;
                        teamForGameDao.Insert(teamsForGame);
                    }
                }
                bool success = gameDao.Update(game);

                //////////////////////////
                // If Game status is changed to Completed or Closed by SA manually, add Winners to the game.
                if (game.Status == (int)GameStatus.COMPLETED || game.Status == (int)GameStatus.CLOSED)
                {
                    List<Winner> winners = new WinnerDAO().FindByGame(game.Id);
                    if (winners.Count() == 0)
                    {
                        WinnerController winnerController = new WinnerController();
                        success = winnerController.AddWinners(game.Id);
                    }
                }

                // AUTO OPERATION WHEN Friday 18:00
                // Game Status change from OPEN/TEAM CHOICE to STARTED
                // Add Game prize if game status change from OPEN to STARTED
                // Assign teams to tickets without Team in current round
                // TO REMOVE 
                if (game.Status == (int)GameStatus.STARTED)
                {
                    game.Prize = (game.Fee ?? 0) * (game.RealPlayers ?? 0) * (100 - (game.Tax ?? 0)) / 100;
                    gameDao.Update(game);

                    List<Ticket> ticketList = new TicketDAO().FindByGame(game.Id);
                    TicketResultDAO ticketResultDAO = new TicketResultDAO();
                    List<int> allteamList = new TeamsForGameDAO().FindByGame(game.Id).OrderBy(t => t.Team.Description).Select(t => t.TeamID ?? 0).ToList();
                    foreach (Ticket ticket in ticketList)
                    {
                        List<TicketResult> ticketResults = ticketResultDAO.FindByTicket(ticket.Id);
                        List<int> assignedTeamList = ticketResults.Select(t => t.TeamID ?? 0).ToList();
                        if (ticketResults.Count() == 0) continue;
                        TicketResult lastticketResult = ticketResults[ticketResults.Count() - 1];
                        if (lastticketResult.RoundResult != null && lastticketResult.TeamID == null)
                        {
                            lastticketResult.TeamID = allteamList.Where(i => !assignedTeamList.Contains(i)).FirstOrDefault();
                            ticketResultDAO.Update(lastticketResult);
                        }
                    }
                }
                ///////////////////////
                return success;
            }
        }

        public List<TeamsForGameCheck> FindResults(int gameID)
        {
            List<TeamsForGame> teamList = teamForGameDao.FindByGame(gameID);
            List<TeamsForGameCheck> result = new List<TeamsForGameCheck>();
            foreach (TeamsForGame team in teamList)
            {
                TeamsForGameCheck teamForGameCheck = new TeamsForGameCheck(team);
                List<Result> resultList = resultDao.FindByTeamsForGame(team.Id);
                List<ResultCheck> resutlCheckList = new List<ResultCheck>();
                foreach (Result resultResult in resultList)
                {
                    ResultCheck resultCheck = new ResultCheck(resultResult);
                    resutlCheckList.Add(resultCheck);
                }
                teamForGameCheck.Results = resutlCheckList;
                result.Add(teamForGameCheck);
            }
            return result;
        }
        public List<string> FindTeams(int gameID)
        {
            List<TeamsForGame> teamList = teamForGameDao.FindByGame(gameID);
            List<string> result = new List<string>();
            foreach (TeamsForGame team in teamList)
            {
                result.Add(team.Team.Description);
            }
            return result;
        }
        public bool AddNewRound(int gameID, int? Round)
        {
            List<TeamsForGame> teamList = teamForGameDao.FindByGame(gameID);
            bool success = true;
            foreach (TeamsForGame team in teamList)
            {
                Result result = new Result();
                result.TeamForGameID = team.Id;
                result.RoundNo = Round;
                result.RoundResult = (int)RoundResult.N;
                success = resultDao.Insert(result);
            }

            return success;
        }
    }
}