using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// Rtcash_detail 的摘要说明
    /// </summary>
    public class Rtcash_detail : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
        string    datefrom = context.Request["datefrom"].ToString();
        string  dateto = context.Request["dateto"].ToString();
        string    cus = context.Request["cus"].ToString();//客户编号
                                                   //string datefrom = null;
                                                   //string dateto = null;
                                                   //string cus = "0";          
         string  userid =context.Session["userid"].ToString();//不给客户看到回款的对公账户
            string strtext = "";
            string htmlstr = "";
            if (datefrom == null) { datefrom = (DateTime.Now.AddMonths(-1)).ToString("yyyy-MM-dd"); }//系统当前时间提前半月
            if (dateto == null) { dateto = (DateTime.Now).ToString("yyyy-MM-dd"); }//系统当前时间
            if (cus == null || cus == "0") { strtext = "select cus_id,dTime,cBCode,amount,id,kind ,Margin,Deposit,Count_Deposit from con_pay where wx_id = '" + userid + "'and dTime between '" + datefrom + "'and '" + dateto + "' order by id desc"; }
            else {
                strtext = "select cus_id,dTime,cBCode,amount,id, kind,Margin,Deposit,Count_Deposit from con_pay where wx_id = '" + userid + "'and cus_id = '" + cus + "' and dTime between '" + datefrom + "'and '" + dateto + "' order by id desc";
            }
            DataSet ds = SqlUtils.MSSQLHelper.Query(strtext);
            string deposit = "";
            string margin = "";
            string count_deposit = "";
            int count = ds.Tables[0].Rows.Count;
            string rtdetail = "";
            if (count > 0)
            {

                for (int i = 0; i < count; i++)
                {//前台根据i值来传labeli的值获取明细
                    if (string.IsNullOrEmpty(ds.Tables[0].Rows[i][7].ToString()))
                    { deposit = "0"; }
                    else { deposit = ds.Tables[0].Rows[i][7].ToString(); }
                    if (string.IsNullOrEmpty(ds.Tables[0].Rows[i][6].ToString()))
                    { margin = "0"; }
                    else { margin = ds.Tables[0].Rows[i][6].ToString(); }
                    if (string.IsNullOrEmpty(ds.Tables[0].Rows[i][8].ToString()))
                    { count_deposit = "0"; }
                    else { count_deposit = ds.Tables[0].Rows[i][8].ToString(); }
                    rtdetail = rtdetail+ ds.Tables[0].Rows[i][4].ToString() + "|" + string.Format("{0:yyyy/MM/dd}", ds.Tables[0].Rows[i][1]) + "|" + (Convert.ToDouble(ds.Tables[0].Rows[i][3].ToString()) + Convert.ToDouble(margin) + Convert.ToDouble(deposit) + Convert.ToDouble(count_deposit)).ToString("0.00") + "|"
                       + ds.Tables[0].Rows[i][5].ToString()+",";

                }
            }
            context.Response.Write(rtdetail);

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