using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
namespace wx.API
{
    /// <summary>
    /// RtCashGiveup 的摘要说明
    /// </summary>
    public class RtCashGiveup : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string RtCash_num = context.Request["RtCash_num"].ToString();
            string sqlstr = "update con_pay set kind='废除' where id = '" + RtCash_num.Trim() + "' and kind='未处理'";
            //暂时无回滚逻辑
            int num = SqlUtils.MSSQLHelper.ExecuteSql(sqlstr);//返回更新行数。如果为0则已经被锁定或者被审核，则无法自己修改，否则就可以修改
            if (num == 1)
            {
                context.Response.Write(1);//1表示成功，0表示其他}


            }
            else {
                context.Response.Write(0);//1表示成功，0表示其他}
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