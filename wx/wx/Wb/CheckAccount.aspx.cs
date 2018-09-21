using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.Wb
{
    public partial class CheckAccount : System.Web.UI.Page
    {
        public string cus_id = "";
        public string cus_name = "";
        public string log_id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            cus_id = Request.Params["cusid"].ToString();
            cus_name = Request.Params["cusname"].ToString();
            log_id = Request.Params["log_id"].ToString();
        }
    }
}