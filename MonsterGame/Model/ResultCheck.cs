using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame.Model
{
    public class ResultCheck
    {
        Result result;
        public ResultCheck() { }
        public ResultCheck(Result result)
        {
            this.result = result;
            if (result == null ) { return; }
            Id = result.Id;
            TeamForGameID = result.TeamForGameID ?? 0;
            RoundNo = result.RoundNo ?? 0;
            RoundResult = result.RoundResult ?? 0;
            Note = result.Note;
        }
        public int Id
        {
            get; set;
        }
        public int TeamForGameID
        {
            get; set;
        }
        public int RoundNo
        {
            get; set;
        }
        public int RoundResult
        {
            get; set;
        }
        public string Note
        {
            get; set;
        }
    }
}