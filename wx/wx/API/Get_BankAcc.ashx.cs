using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// Get_BankAcc 的摘要说明
    /// </summary>
    public class Get_BankAcc : IHttpHandler, IRequiresSessionState
    {
        public class BankAcc{
            public int id;
            public string wx_id;
            public string acc_num;
            public string acc_bank;
            public string acc_kind;
            public string isNow;
            public string yhmx;
            public string isuse;
            public string acc_name;
        }
        public void ProcessRequest(HttpContext context)
        {
            BankAcc ai = new BankAcc();
            string userid = context.Session["userid"].ToString();
            //string userid = "admin01";
            string strtext = "SELECT  id,wx_id , acc_num ,acc_bank,acc_kind ,isNow,yhmx,isuse,acc_name FROM con_account where wx_id ='" + userid + "'";//
            DataSet ds = SqlUtils.MSSQLHelper.Query(strtext);
            //List<BankAcc> bk = new List<BankAcc> { };
            string rtlist = "";
            string rt = "";
            UTF8Encoding utf8 = new UTF8Encoding();
            if (ds.Tables[0].Rows.Count > 0)
            {
                rtlist = "{\"list\":[";
                for (int i=0;i<ds.Tables[0].Rows.Count;i++)
                {
                    ai.id =Convert.ToInt32( ds.Tables[0].Rows[i][0].ToString());
                    ai.wx_id = ds.Tables[0].Rows[i][1].ToString();
                    ai.acc_num = ds.Tables[0].Rows[i][2].ToString();
                    ai.acc_bank  = ds.Tables[0].Rows[i][3].ToString();
                    ai.acc_kind = ds.Tables[0].Rows[i][4].ToString();
                    ai.isNow = ds.Tables[0].Rows[i][5].ToString();
                    ai.yhmx = ds.Tables[0].Rows[i][6].ToString();
                    ai.isuse = ds.Tables[0].Rows[i][7].ToString();
                    ai.acc_name = ds.Tables[0].Rows[i][8].ToString();
                    // bk.Add(ai);
                    rt = CrytUtils.Common.ObjectToJson<BankAcc>(ai, utf8);
                    rtlist =rtlist+ rt + ",";
                }
                rtlist = rtlist.Substring(0, rtlist.LastIndexOf(",")) + "]}";
            }
            
            context.Response.ContentType = "text/plain";        
            context.Response.Write(JsonConvert.DeserializeObject(rtlist));
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}