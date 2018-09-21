using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace wx.API
{
    /// <summary>
    /// ClearPreorder 的摘要说明
    /// </summary>
    public class ClearPreorder : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //清空购物车
            string cus_id = context.Request.Params["cus_id"].ToString();
            string str = "delete from wx_cart where cus_id='" + cus_id + "'";
            SqlUtils.MSSQLHelper.ExecuteSql(str);
            context.Response.ContentType = "text/plain";
            if (SqlUtils.MSSQLHelper.ExecuteSql(str) > 0)
            {
                context.Response.Write(1);//删除成功返回1，提交过程结束。
            }
            else {
                context.Response.Write(0);
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