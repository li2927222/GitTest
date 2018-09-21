using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// AddPreOrder 的摘要说明
    /// </summary>
    public class AddPreOrder : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string sqlstr = "";
            string wx_id = context.Session["userid"].ToString();
            string data = context.Request.Params["preorder"].ToString();
            //分组     
            string[] prol = data.Split('|');
            string[] pror = prol[0].Split(',');
            string sqlpre = "SELECT cus_id, pro_id, price, qty, pro_name FROM wx_cart where wx_id ='"+wx_id+"' and cus_id='"+pror[3]+"'";;
            DataSet ds = SqlUtils.MSSQLHelper.Query(sqlpre);
            //单行判断购物已经有了就修改数量，无则新增,当前客户联系人wx_id对应的临时购物车
         
            string tmp = "";
            for (int i = 0; i < prol.Length - 1; i++)
            {
                int mark = 0;
                pror = prol[i].Split(',');
                //循环判断是否在

                int j;
                for (j = 0; j < ds.Tables[0].Rows.Count; j++)
                {
                    if (pror[2] == ds.Tables[0].Rows[j][1].ToString())
                    { mark = 1; break; }

                }
                if (mark == 0)
                {
                    sqlstr = "insert into wx_cart (qty,price,pro_id,cus_id,pro_name,wx_id,Update_time) values('" + pror[0] + "','" + pror[1] + "','" + pror[2] + "','" + pror[3] + "','" + pror[4] + "','" + wx_id + "','"+DateTime.Now.ToLocalTime()+"')";
                }
                else
                {
                    string sqlstr1 = "select qty from wx_cart where wx_id ='" + wx_id + "' and pro_id ='" + pror[2] + "' and cus_id='" + pror[3] + "'"; //发现该客户联系人购物车，该客户，该产品型号的数量，用于添加当前的量
                    DataSet ds1 = SqlUtils.MSSQLHelper.Query(sqlstr1);
                    int temp = Convert.ToInt32(pror[0]) + Convert.ToInt32(ds.Tables[0].Rows[j][3]);//写在下面的string里会默认将两个都分别转换成string。。无法计算

                    sqlstr = "update wx_cart set qty = " +temp+ ",Update_time = '" + DateTime.Now.ToLocalTime() + "'  where pro_id ='" + pror[2] + "' and wx_id ='" + wx_id + "'and cus_id ='"+pror[3]+"'";
                    tmp = sqlstr;
                }
                SqlUtils.MSSQLHelper.ExecuteSql(sqlstr);
            };
            //无错误判断
            context.Response.Write(1);
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