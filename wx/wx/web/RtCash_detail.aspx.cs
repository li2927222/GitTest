using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.web
{
    public partial class RtCash_detail : System.Web.UI.Page
    {
        public string rtid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["userid"] == null) { Response.Redirect("../web/Error.aspx"); } else
            {

                string userid = Session["userid"].ToString();//不给客户看到回款的对公账户    
                 rtid = Request.Params["rtid"].ToString();
                string state = Request.Params["state"].ToString().Trim();
                string strtext = "select a.cus_id,a.dTime,a.cBCode,a.amount,a.kind,a.cus_account,a.rtcash_num,a.tMemo,b.cus_name,c.cBName,a.Deposit,a.Margin,a.Count_Deposit from con_pay as a,customers as b,bank as c where a.cus_id= b.cus_id and c.cBCode = a.cBCode and wx_id = '" + userid + "'and a.id = '" + rtid.Trim() + "'";
                DataSet ds = SqlUtils.MSSQLHelper.Query(strtext);
                string deposit = "";
                string margin = "";
                string count_deposit = "";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    //label1.InnerText = rtcash_num;//可能为空的bug
                    label2.InnerText = ds.Tables[0].Rows[0][8].ToString();
                    label3.InnerText = ds.Tables[0].Rows[0][5].ToString();
                    label4.InnerText = ds.Tables[0].Rows[0][9].ToString();
                    if (string.IsNullOrEmpty(ds.Tables[0].Rows[0][10].ToString()))
                    { deposit = "0"; }
                    else { deposit = ds.Tables[0].Rows[0][10].ToString(); }
                    if (string.IsNullOrEmpty(ds.Tables[0].Rows[0][11].ToString()))
                    { margin = "0"; }
                    else { margin = ds.Tables[0].Rows[0][11].ToString(); }
                    if (string.IsNullOrEmpty(ds.Tables[0].Rows[0][12].ToString()))
                    { count_deposit = "0"; }
                    else { count_deposit = ds.Tables[0].Rows[0][12].ToString(); }
                    label5.InnerText = (Convert.ToDouble( ds.Tables[0].Rows[0][3].ToString())+ Convert.ToDouble(deposit)+ Convert.ToDouble(count_deposit)+ Convert.ToDouble(margin)).ToString("0.00") ;
                    label6.InnerText = string.Format("{0:yyyy/MM/dd}", ds.Tables[0].Rows[0][1]);
                    tmemo.InnerText = ds.Tables[0].Rows[0][7].ToString();
                    if (state == "未处理")
                    {
                        giveup.Visible = true;
                    }
                    else
                    {
                        giveup.Visible = false;
                    }
                }
                else
                {

                }
            }
            
        }
    }
}