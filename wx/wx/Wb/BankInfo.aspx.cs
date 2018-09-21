using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.Wb
{
    public partial class BankInfo : System.Web.UI.Page
    {
        public string action_mark = "";
        public string accid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null || Request.Params["mark"] == null) { Response.Redirect("../web/Error.aspx"); }
            else
            {
                action_mark = Request.Params["mark"].ToString();
                if (action_mark == "update")
                {
                    accid = Request.Params["id"].ToString();
                }
            }  
        }
        public string Get_data(string tmp)
        {
            string AccountStr = "select distinct a.bank_name from con_selbank as a";
            string str = "<option value='0'>- 请选择 -</option><option value='1'>其它</option>";

            DataSet ds1 = SqlUtils.MSSQLHelper.Query(AccountStr);//卡号
            if (ds1 != null)//
            {

                if (tmp == "khbank")
                {

                    for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                    {
                        str = str + "<option value='" + i + 1 + "' style='color:#000'>" + ds1.Tables[0].Rows[i][0].ToString() + "</option>";

                    }
                }


            }
            else {
                str = str + "<option value='0'></option>";
            }

            return str;
        }
    }
}