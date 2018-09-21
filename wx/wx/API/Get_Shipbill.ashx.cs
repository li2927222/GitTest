using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using wx.SqlUtils;

namespace wx.API
{
    /// <summary>
    /// Get_Shipbill 的摘要说明
    /// </summary>
    public class Get_Shipbill : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string bill = context.Request.Params["bill"].ToString();
            string result = KdApiSearch.getOrderTracesByJson(bill);
            // JsonConvert.DeserializeObject(result);
            context.Response.ContentType = "text/plain";
            var a = JsonConvert.DeserializeObject(result);
            context.Response.Write(JsonConvert.DeserializeObject(result));
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