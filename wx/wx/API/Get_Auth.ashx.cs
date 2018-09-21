using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace wx.API
{
    /// <summary>
    /// Get_Auth 的摘要说明
    /// </summary>
    public class Get_Auth : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string rt = "";
            string sql = "SELECT (case Isopen when 'False' then 0 else  1 end)as isopen  FROM wx_modulem";
            DataSet ds0 = SqlUtils.MSSQLHelper.Query(sql);
            for (int i = 0; i < ds0.Tables[0].Rows.Count; i++)
            {
                rt += ds0.Tables[0].Rows[i][0].ToString();
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(rt);
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