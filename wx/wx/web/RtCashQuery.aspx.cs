using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace wx.web
{
    public partial class RtCashQuery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        public string getdata(string tmp)
        {
            string cusstr = "select distinct b.cus_name,b.cus_id from con_cus as a ,customers as b where a.cus_id = b.cus_id and a.wx_id = '" + Session["userid"].ToString() + "'"; //当前联系人绑定的客户
             DataSet ds = SqlUtils.MSSQLHelper.Query(cusstr);//客户选择
            string str = "";                                            //   string str = "";
         
            switch (tmp)
            {
             case"select1":
                    if (ds != null)
                    {
                        str = str + "<option value='0' style='color:#888'>- 请选择 -</lalel></option>";
                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                         str = str + "<option value='" + ds.Tables[0].Rows[i][1].ToString() + "'>" + ds.Tables[0].Rows[i][0].ToString() + "</option>"; 

                        }
                    }
                    else
                    {
                        str = "< option value = '0' >  无数据 </ option > ";
                    }
                    break;          
             default:break;
            }
            return str;
        }
    }
}