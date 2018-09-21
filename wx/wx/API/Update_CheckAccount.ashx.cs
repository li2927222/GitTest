using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// Update_CheckAccount 的摘要说明
    /// </summary>
    public class Update_CheckAccount : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string cusid = context.Request["cus_id"].ToString();
            string log_id = context.Request["log_id"].ToString();//校验口令
            string wx_id = context.Session["userid"].ToString();
            // string pwdcheck = "";
            string sqlstr = "update wx_CheckMark set CheckMark='1',CheckUser ='"+ wx_id + "',CheckTime = GETDATE() where ccus_id = '"+cusid+"' and Checkmark !='1' and log_id ='"+log_id+ "'";
            string sqlstr1 = "  update wx_CheckMark_rec set checkMark = '1' where log_id='" + log_id + "' and cus_id = '" + cusid + "'";
            if ((SqlUtils.MSSQLHelper.ExecuteSql(sqlstr) > 0)&& (SqlUtils.MSSQLHelper.ExecuteSql(sqlstr1) > 0))
            {
                context.Response.Write("ok");
            }
            else
            {
                context.Response.Write("fls");
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