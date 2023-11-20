using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame.Model
{
    public class GameBoardCheck
    {
        GameBoard gameboard;
        public GameBoardCheck() { }
        public GameBoardCheck(GameBoard board) 
        { 
            this.gameboard = board;
            if (gameboard == null) { return; }
            Id = gameboard.Id;
            Title = gameboard.Title;
            Description = gameboard.Description;
            CreateDate = gameboard.CreatedDate?.ToString("dd/MM/yyyy HH.mm");
            GameId = gameboard.GameID ?? 0;
            CreaterId = gameboard.Creater ?? 0;
            GameTitle = gameboard.Game.Title;
            Creater = gameboard.User?.Name ?? "Super Admin";
            IsNew = gameboard.IsNew ?? false;
        }

        public int Id
        {
            get; set;
        }
        public string Title
        {
            get; set;
        }
        public string Description
        {
            get; set;
        }
        public string CreateDate
        {
            get; set;
        }
        public int GameId
        {
            get; set;
        }
        public string GameTitle
        {
            get; set;
        }
        public int CreaterId
        {
            get; set;
        }
        public string Creater
        {
            get; set;
        }
        public bool IsNew
        {
            get; set;
        }
    }
}