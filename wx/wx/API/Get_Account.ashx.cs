using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Web.SessionState;
namespace wx.API
{
    /// <summary>
    /// Get_Account 的摘要说明
    /// </summary>
    public class Get_Account : IHttpHandler, IRequiresSessionState
    {
        public  class AccInfo
        {
           public  string Cus_id;
           public string Cus_name;
           public decimal Effective_Balance;
           public decimal Yajin;
           public decimal Balance;
        }
        public void ProcessRequest(HttpContext context)
        {
            
            AccInfo ai = new AccInfo();
            string cus_id = context.Request.Params["cusid"].ToString();
            SqlParameter[] sp = {
                new SqlParameter("@cus_id", cus_id) };
            DataTable dr = SqlUtils.MSSQLHelper.PrecedureDs("wx_get_creline", sp);
            if (dr.Rows.Count>0)
            {
                ai.Cus_id= dr.Rows[0][0].ToString();
                ai.Cus_name = dr.Rows[0][1].ToString();
                ai.Effective_Balance = Math.Round(Convert.ToDecimal( dr.Rows[0][2].ToString()),2);
                ai.Yajin = Math.Round(Convert.ToDecimal(dr.Rows[0][3].ToString()), 2);
                ai.Balance = Math.Round(Convert.ToDecimal(dr.Rows[0][4].ToString()), 2);
            }
            context.Response.ContentType = "text/plain";
            UTF8Encoding utf8 = new UTF8Encoding();
            string rt = CrytUtils.Common.ObjectToJson<AccInfo>(ai, utf8);
            context.Response.Write(JsonConvert.DeserializeObject(rt));
        }
        //public  string ObjectToJson<T>(Object jsonObject, Encoding encoding)
        //{
        //    string result = String.Empty;
        //    DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(T));
        //    using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
        //    {
        //        serializer.WriteObject(ms, jsonObject);
        //        result = encoding.GetString(ms.ToArray());
        //    }
        //    return result;
        //}
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}