using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// GetEcCus 的摘要说明
    /// </summary>
    public class GetEcCus : IHttpHandler, IRequiresSessionState
    {
        public void ProcessRequest(HttpContext context)
        {
             string    wx_id = context.Session["userid"].ToString();
            //string wx_id = "kh13584012107";
          //  context.Response.Write('1'+wx_id);
       
            string str = "select a.cus_id,a.dealername from" +
                " yxt_dealer as a,yxt_employee as b,yxt_employeeDealer as c where " +
                "a.dealerid = c.dealerid and b.employeecode = c.employeecode and  '" + wx_id + "' in( 'ec' + b.telephone, 'kh' + b.telephone) and a.cus_id <> ''";
            DataSet ds = SqlUtils.MSSQLHelper.Query(str);
            if (ds.Tables[0].Rows.Count > 0 )
            {
                string cusid = "0";
                string cusname = "-请选择-";
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (ds.Tables[0].Rows[i][0] != null || ds.Tables[0].Rows[i][0].ToString() !="")
                    {
                        cusid = cusid + "," + ds.Tables[0].Rows[i][0].ToString();
                        cusname = cusname + "," + ds.Tables[0].Rows[i][1].ToString();
                    }
               

                }
                string temp = cusid + "|" + cusname;
                context.Response.Write(temp.Trim());
            }
            else
            { context.Response.Write(0); }//该联系人员未绑定客户
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