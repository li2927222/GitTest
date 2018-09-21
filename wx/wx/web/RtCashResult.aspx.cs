using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace wx.web
{
    public partial class RtCashResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null) { Response.Redirect("../web/Error.aspx"); }
            else {

                string userid = Session["userid"].ToString();//不给客户看到回款的对公账户    
                string strtext = "";
                // string    userid = "cus02";
                string datefrom = Request.Params["datefrom"].ToString();
                string dateto = Request.Params["dateto"].ToString();
                string cus = Request.Params["cus"].ToString();
                //如果传过来的值没有是null？
                if (datefrom == null) { datefrom = (DateTime.Now.AddMonths(-1)).ToString("yyyy-MM-dd"); }//系统当前时间提前半月
                if (dateto == null) { dateto = (DateTime.Now).ToString("yyyy-MM-dd"); }//系统当前时间
                if (cus == null||cus=="- 请选择 -") { strtext = "select cus_id,dTime,cBCode,amount from con_pay where wx_id = '" + userid + "'and dTime between '"+ datefrom +"'and '"+ dateto + "'" ; }
                else {
                    strtext = "select cus_id,dTime,cBCode,amount from con_pay where wx_id = '" + userid + "'and cus_id = '"+cus+"' and dTime between '" + datefrom + "'and '" + dateto + "'";
                }
             //   SqlParameter[] paras = new SqlParameter[] { new SqlParameter("@cus_id", cus) };

           
                    //  DataSet ds = SqlUtils.MSSQLHelper.Query(strtext, paras);
                   DataSet ds = SqlUtils.MSSQLHelper.Query(strtext);
                    //viewlist.DataSource = ds.Tables[0];
                    //viewlist.DataBind();
                    //拼接显示表格
                    int i = 0;
                    int count = ds.Tables[0].Rows.Count;
                    string[] arr = new string[count];

                    for (i = 0; i < count; i++)
                    {
                        arr[i] = "tb" + i;
                        HtmlTableCell tc3 = new HtmlTableCell();
                        Label lb3 = new Label();
                        lb3.Text = "客户名称";
                        lb3.Width = 200;
                        lb3.Font.Size = 15;
                        Label tb3 = new Label();//创建文本框对象  
                        tb3.Width = 200;//设定宽度  
                        tb3.ForeColor = System.Drawing.Color.LightSkyBlue;
                        tb3.Text = ds.Tables[0].Rows[i][0].ToString();//设定文本框中的值  
                        tc3.Controls.Add(lb3);
                        tc3.Controls.Add(tb3);//单元格内容赋值  

                        form1.Controls.Add(tc3);//将行添加到表中 

                        //应收
                        HtmlTableCell tc = new HtmlTableCell();
                        Label lb = new Label();
                        lb.Text = "回款日期";
                        Label tb = new Label();//创建文本框对象  
                        tb.Width = 200;//设定宽度 
                        tb.ForeColor = System.Drawing.Color.LightSkyBlue;
                        lb.Width = 200;
                        lb.Font.Size = 15;
                        tb.Text = ds.Tables[0].Rows[i][1].ToString();//设定文本框中的值  
                        tc.Controls.Add(lb);
                        tc.Controls.Add(tb);//单元格内容赋值  
                        form1.Controls.Add(tc);//将行添加到表中  
                                               //
                        HtmlTableCell tc1 = new HtmlTableCell();
                        Label lb1 = new Label();
                        lb1.Text = "回款账户";
                        lb1.Width = 200;
                        Label tb1 = new Label();//创建文本框对象  
                        tb1.Width = 200;//设定宽度  
                        tb1.ForeColor = System.Drawing.Color.LightSkyBlue;
                        lb1.Font.Size = 15;
                        tb1.Text = ds.Tables[0].Rows[i][2].ToString();//设定文本框中的值  
                        tc1.Controls.Add(lb1);
                        tc1.Controls.Add(tb1);//单元格内容赋值  
                        form1.Controls.Add(tc1);//将行添加到表中  
                                                //
                        HtmlTableCell tc2 = new HtmlTableCell();
                        Label lb2 = new Label();
                        lb2.Text = "回款金额";
                        lb2.Width = 200;
                        lb2.Font.Size = 15;
                        Label tb2 = new Label();//创建文本框对象  
                        tb2.Width = 200;//设定宽度  
                        tb2.ForeColor = System.Drawing.Color.LightSkyBlue;
                        tb2.Text = ds.Tables[0].Rows[i][3].ToString();//设定文本框中的值  
                        tc2.Controls.Add(lb2);
                        tc2.Controls.Add(tb2);//单元格内容赋值  
                        form1.Controls.Add(tc2);//将行添加到表中  

                        //换行
                        HtmlTableCell tc0 = new HtmlTableCell();
                        Label lb0 = new Label();
                        lb0.Height = 2;
                        lb0.Width = 500;
                        lb0.Text = "";
                        lb0.BackColor = System.Drawing.Color.LightSlateGray;
                        tc0.Controls.Add(lb0);//单元格内容赋值  
                        form1.Controls.Add(tc0);//将行添加到表中  
                    }
                
             
            }
          
        }
    }
}