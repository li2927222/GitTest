using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// Get_Cus_Stateinfo 的摘要说明
    /// </summary>
    public class Get_Cus_Stateinfo : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            //接受cus_id返回cus_state_info
            string cus_id = context.Request.Params["cus_id"].ToString();//可能为零,不会为空
            string sqlstr = "select a.cus_name,a.cState,b.con_name,a.Last_update_time from customers as a left join contacts as b on a.Last_update_people = b.wx_id  where  a.cus_id='" + cus_id + "'";
            DataSet ds = SqlUtils.MSSQLHelper.Query(sqlstr);//客户能看到的银行
            string rtstr = "";
            if (ds.Tables[0].Rows.Count > 0)
            {//这里只会出现一条记录

                rtstr = ds.Tables[0].Rows[0][0].ToString() + "|" + ds.Tables[0].Rows[0][1].ToString() + "|" +
                ds.Tables[0].Rows[0][2].ToString() + "|" + ds.Tables[0].Rows[0][3].ToString();

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