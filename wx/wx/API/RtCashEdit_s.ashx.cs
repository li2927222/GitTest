using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// RtCash_s 的摘要说明
    /// </summary>
    public class RtCash_s : IHttpHandler, IRequiresSessionState//要继承这个请求的session类才能获取前面设置的session
    {

        public static string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();

        public void ProcessRequest(HttpContext context)
        {
            string amount = context.Request["amount"].ToString();
            string date = context.Request["date"];
            string tmemo = context.Request["tmemo"].ToString();
            string khzh0 = context.Request["khzh0"].ToString();//拼接的字符，截取从/开始的后面的所有字符                                                             //  string   khzh = khzh0.Substring(khzh0.IndexOf("/")+1);
            string khzh = context.Request["khzh"].ToString();
            string gszh = context.Request["gszh"].ToString();//也是拼接的。。
            string cus = context.Request["cus"].ToString();//传过来的名称啊，尝试赋值在option-value,获取这个值传过来;
            string rtcash_num = context.Request["serverurl"].ToString();
            string wx_id = context.Session["userid"].ToString();
            string pic_num = context.Request["pic_num"].ToString();
            string deposit1 = "";
            string deposit2 = "";
            string margin = "";
            if (context.Request["mark"].ToString() == "0") { margin = context.Request["amount1"].ToString(); deposit1 = context.Request["amount2"].ToString(); deposit2 = context.Request["amount3"].ToString(); }
            string sqlstr = "insert into con_pay (cus_id, cBCode, kind, amount, tMemo, wx_id, cus_account,dTime,rtcash_num,Count_Deposit,Deposit,Margin,Pic_Load_Mark,pic_num) values('" + cus + "','" + gszh + "','未处理','" + amount + "','" + tmemo + "','" + wx_id + "','" + khzh0 + "','" + date + "','" + rtcash_num + "','" + deposit1 + "','" + deposit2 + "','" + margin + "','0','"+pic_num+"')";
            //查询con_rtcash_update是否有该wx_id的信息，如果不为空则更新，为空则插入
            //  string str = "select * from con_rtcash_lastinfo where wx_id ='" + wx_id + "'";
            // DataSet ds1 = SqlUtils.MSSQLHelper.Query(str);
            //int num1 = ds1.Tables[0].Rows.Count;
            //   int num2 = 0;
          //  string num = "fls";
            // string str1 = "insert into con_rtcash_lastinfo (wx_id,bank_last,cus_id_last,com_bank_last) values('" + wx_id + "','" + khzh0 + "','" + cus + "','" + gszh + "')";
            // string str2 = "update con_rtcash_lastinfo set bank_last = '" + khzh0 + "',cus_id_last='" + cus + "',com_bank_last='" + gszh + "' where wx_id='" + wx_id + "'";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                try
                {

                    //   if (num1 > 0)//更新
                    //  {
                    SqlUtils.MSSQLHelper.ExecuteSql(sqlstr);
                    //       SqlUtils.MSSQLHelper.ExecuteSql(str2);

                  //  num = "suc";
                    //}
                    //else
                    //{
                    //    SqlUtils.MSSQLHelper.ExecuteSql(sqlstr);
                    //    SqlUtils.MSSQLHelper.ExecuteSql(str1);

                    //    num = "suc";
                    //}
                    context.Response.Write("suc");
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    Utils.FileLogger.WriteErrorLog(context, ex.Message.ToString());
                }
                finally
                {
                    connection.Close();
                }
            }

                //};
                // if (num == "suc") {
             //   context.Response.Write("suc");
        //} else { context.Response.Write("fls"); };
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