using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// UpdtBank 的摘要说明
    /// </summary>
    public class UpdtBank : IHttpHandler, IRequiresSessionState
    {

        public static string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();

        public void ProcessRequest(HttpContext context)
        {
            string act = context.Request["act"].ToString().Trim();
            string idstr = context.Request["idstr"].ToString().Trim();
            if (act == "update")
            {
                int mark = 0;//告知前台是更新还是新增
                string def = context.Request["def"].ToString();
                string method = context.Request["method"].ToString();
                string bancard = context.Request["bankcard"].ToString();
                string zhmc = context.Request["khmc"].ToString();
                string zhkh = context.Request["khkh"].ToString();
              //  string wx_id = context.Session["userid"].ToString();
                string yhmx = context.Request["yhmx"].ToString();
             //   string cus_id = context.Request["cus_id"].ToString();
                // string wx_id = "cus02";

                 bool a;
                SqlConnection connection = new SqlConnection(connectionString);
                if (def == "0") { a = false; } else { a = true; };
                string sqlstr = "update con_account set isuse = 'true',acc_bank ='" + bancard + "',acc_name = '" + zhmc + "',acc_num = '" + zhkh + "',acc_kind ='" + method + "', yhmx = '" + yhmx + "',isNow='"+a+"' where id ='" + idstr + "'";

                //     sqlstr = "insert into con_account (wx_id, acc_name, acc_num, acc_bank, acc_kind, isNow,yhmx) values ('" + wx_id + "','" + zhmc + "','" + zhkh + "','" + bancard + "','" + method + "','" + a + "','" + yhmx + "')";
               // sqlstr = "";
                mark = SqlUtils.MSSQLHelper.ExecuteSql(sqlstr);//sqlstr不为空,更新插入成功标志}


                //获取返回受影响的行数来判断是否成功，更新回滚操作，用来防止错误的更新
                //账户名称和卡号相同视为更新操作，其他的视为插入
                //0更新，1新增

                //  sqlstr = "insert into con_account (wx_id, acc_name, acc_num, acc_bank, acc_kind, isNow) values ('admin01','test1','11111111','人行','银行卡','true')"
                context.Response.Write(mark);//更新成功标志
            }
            else if(act=="stop") {
                int mark = 0;
             
                string sqlstr = "update con_account set isuse = 'false' where id ='"+ idstr+"'";
                mark = SqlUtils.MSSQLHelper.ExecuteSql(sqlstr);//返回受影响的行数
                context.Response.Write(mark);//如果不为1则表示失败
            }
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