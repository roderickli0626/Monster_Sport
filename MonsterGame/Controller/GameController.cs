﻿using MonsterGame.Common;
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
            IEnumerable<Game> gameList = gameDao.FindAll();
            if (status != 0) gameList = gameList.Where(x => x.Status == status).ToList();
            if (!string.IsNullOrEmpty(searchVal)) gameList = gameList.Where(x => x.Title.Contains(searchVal)).ToList();

            result.TotalCount = gameList.Count();
            gameList = gameList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (Game game in gameList)
            {
                GameCheck gameCheck = AddData(game);
                List<TeamsForGame> teamList = new TeamsForGameDAO().FindByGame(game.Id).ToList();
                gameCheck.TeamList = teamList.Select(t => t.TeamID ?? 0).ToList();
                checks.Add(gameCheck);
            }
            result.ResultList = checks;

            return result;
        }
        public List<GameCheck> FindAll(int status, string search)
        {
            List<Game> gameList = gameDao.FindAll();
            if (status != 0) gameList = gameList.Where(x => x.Status == status).ToList();
            if (!string.IsNullOrEmpty(search)) gameList = gameList.Where(x => x.Title.Contains(search)).ToList();

            List<GameCheck> result = new List<GameCheck>();
            foreach (Game game in gameList)
            {
                GameCheck check = AddData(game);
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
                        check.Mark = "<div class=\"ribbon blue\"><span>OPENED</span></div>";
                        check.ButtonTitle = "Play Now";
                    }
                    break;
                case 2:
                    {
                        check.Image = "gamemark2.jpg";
                        check.Mark = "<div class=\"ribbon red\"><span>STARTED</span></div>";
                        check.ButtonTitle = "Detail";
                    }
                    break;
                case 3:
                    {
                        check.Image = "gamemark3.jpg";
                        check.Mark = "<div class=\"ribbon red\"><span>TEAMCHOICE</span></div>";
                        check.ButtonTitle = "Detail";
                    }
                    break;
                case 4:
                    {
                        check.Image = "gamemark4.jpg";
                        check.Mark = "<div class=\"ribbon red\"><span>SUSPENDED</span></div>";
                        check.ButtonTitle = "Detail";
                    }
                    break;
                case 5:
                    {
                        check.Image = "gamemark5.jpg";
                        check.Mark = "<div class=\"ribbon red\"><span>CLOSED</span></div>";
                        check.ButtonTitle = "Detail";
                    }
                    break;
                case 6:
                    {
                        check.Image = "gamemark6.png";
                        check.Mark = "<div class=\"ribbon\"><span>COMPLETED</span></div>";
                        check.ButtonTitle = "Detail";
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
                check.Mark = "<div class=\"ribbon blue\"><span>OPENED</span></div>";
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
                            check.Image = "gamemark6.png";
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
            double percent4, double percent5, double percent6, List<int> teamList)
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
                game.Status = status;
                game.PercentForFirst = percent1;
                game.PercentForSecond = percent2;
                game.PercentForThird = percent3;
                game.PercentForForth = percent4;
                game.PercentForFifth = percent5;

                int savedGameID =  gameDao.Insert(game);
                foreach (int teamID in teamList)
                {
                    TeamsForGame teamsForGame = new TeamsForGame();
                    teamsForGame.TeamID = teamID;
                    teamsForGame.GameID = savedGameID;
                    teamForGameDao.Insert(teamsForGame);
                }
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

                teamForGameDao.DeleteByGame(game.Id);
                foreach (int teamID in teamList)
                {
                    TeamsForGame teamsForGame = new TeamsForGame();
                    teamsForGame.TeamID = teamID;
                    teamsForGame.GameID = gameID;
                    teamForGameDao.Insert(teamsForGame);
                }

                return gameDao.Update(game);
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