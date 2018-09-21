using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace wx.API
{
    /// <summary>
    /// Get_Order_Detail 的摘要说明
    /// </summary>
    public class Get_Order_Detail : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string order_id = context.Request.Params["order_id"].ToString();
            string order_from = context.Request.Params["order_from"].ToString();


            string rtstr = "";



            try
            {
                SqlParameter[] sp = {
                new SqlParameter("@sheet_id",order_id ),
                new SqlParameter("@place",order_from)
                          };
                DataTable dr = SqlUtils.MSSQLHelper.PrecedureDs("wx_get_orderBody", sp);
               for(int i=0;i<dr.Rows.Count;i++)
                {//存货数量单价金额
                    rtstr = rtstr + dr.Rows[i][1].ToString() + "|" + dr.Rows[i][2].ToString() + "|" + Convert.ToDouble(dr.Rows[i][3].ToString()).ToString("N") + "|" + Convert.ToDouble(dr.Rows[i][4].ToString()).ToString("N") + "|" + dr.Rows[i][5].ToString()+ "~";
                }
                context.Response.ContentType = "text/plain";
                context.Response.Write(rtstr);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                //此处异常输出
                ex.ToString();
                context.Response.ContentType = "text/plain";
                context.Response.Write("0");//前台查看如果是0就弹出异常
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