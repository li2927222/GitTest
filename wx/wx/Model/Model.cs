using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace wx.Model
{
    public class Model
    {
        public class Addinfo
        {
            public Message Mss = new Message();
            public int id;
            public string Name;
            public string Telephone;
            public string Province;
            public string City;
            public string County;
            public string address;
            public string checkdefault;
                
           
        }
        public class CheckAcc
        {
            public int id;
            public string billdate;
            public string ccus_id;
            public string ccUs_name;
            public decimal mm;
            public string cdigets;
            public decimal delivery;
            public decimal adjust;
            public decimal rt_pay;
            public string Checkmark;
            public decimal balance;
            public string CheckUser;
            public string CheckTime;
        }
        public class CheckList
        {
        public string CheckUser;
        public string log_id;
        public string Checkdate;
        public string CheckMark;
        }

        public class BankAcc
        {
            public Message Mss = new Message();
            public int id;
            public string wx_id;
            public string acc_name;
            public string acc_num;
            public string acc_bank;
            public string acc_kind;
            public string isNow;
            public string yhmc;
        }
        public class Message
        {
            public string state;
        }

    }
}