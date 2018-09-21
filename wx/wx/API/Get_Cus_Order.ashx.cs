using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// Get_Cus_Order 的摘要说明
    /// </summary>
    public class Get_Cus_Order : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string state = context.Request.Params["state"].ToString().Trim();
            string cus_id = context.Request.Params["cus_id"].ToString().Trim();
            string wx_id = context.Session["userid"].ToString();
            string start_date = context.Request.Params["start_date"].ToString();
            string end_date = context.Request.Params["end_date"].ToString();
            //  string wx_id = "fly_jaysue";
            //string cus_id = "0210143";
            //string state = "待审核";
            //start_date = "2016/09/01";
            //end_date = "2016/10/19";
            //DateTime dt = DateTime.ParseExact(end_date, "yyyy/MM/dd", System.Globalization.CultureInfo.InvariantCulture);
            //dt = dt.AddDays(1);
            //end_date = dt.ToString("yyyy/MM/dd");
            SqlParameter[] sp = {
                new SqlParameter("@wx_id", wx_id),
                new SqlParameter("@cus_id", cus_id),
                new SqlParameter("@start_date",start_date ),
                new SqlParameter("@end_date", end_date),
                new SqlParameter("@state", state),};
            DataTable dr = SqlUtils.MSSQLHelper.PrecedureDs("wx_get_orderList", sp);
            string rtstr = "";
         //   int a = dr.Rows[1][0].ToString().LastIndexOf(" ");
           // string tmp = dr.Rows[1][0].ToString().Substring(0, dr.Rows[1][0].ToString().LastIndexOf(" ") + 1);
           for (int i =0;i<dr.Rows.Count;i++)
            {//日期客户单号件数金额
                if (dr.Rows[i][5].ToString()!="")
                {
                    rtstr = rtstr + dr.Rows[i][0].ToString().Substring(0, dr.Rows[i][0].ToString().LastIndexOf(" ") + 1) + "|" + dr.Rows[i][1].ToString() + "|" + dr.Rows[i][2].ToString() + "|" + dr.Rows[i][4].ToString() + "|" + Convert.ToDouble(dr.Rows[i][5].ToString()).ToString("N") +
                "|" + dr.Rows[i][3].ToString() + "~";
                }
             
            }
            // string 
            context.Response.ContentType = "text/plain";
            context.Response.Write(rtstr);
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