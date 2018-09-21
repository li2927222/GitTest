using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// BankManage 的摘要说明
    /// </summary>
    public class BankManage : IHttpHandler, IRequiresSessionState
    {
        //state码：ok成功，fls失败。
        public void ProcessRequest(HttpContext context)
        {
            string wx_id = context.Session["userid"].ToString();
            string mark = context.Request.Params["mark"].ToString();
            string str = "";
            Model.Model.BankAcc info = new Model.Model.BankAcc();
            if (mark == "add")
            {
                string khmc = context.Request.Params["khmc"].ToString();
                string zhkh = context.Request.Params["zhkh"].ToString();
                string payway = context.Request.Params["payway"].ToString();
                string khbank = context.Request.Params["khbank"].ToString();
                string bankdetail = context.Request.Params["bankdetail"].ToString();
                string check = context.Request.Params["Def_select"].ToString();

                if (check == "true")
                {
                    string ckupdate = "update  con_account set isNow = 'false' where wx_id = '" + wx_id + "'";
                    SqlUtils.MSSQLHelper.ExecuteSql(ckupdate);
                }//如果当前更新的为默认地址，先使该用户其他关联的地址的默认为false，然后更新当前的记录
                str = "insert into con_account (wx_id, acc_name, acc_num, acc_bank, acc_kind, isNow,yhmx) values ('" + wx_id + "','" + khmc + "','" + zhkh + "','" + khbank + "','" + payway + "','1','" + bankdetail + "')";
                int tmp = SqlUtils.MSSQLHelper.ExecuteSql(str);
                if (tmp > 0) { info.Mss.state = "ok"; } else { info.Mss.state = "fls"; }
            }
            else if (mark == "update")
            {
                string khmc = context.Request.Params["khmc"].ToString();
                string zhkh = context.Request.Params["zhkh"].ToString();
                string payway = context.Request.Params["payway"].ToString();
                string khbank = context.Request.Params["khbank"].ToString();
                string bankdetail = context.Request.Params["bankdetail"].ToString();
                string check = context.Request.Params["Def_select"].ToString();
                int id = Convert.ToInt32(context.Request.Params["accid"].ToString());
                if (check == "true")
                {
                    string ckupdate = "update  con_account set isNow = 'false' where wx_id = '" + wx_id + "'";
                    SqlUtils.MSSQLHelper.ExecuteSql(ckupdate);
                }//如果当前更新的为默认地址，先使该用户其他关联的地址的默认为false，然后更新当前的记录
                str = "update con_account set acc_name='" + khmc + "' , acc_num='" + zhkh + "' , acc_bank='" + khbank + "' , acc_kind='" + payway + "' , yhmx = '" + bankdetail + "' , isNow = '" + check + "' where id =" + id;
                int tmp = SqlUtils.MSSQLHelper.ExecuteSql(str);
                if (tmp > 0) { info.Mss.state = "ok"; } else { info.Mss.state = "fls"; }

            }
            else if (mark == "query")
            {
                int id = Convert.ToInt32(context.Request.Params["accid"].ToString());
                str = "SELECT id,acc_name,acc_num ,acc_bank ,acc_kind ,isNow ,yhmx FROM con_account where  id =" + id;
                DataSet ds = SqlUtils.MSSQLHelper.Query(str);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    info.id = Convert.ToInt32(ds.Tables[0].Rows[0][0].ToString());
                    info.acc_name = ds.Tables[0].Rows[0][1].ToString();
                    info.acc_num = ds.Tables[0].Rows[0][2].ToString();
                    info.acc_bank = ds.Tables[0].Rows[0][3].ToString();
                    info.acc_kind = ds.Tables[0].Rows[0][4].ToString();
                    info.isNow = ds.Tables[0].Rows[0][5].ToString();
                    info.yhmc = ds.Tables[0].Rows[0][6].ToString();
                    info.Mss.state = "ok";
                }
            }
            else if (mark == "delete")
            {
                int id = Convert.ToInt32(context.Request.Params["accid"].ToString());
                str = "delete from con_account where id =" + id;
                int tmp = SqlUtils.MSSQLHelper.ExecuteSql(str);
                if (tmp > 0) { info.Mss.state = "ok"; } else { info.Mss.state = "fls"; }
            }
            UTF8Encoding utf8 = new UTF8Encoding();
            string rt = CrytUtils.Common.ObjectToJson<Model.Model.BankAcc>(info, utf8);
            context.Response.Write(JsonConvert.DeserializeObject(rt));

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