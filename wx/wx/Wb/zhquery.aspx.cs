using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.Wb
{
    public partial class yjquery : System.Web.UI.Page
    {
        public string cusid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            cusid = Request.Params["cusid"].ToString();
        }
    }
}