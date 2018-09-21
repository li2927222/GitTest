using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// DxOrderSubmit 的摘要说明
    /// </summary>
    public class DxOrderSubmit : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string t_memo = context.Request.Params["t_memo"].ToString();
            string cus_id = context.Request.Params["cus_id"].ToString();
            string wx_id = context.Session["userid"].ToString();
            string wh_id = "";
            string str = "select wx_wh from customers where cus_id ='" + cus_id + "'";
            DataSet ds = SqlUtils.MSSQLHelper.Query(str);
            wh_id = ds.Tables[0].Rows[0][0].ToString();
            //string wx_id = "fly_jaysue";
            //  string cus_id = "0210143";
            SqlParameter[] sp = { new SqlParameter("@cus_id", cus_id), new SqlParameter("@wh_id", wh_id), new SqlParameter("@t_memo", t_memo), new SqlParameter("@wx_id", wx_id) };;
            DataTable dr = SqlUtils.MSSQLHelper.PrecedureDs("wx_place_order_dx", sp);
            //  string errormark = SqlUtils.MSSQLHelper.Errormark("wx_place_order", sp);
            string mark = "";
            int i = 0;
            for (int j = 0; j < dr.Rows.Count; j++)
            {
                if (i == 0)
                {
                    string[] arr = dr.Rows[j][0].ToString().Split(':');
                    switch (arr[0].ToString())
                    {
                        case "0"://0:订单生成成功
                                 //
                            mark = "0:0";
                            break;
                        case "1"://1:订单金额超可拿货额
                            mark = dr.Rows[j][0].ToString() + "," + dr.Rows[j][1].ToString() + "," + dr.Rows[j][2].ToString();
                            break;
                        case "2"://2:单品数量超仓库库存
                            mark = dr.Rows[j][0].ToString() + "," + dr.Rows[j][2].ToString() + "," + dr.Rows[j][3].ToString() + "," + dr.Rows[j][4].ToString();     //

                            break;
                        case "3"://3:单品数量超周转上限
                                 //
                            mark = dr.Rows[j][0].ToString() + "," + dr.Rows[j][2].ToString() + "," + dr.Rows[j][3].ToString() + "," + dr.Rows[j][4].ToString();
                            break;
                        default:
                            //错误9:订单未生成
                            mark = "9:9";
                            break;
                    }
                }
                else {
                    string[] arr = dr.Rows[j][0].ToString().Split(':');
                    switch (arr[0].ToString())
                    {
                        case "0"://0:订单生成成功
                                 //
                            mark = "0:0";
                            break;
                        case "1"://1:订单金额超可拿货额
                            mark = mark + "/" + dr.Rows[j][1].ToString() + "," + dr.Rows[j][2].ToString();
                            break;
                        case "2"://2:单品数量超仓库库存
                            mark = mark + "/" + dr.Rows[j][2].ToString() + "," + dr.Rows[j][3].ToString() + "," + dr.Rows[j][4].ToString();     //

                            break;
                        case "3"://3:单品数量超周转上限
                                 //
                            mark = mark + "/" + dr.Rows[j][2].ToString() + "," + dr.Rows[j][3].ToString() + "," + dr.Rows[j][4].ToString();
                            break;
                        default:
                            //错误9:订单未生成
                            mark = "9:9";
                            break;
                    }
                }

                i++;


            }

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