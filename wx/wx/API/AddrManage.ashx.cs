using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.SessionState;
using wx.Model;
namespace wx.API
{
    /// <summary>
    /// AddrManage 的摘要说明
    /// </summary>
    public class AddrManage : IHttpHandler, IRequiresSessionState
    {
        //state码：ok成功，fls失败。
        public void ProcessRequest(HttpContext context)
        {
            string wx_id = context.Session["userid"].ToString();
            string mark =  context.Request.Params["mark"].ToString();
            string str = "";
            Model.Model.Addinfo info = new Model.Model.Addinfo();
            if (mark == "add")
            {
                string realname = context.Request.Params["realname"].ToString();
                string mobile = context.Request.Params["mobile"].ToString();
                string province = context.Request.Params["s_province"].ToString();
                string city = context.Request.Params["s_city"].ToString();
                string county = context.Request.Params["s_county"].ToString();
                string address = context.Request.Params["address"].ToString();
                string check = context.Request.Params["Def_select"].ToString();
             
                if (check == "true")
                {
                    string ckupdate = "update  wx_cus_delevery_addr set checkdefault = 'false' where wx_id = '" + wx_id + "'";
                    SqlUtils.MSSQLHelper.ExecuteSql(ckupdate);
                }//如果当前更新的为默认地址，先使该用户其他关联的地址的默认为false，然后更新当前的记录
                str = "insert into wx_cus_delevery_addr(realname,mobile,province,city,county,address,checkdefault,wx_id) values('" + realname + "','" + mobile + "','" + province + "','" + city + "','" + county + "','" + address + "','" + check + "','" + wx_id + "') ";
                int tmp = SqlUtils.MSSQLHelper.ExecuteSql(str);
                if (tmp > 0) { info.Mss.state = "ok"; } else { info.Mss.state = "fls"; }
            } else if (mark == "update")
            {
                string realname = context.Request.Params["realname"].ToString();
                string mobile = context.Request.Params["mobile"].ToString();
                string province = context.Request.Params["s_province"].ToString();
                string city = context.Request.Params["s_city"].ToString();
                string county = context.Request.Params["s_county"].ToString();
                string address = context.Request.Params["address"].ToString();
                string check = context.Request.Params["Def_select"].ToString();
                int id = Convert.ToInt32(context.Request.Params["addressid"].ToString());
                if (check == "true")
                {
                    string ckupdate = "update  wx_cus_delevery_addr set checkdefault = 'false' where wx_id = '" +wx_id+ "'";
                    SqlUtils.MSSQLHelper.ExecuteSql(ckupdate);
                }//如果当前更新的为默认地址，先使该用户其他关联的地址的默认为false，然后更新当前的记录
                str = "update wx_cus_delevery_addr set realname='" + realname + "' , mobile='" + mobile + "' , province='" + province + "' , city='" + city + "' , county ='" + county + "' , address = '" + address + "' , checkdefault = '" + check + "' where id =" + id;
                int tmp = SqlUtils.MSSQLHelper.ExecuteSql(str);
                if (tmp > 0) { info.Mss.state = "ok"; } else { info.Mss.state = "fls"; }

            }
            else if (mark == "query")
            {
                int id = Convert.ToInt32(context.Request.Params["addressid"].ToString());
                str = "SELECT id,realname ,mobile ,province,city,county ,[address],checkdefault FROM wx_cus_delevery_addr where  id =" + id;
                DataSet ds = SqlUtils.MSSQLHelper.Query(str);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    info.id = Convert.ToInt32(ds.Tables[0].Rows[0][0].ToString());
                    info.Name = ds.Tables[0].Rows[0][1].ToString();
                    info.Telephone = ds.Tables[0].Rows[0][2].ToString();
                    info.Province = ds.Tables[0].Rows[0][3].ToString();
                    info.City = ds.Tables[0].Rows[0][4].ToString();
                    info.County = ds.Tables[0].Rows[0][5].ToString();
                    info.address = ds.Tables[0].Rows[0][6].ToString();
                    info.checkdefault = ds.Tables[0].Rows[0][7].ToString();
                    info.Mss.state = "ok";
                }
            }
            else if (mark =="delete")
            {
                int id = Convert.ToInt32(context.Request.Params["addressid"].ToString());
                str = "delete from wx_cus_delevery_addr where id =" + id;
                int tmp = SqlUtils.MSSQLHelper.ExecuteSql(str);
                if (tmp > 0) { info.Mss.state = "ok"; } else { info.Mss.state = "fls"; }
            }
            UTF8Encoding utf8 = new UTF8Encoding();
            string rt = CrytUtils.Common.ObjectToJson<Model.Model.Addinfo>(info, utf8);
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