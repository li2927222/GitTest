using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace wx.API
{
    /// <summary>
    /// Detail_Reports 的摘要说明
    /// </summary>
    public class Detail_Reports : IHttpHandler
    {
 
        public void ProcessRequest(HttpContext context)
        {
            string bill_id = context.Request.Params["bill_id"].ToString().Trim();
            string rtstr = "";
            string str = "select b.cInvName,b.iTaxUnitPrice,iQuantity,iSum from DispatchList as a,DispatchLists as b where a.DLID = b.DLID and  a.cDLCode  = '" + bill_id+"' ";
            DataSet ds = SqlUtils.MSSQLHelper.Query1(str);
            var total_price = 0.00;
            for (int i= 0;i < ds.Tables[0].Rows.Count;i++)         
            {

                rtstr = rtstr + ds.Tables[0].Rows[i][0].ToString() + "|" + Convert.ToDouble(ds.Tables[0].Rows[i][1].ToString()).ToString("N") + "|" + Convert.ToDouble(ds.Tables[0].Rows[i][2].ToString()).ToString("N") + "|" + Convert.ToDouble(ds.Tables[0].Rows[i][3].ToString()).ToString("N") + ",,";
                total_price = total_price + Convert.ToDouble(ds.Tables[0].Rows[i][3].ToString());

            }
            rtstr = rtstr + ".total_price" + total_price.ToString("N");
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