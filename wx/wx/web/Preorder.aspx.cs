using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.web
{
    public partial class Preorder : System.Web.UI.Page
    {
        protected string cusname;
        protected int count;
        protected string cusid;
        public string lowestcount = "";
        public string cuscre = "";
        public string cus_curstore = "";
        protected void Page_Load(object sender, EventArgs e)
        {
           string wx_id = Session["userid"].ToString();
         //  string wx_id = "kh13584012107";
          string   cusidstr = Request.Params["cusid"].ToString();
           cusname = Request.Params["cusname"].ToString();
         // cusname = "测试门店";
            //循环输出html 从购物车获取
           //string cusidstr = "0210010";
            cusid = cusidstr;
            SqlParameter[] sp = { new SqlParameter("@cus_id", cusid), new SqlParameter("@wx_id", wx_id) };
            SqlParameter sp1 = new SqlParameter("@cus_id", cusidstr);
            SqlParameter spcre = new SqlParameter("@cus_id", cusidstr);
            DataTable drcre = SqlUtils.MSSQLHelper.PrecedureDs("wx_get_creline", spcre);
            SqlParameter spcur = new SqlParameter("@cus_id", cusidstr);
            string  drcur = SqlUtils.MSSQLHelper.PrecedureRet("wx_get_cusStockSum", sp1);
            //根据类型循环添加html值，目前只手机
            string str = "SELECT case  when count(*)=0 THEN  max(customers.lowest_stock)else  count(*)*max(customers.lowest_stock)  end  FROM yxt_dealer,customers  " +
            "where levelcode like '%' + (select levelcode from yxt_dealer where cus_id = '" + cusidstr + "')+'%' and customers.cus_id = '" + cusidstr + "'";
            // string str = "select lowest_stock,cus_id  from customers where cus_id =  '" + cusidstr + "'";
            DataTable dr = SqlUtils.MSSQLHelper.PrecedureDs("wx_get_cart", sp);
            DataSet ds = SqlUtils.MSSQLHelper.Query(str);
            if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0][0].ToString()!="")
            { lowestcount = ds.Tables[0].Rows[0][0].ToString(); }
            else { lowestcount = "0"; }
            cus_curstore = drcur;
            string htmlstr = "";
            count = 0;
           for(int i=0;i<dr.Rows.Count;i++)
            {
                htmlstr = htmlstr + "<div class='prt1-lt'><div class='lt-lt' id= '" + count + "'> <p class='pro' id='" + dr.Rows[i][0].ToString() + "'>" + dr.Rows[i][1].ToString() + "</p> <p class='pr'>¥<span class='price'>" + Convert.ToDouble(dr.Rows[i][2].ToString()).ToString("0.00") + "</span></p></div> <div class='lt-ct'> " +
                   "</div> <div class='lt-rt'><p style=' color:#A1A09C;white-space: nowrap;text-overflow:ellipsis; overflow:hidden;font-size:0.12rem; margin-top:0;'>现存量:" + dr.Rows[i][4].ToString() + "</p><p style=' color:#A1A09C;white-space: nowrap;text-overflow:ellipsis; overflow:hidden;font-size:0.12rem; margin-top:0.02rem;'>可拿量:" + (dr.Rows[i][5].ToString().Split('.'))[0] + "</p><input type = 'button' class='minus'  value='-'/><input type = 'text' class='result' value='" + dr.Rows[i][3].ToString() + "'/><input type = 'button' class='add' value='+'/>" +
          "</div><div class='lt-rt1'><img src = '../image/delete.png' style='width:0.3rem;height:0.3rem; margin-top:0.1rem'/></div></div>";
                //   }
                count = count + 1;//用来标记是修改了哪一行              
            }
            st1.InnerHtml = htmlstr;

            if (drcre.Rows.Count > 0 && drcre.Rows[0][0].ToString() != "")
            {
                cuscre = Convert.ToDouble(drcre.Rows[0][2].ToString()).ToString("0.00");

            }
            else
            { cuscre = "0"; }
        }
    }
}