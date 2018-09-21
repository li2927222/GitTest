using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.API
{
    public partial class test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //session作用在页面里，不作用在处理程序里，fuck
            int mark = 0;
            string def =  Request["def"];
            string method =  Request["method"];
            string bancard =  Request["bankcard"];
            string zhmc =  Request["zhmc"];
            string zhkh =  Request["zkkh"];
            string wx_id =  Session["userid"].ToString();
            string teststr = "select wx_id, acc_name, acc_num, acc_bank, acc_kind, isNow from con_account where wx_id = '" + wx_id + "'";
            string sqlsrt = "";
            DataSet ds = SqlUtils.MSSQLHelper.Query(teststr);
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (zhmc == ds.Tables[0].Rows[i][1].ToString() && zhkh == ds.Tables[0].Rows[i][2].ToString())
                {
                    string sqlstr = ""; //执行更新
                }
                else//执行插入
                {
                    string sqlstr = "";
                }
            }
            //获取返回受影响的行数来判断是否成功，更新回滚操作，用来防止错误的更新
            //账户名称和卡号相同视为更新操作，其他的视为插入
            //正确则返回成功success标志，错误error
            string temp = def + method + bancard + zhmc + zhkh;
             Response.Write(def);
        }
    }
}