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
    public partial class Ordering : System.Web.UI.Page
    {
        public string cusidstr = "";//cusid
        public string cusnamestr = "";//cusname
        public string lowestcount = "";
        public string cuscre = "";
        public string cus_curstore = "";
        protected int count = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            cusidstr = Request.Params["cusid"].ToString();
            string wh_id = "";
            count = 0;
            cusnamestr = Request.Params["cusname"].ToString();
            string strr = "select wx_wh from customers where cus_id ='" + cusidstr + "'";
            DataSet dss = SqlUtils.MSSQLHelper.Query(strr);
            wh_id = dss.Tables[0].Rows[0][0].ToString();
            SqlParameter sp = new SqlParameter("@cus_id", cusidstr);
            SqlParameter[] sp1 = { new SqlParameter("@cus_id", cusidstr), new SqlParameter("@wh_id", wh_id)};

            DataTable dr = SqlUtils.MSSQLHelper.PrecedureDs("wx_get_productWithPrice", sp1);
            SqlParameter spcre = new SqlParameter("@cus_id", cusidstr);
            DataTable drcre = SqlUtils.MSSQLHelper.PrecedureDs("wx_get_creline", spcre);
            SqlParameter spcur = new SqlParameter("@cus_id", cusidstr);
            string drcur = SqlUtils.MSSQLHelper.PrecedureRet("wx_get_cusStockSum", sp);
            //根据类型循环添加html值，目前只手机
            string str = "SELECT case  when count(*)=0 THEN  max(customers.lowest_stock)else  count(*)*max(customers.lowest_stock)  end  FROM yxt_dealer,customers  "+
             "where levelcode like '%' + (select levelcode from yxt_dealer where cus_id = '"+ cusidstr +"')+'%' and customers.cus_id = '" + cusidstr + "'";
            string str1 = "SELECT  pro_std FROM products WHERE  cate_id in ( '060301')and (pro_std <> '') AND(price1 <> 0) AND(wx_hide = 0 OR wx_hide is NULL) GROUP BY pro_std ";
            DataSet ds = SqlUtils.MSSQLHelper.Query(str);
            DataSet ds1 = SqlUtils.MSSQLHelper.Query(str1);
            if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0][0].ToString() != "")
            { lowestcount = ds.Tables[0].Rows[0][0].ToString(); }
            else { lowestcount = "0"; }
            cus_curstore = drcur;
            string htmlnav = "";
            string[,] htmlstr = new string[ds1.Tables[0].Rows.Count, 2];
            if (ds1 != null)
            {
                for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                {
                    htmlnav = htmlnav + "<li  style='height: 0.3rem;'><a href='#st" + i + "' style='font-size:0.12rem;' >" + ds1.Tables[0].Rows[i][0].ToString() + "</a></li>";
                    htmlstr[i, 0] = ds1.Tables[0].Rows[i][0].ToString();
                    htmlstr[i, 1] = " <div class='section' id='" + "st" + i + "'>";//最终封装的时候
                }//

            }
            nav.InnerHtml = htmlnav;

            for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
            {

                //添加判断，如果该产品是该系列则加入到该系列的类型中
                for (int i = 0; i < dr.Rows.Count; i++)
                {
                    if (dr.Rows[i][2].ToString() != "" && dr.Rows[i][4].ToString().Trim() != "0")
                    {
                        if (htmlstr[j, 0].ToString().Trim() == dr.Rows[i][5].ToString().Trim())
                        {

                            htmlstr[j, 1] = htmlstr[j, 1] + "<div class='prt-lt' ><div class='lt-lt' id='" + count + "'><p class='pro' id = '" + dr.Rows[i][0].ToString() + "'> " + dr.Rows[i][1].ToString() + " </p>" +
                     " <p class='pr'>¥<span class='price' id='price_1'>" + Convert.ToDouble(dr.Rows[i][2].ToString()).ToString("0.00") + "</span></p></div> "
                     + "<div class='lt-rt'><p class='pr' id='pronum'>现存量:" + dr.Rows[i][4].ToString().Trim() + "</p><input type = 'button' class='minus'  value='-'/><input type = 'text' class='result' value='0'/>" +
                       "<input type = 'button' class='add' value='+'/></div></div>"; ;//封尾在集合封装的时候关闭
                      // break;//找到跳出循环，htmlstr的i值就是对应类型的应该填的位置                                              
                        }
                        count = count + 1;//用来标记是修改了哪一行
                    }
                }
                //    count = count + 1;//用来标记是修改了哪一行
            }
            for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
            {
                if (i == 0)
                { container.InnerHtml = htmlstr[i, 1] + "</div>"; ; }
                else { container.InnerHtml = container.InnerHtml + htmlstr[i, 1] + "</div>"; }

            }

            if (drcre.Rows.Count > 0 && drcre.Rows[0][0].ToString() != "")
            {
                cuscre = Convert.ToDouble(drcre.Rows[0][2].ToString()).ToString("0.00");

            }
            else
            { cuscre = "0"; }
        }
    }
}