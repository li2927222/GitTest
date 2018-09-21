using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// UpdatePreOrder 的摘要说明
    /// </summary>
    public class UpdatePreOrder : IHttpHandler, IRequiresSessionState
    {
        //更新购物车产品数量
        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            string mark = context.Request.Params["mark"].ToString();
            string num = context.Request.Params["num"].ToString();
            string pro_id = context.Request.Params["pro_id"].ToString();
            string cus_id = context.Request.Params["cus_id"].ToString();
             string wx_id = context.Session["userid"].ToString();
          //  string wx_id = "kh13851501509";
            string updatestr = "update wx_cart set qty=" + Convert.ToInt32(num) + " where cus_id ='" + cus_id + "' and pro_id='" + pro_id + "' and wx_id ='" + wx_id + "'";
            string deletestr = "delete from wx_cart where cus_id ='" + cus_id + "' and pro_id ='" + pro_id + "' and wx_id ='" + wx_id + "'";
            int rtmark = 0;//0表示错误'
            switch (mark)
            {

                case "add":
                    //
                    rtmark = SqlUtils.MSSQLHelper.ExecuteSql(updatestr);

                    break;
                case "minus":
                    //
                    rtmark = SqlUtils.MSSQLHelper.ExecuteSql(updatestr);
                    break;
                default:
                    //delete 删除该cus_id购物车的该产品
                    rtmark = SqlUtils.MSSQLHelper.ExecuteSql(deletestr);

                    break;
            }

            context.Response.Write(rtmark);
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