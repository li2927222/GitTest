using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// Get_Addrlist 的摘要说明
    /// </summary>
    public class Get_Addrlist : IHttpHandler, IRequiresSessionState
    {
        public void ProcessRequest(HttpContext context)
        {
            Model.Model.Addinfo ai = new Model.Model.Addinfo();
             string userid = context.Session["userid"].ToString();
            string  str = "SELECT id,realname ,mobile ,province,city,county ,[address],checkdefault FROM wx_cus_delevery_addr where  wx_id ='" + userid+"'";
            DataSet ds = SqlUtils.MSSQLHelper.Query(str);
            string rtlist = "{\"list\":[";
            string rt = "";
            UTF8Encoding utf8 = new UTF8Encoding();
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    ai.id = Convert.ToInt32(ds.Tables[0].Rows[i][0].ToString());
                    ai.Name = ds.Tables[0].Rows[i][1].ToString();
                    ai.Telephone = ds.Tables[0].Rows[i][2].ToString();
                    ai.Province = ds.Tables[0].Rows[i][3].ToString();
                    ai.City = ds.Tables[0].Rows[i][4].ToString();
                    ai.County = ds.Tables[0].Rows[i][5].ToString();
                    ai.address = ds.Tables[0].Rows[i][6].ToString();
                    ai.checkdefault = ds.Tables[0].Rows[i][7].ToString();
                    rt = CrytUtils.Common.ObjectToJson<Model.Model.Addinfo>(ai, utf8);
                    rtlist = rtlist + rt + ",";
                }
                rtlist = rtlist.Substring(0, rtlist.LastIndexOf(",")) + "]}";
            }

            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.DeserializeObject(rtlist));
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