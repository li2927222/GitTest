using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.web
{
    public partial class OrderDetail : System.Web.UI.Page
    {
        protected string order_id;
        protected string order_from;
        protected void Page_Load(object sender, EventArgs e)
        {
            //接受传来的值
            order_id = Request.Params["order_id"].ToString();
            order_from = Request.Params["order_from"].ToString();
            //     order_id = "XD00167997";
            //  order_from = "订单";
            string orderhstr = "";
            if (order_from == "微信")
            {
                orderhstr = " select a.o_id,a.dTime,a.state,sum(b.price*b.qty) as total,sum(b.qty) from wx_order as a , wx_orderSub as b where a.o_id = b.o_id and a.o_id = '" + order_id + "' group by a.o_id ,a.dTime,a.state";
            }
            else {
                orderhstr = " select a.sheet_id, CONVERT(varchar(100), a.dTime, 111) as dTime,a.state,sum(ISNULL(b.sQty,b.qty) *b.price) as total ,sum(ISNULL(b.sQty,b.qty))  from order_sheet as a,order_sub_sheet as b where a.sheet_id = b.sheet_id and  a.sheet_id = '" + order_id + "'group by a.sheet_id,a.dTime,a.state";
            };
            DataSet ds = SqlUtils.MSSQLHelper.Query(orderhstr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                sheet_id.InnerHtml = ds.Tables[0].Rows[0][0].ToString();
                dtime.InnerHtml = ds.Tables[0].Rows[0][1].ToString();
                state.InnerHtml = ds.Tables[0].Rows[0][2].ToString();
                total.InnerHtml = Convert.ToDouble(ds.Tables[0].Rows[0][3].ToString()).ToString("N");
                total_qty.InnerHtml = ds.Tables[0].Rows[0][4].ToString();
                total_mny.InnerHtml = Convert.ToDouble(ds.Tables[0].Rows[0][3].ToString()).ToString("N");
            }
            else { }
        }
    }
}