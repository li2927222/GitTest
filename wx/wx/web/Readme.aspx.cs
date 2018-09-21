using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.web
{
    public partial class Readme : System.Web.UI.Page
    {
        public string code = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            code = Request.Params["code"].ToString();
        }
    }
}