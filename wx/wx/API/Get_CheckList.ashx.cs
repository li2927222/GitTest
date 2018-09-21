using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace wx.API
{
    /// <summary>
    /// Get_CheckList 的摘要说明
    /// </summary>
    public class Get_CheckList : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string cusid = context.Request["cus_id"].ToString();
            string sqlstr = "select distinct a.log_id,a.CheckTime,b.con_name,a.Checkmark  from (select log_id, max(CheckTime) as CheckTime,MAX(CheckUser) as CheckUser,MAX(Checkmark) as Checkmark  from wx_CheckMark  where ccus_id = '"+cusid+
                "' and log_id is not NULL group by(log_id) ) as a left outer join contacts as b on a.CheckUser = b.wx_id order by a.log_id";
            DataSet ds = SqlUtils.MSSQLHelper.Query(sqlstr);
            string rtlist = "{\"list\":[";
            string rt = "";
            Model.Model.CheckList Ca = new Model.Model.CheckList();
            UTF8Encoding utf8 = new UTF8Encoding();
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    Ca.log_id = ds.Tables[0].Rows[i][0].ToString();
                    Ca.Checkdate = ds.Tables[0].Rows[i][1].ToString();
                    Ca.CheckUser = ds.Tables[0].Rows[i][2].ToString();
                    Ca.CheckMark = ds.Tables[0].Rows[i][3].ToString();                 
                    rt = CrytUtils.Common.ObjectToJson<Model.Model.CheckList>(Ca, utf8);
                    rtlist = rtlist + rt + ",";
                }
                rtlist = rtlist.Substring(0, rtlist.LastIndexOf(",")) + "]}";
            }
            else
            { rtlist = ""; }

            context.Response.ContentType = "text/plain";
            context.Response.Write(rtlist);
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