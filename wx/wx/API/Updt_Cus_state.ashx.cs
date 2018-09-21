using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// Updt_Cus_state 的摘要说明
    /// </summary>
    public class Updt_Cus_state : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string mark = "0";
            string wx_id = context.Session["userid"].ToString();
            string cus_id = context.Request.Params["cus_id"].ToString();
            string cstate = context.Request.Params["mark"].ToString();
            string updtstr = "";
            if (cstate=="0")
            {  updtstr = "update customers set Last_update_people ='" + wx_id + "',Last_update_time ='" + System.DateTime.Now + "',cState ='已停用' where cus_id='" + cus_id + "'"; }
            else
            {  updtstr = "update customers set Last_update_people ='" + wx_id + "',Last_update_time ='" + System.DateTime.Now + "',cState ='正常' where cus_id='" + cus_id + "'"; }
          //  string updtstr = "update customers set Last_update_people ='" + wx_id + "',Last_update_time ='" + System.DateTime.Now + "',cState ='已停用' where cus_id='" + cus_id + "'";
            if (SqlUtils.MSSQLHelper.ExecuteSql(updtstr) > 0) { mark = "1"; }

            context.Response.ContentType = "text/plain";
            context.Response.Write(mark);
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