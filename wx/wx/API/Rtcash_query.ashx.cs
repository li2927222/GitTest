using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// Rtcash_query 的摘要说明
    /// </summary>
    public class Rtcash_query : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string datefrom = context.Request.Params["datefrom"].ToString();
            string dateto = context.Request.Params["dateto"].ToString();
            string cus = context.Request.Params["cus_id"].ToString();//客户编号
            string state = context.Request.Params["state"].ToString(); //回款状态                                            //string datefrom = null;                                                                                                                 //string dateto = null;                                                                                                                //string cus = "0";
            string strtext = "";
            string htmlstr = "";
       //    string userid = "fly_jaysue";
            string userid = context.Session["userid"].ToString();                                                   
            if (datefrom == null) { datefrom = (DateTime.Now.AddMonths(-1)).ToString("yyyy-MM-dd"); }//系统当前时间提前半月
            if (dateto == null) { dateto = (DateTime.Now).ToString("yyyy-MM-dd"); }//系统当前时间
            if (cus == null || cus == "0") { strtext = "select b.cus_name,a.amount,a.rtcash_num, a.kind from con_pay as a,customers as b where a.cus_id = b.cus_id and a.wx_id = '" + userid + "'and a.dTime between '" + datefrom + "'and '" + dateto + "' and a.kind='"+ state+"' order by a.id desc"; }
            else {
                strtext = "select b.cus_name,a.amount,a.rtcash_num, a.kind from con_pay as a,customers as b where a.cus_id = b.cus_id and a.wx_id = '" + userid + "'and a.cus_id = '" + cus + "' and a.dTime between '" + datefrom + "'and '" + dateto + "' and a.kind='" + state + "' order by a.id desc";
            }
            DataSet ds = SqlUtils.MSSQLHelper.Query(strtext);
            int count = ds.Tables[0].Rows.Count;
            for (int i=0;i<count;i++)
            {
                htmlstr = htmlstr + ds.Tables[0].Rows[i][0].ToString() + "," + ds.Tables[0].Rows[i][1].ToString() + "," + ds.Tables[0].Rows[i][2].ToString() + "," + ds.Tables[0].Rows[i][3].ToString() + "|";
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(htmlstr);
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