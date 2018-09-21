using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.web
{
    public partial class Detail_Report : System.Web.UI.Page
    {
        public string cusidstr = "";//cusid
        public string cusname = "";
        protected void Page_Load(object sender, EventArgs e)
        {
             cusidstr = Request.Params["cusid"].ToString();
             cusname = Request.Params["cusname"].ToString();
        }
    }
}