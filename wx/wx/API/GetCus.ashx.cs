using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace wx.API
{
    /// <summary>
    /// GetCus 的摘要说明
    /// </summary>
    public class GetCus : IHttpHandler, IRequiresSessionState
    {      
        public void ProcessRequest(HttpContext context)
        {   
           string wx_id = context.Session["userid"].ToString();
       //     string wx_id = "admin01";
            string str = "select b.cus_id,b.cus_name,b.cState,b.cusC_id　from　con_cus as a,customers as b where a.cus_id = b.cus_id and a.wx_id= '" + wx_id + "'";
            DataSet ds = SqlUtils.MSSQLHelper.Query(str);
            string cusid = "0";
            string cusname = "-请选择-";
            string cusC_id = "";
            string temp = "";
           // string state = "0";
            if (ds.Tables[0].Rows.Count > 0)
            {
            //换成json格式的字符串
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    cusid = cusid + "," + ds.Tables[0].Rows[i][0].ToString();
                    cusname = cusname + "," + ds.Tables[0].Rows[i][1].ToString();
                    //  state=state+","+ ds.Tables[0].Rows[i][2].ToString();
                    cusC_id = cusC_id+ "," +ds.Tables[0].Rows[i][3].ToString();
                }
                 temp = cusid + "|" + cusname+"|"+cusC_id ;
                context.Response.Write(temp.Trim());
            }
            else
            { context.Response.Write(0); }//该联系人员未绑定客户

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