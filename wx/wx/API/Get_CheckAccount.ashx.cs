using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using wx.Model;

namespace wx.API
{
    /// <summary>
    /// Get_CheckAccount 的摘要说明
    /// </summary>
    public class Get_CheckAccount : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string cusid = context.Request["cus_id"].ToString();
            string log_id = context.Request["log_id"].ToString();
            string sqlstr = "SELECT id,billdate,mm,cdigest,balance,CheckMark FROM wx_CheckMark where ccus_id='"+cusid+"' and log_id='"+log_id+"' order by id asc";
            //
            string sqlstr1 = "SELECT id,cus_id,cus_name,amount,log_id FROM wx_CheckMark_deposit where cus_id = '" + cusid + "' and log_id = '" + log_id + "'";//押金
            DataSet ds = SqlUtils.MSSQLHelper.Query(sqlstr);
            DataSet ds1 = SqlUtils.MSSQLHelper.Query(sqlstr1);
            string rtlist = "{\"list\":[";
            string rt = "";
            Model.Model.CheckAcc Ca = new Model.Model.CheckAcc();
            UTF8Encoding utf8 = new UTF8Encoding();
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    Ca.id = Convert.ToInt32(ds.Tables[0].Rows[i][0].ToString());
                    Ca.billdate = Convert.ToDateTime( ds.Tables[0].Rows[i][1] ).ToString("yyyy-MM-dd");
                    Ca.mm = -Convert.ToDecimal(ds.Tables[0].Rows[i][2]);
                    Ca.cdigets = ds.Tables[0].Rows[i][3].ToString();
                    Ca.balance = -Convert.ToDecimal(ds.Tables[0].Rows[i][4]);
                    Ca.Checkmark = ds.Tables[0].Rows[i][5].ToString();
                    rt = CrytUtils.Common.ObjectToJson<Model.Model.CheckAcc>(Ca, utf8);
                    rtlist = rtlist + rt + ",";
                }
                rtlist = rtlist.Substring(0, rtlist.LastIndexOf(",")) + "]}";
            }
            else
            { rtlist = ""; }
            if (ds1.Tables[0].Rows.Count>0) {
                rtlist = rtlist + "||" + ds1.Tables[0].Rows[0][3].ToString();
            }
            else { rtlist = rtlist + "||0"; }//没有生产的押金默认为0
           
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