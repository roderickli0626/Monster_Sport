using MonsterGame.Common;
using MonsterGame.DAO;
using MonsterGame.Model;
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

        public GameController()
        {
            gameDao = new GameDAO();
        }

        public List<GameCheck> FindAll()
        {
            List<Game> gameList = gameDao.FindAll();
            List<GameCheck> result = new List<GameCheck>();
            foreach (Game game in gameList)
            {
                GameCheck check = new GameCheck(game);
                switch (game.Status)
                {
                    case 1:
                        {
                            check.Image = "gamemark1.jpg";
                            check.Mark = "<div class=\"ribbon blue\"><span>OPENED</span></div>";
                        }break;
                    case 2:
                        {
                            check.Image = "gamemark2.jpg";
                            check.Mark = "<div class=\"ribbon red\"><span>STARTED</span></div>";
                        }break;
                    case 3:
                        {
                            check.Image = "gamemark3.jpg";
                            check.Mark = "<div class=\"ribbon red\"><span>TEAMCHOICE</span></div>";
                        }break;
                    case 4:
                        {
                            check.Image = "gamemark4.jpg";
                            check.Mark = "<div class=\"ribbon red\"><span>SUSPENDED</span></div>";
                        }break; 
                    case 5:
                        {
                            check.Image = "gamemark5.jpg";
                            check.Mark = "<div class=\"ribbon red\"><span>CLOSED</span></div>";
                        }break;
                    case 6:
                        {
                            check.Image = "gamemark6.png";
                            check.Mark = "<div class=\"ribbon\"><span>COMPLETED</span></div>";
                        }break;
                }
                result.Add(check);
            }
            return result;
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
    }
}