using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace wx.API
{
    /// <summary>
    /// Get_Ar_detail 的摘要说明
    /// </summary>
    public class Get_Ar_detail : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string cus_id = context.Request.Params["cus_id"].ToString().Trim();
            SqlParameter[] sp = {
                new SqlParameter("@cus_id", cus_id) };
            DataTable dr = SqlUtils.MSSQLHelper.PrecedureDs1("wx_get_detaillist", sp);
            //返回
            string rtstr = "";
            string regstr = "\\A[S]{1}";
            string regstr1 = "\\A[R]{1}";
            //var a=   Regex.IsMatch("S0001",regstr);
            //var b = Regex.IsMatch("S0001", regstr1);
            var djlx = "";
            for (int i = 0; i < dr.Rows.Count; i++)
            {//日期客户单号件数金额
                if (dr.Rows[i][8].ToString()=="27")
                { djlx = "发退货单"; }
                else if (dr.Rows[i][8].ToString()=="48")
                { djlx = "收付款单"; }
                else { djlx = "调账单"; }// RO
                    rtstr = rtstr + string.Format("{0:d}", dr.Rows[i][1])+ "|"+djlx+"|" + Convert.ToDouble(dr.Rows[i][3].ToString()).ToString("N") + "|"  + Convert.ToDouble(dr.Rows[i][4].ToString()).ToString("N") + "|" + dr.Rows[i][5].ToString()+"|"+ dr.Rows[i][6].ToString()+"|"+ dr.Rows[i][6].ToString()+ ",,";
               

            }
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