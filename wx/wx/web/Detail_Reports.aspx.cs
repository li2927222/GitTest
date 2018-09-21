using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.web
{
    public partial class Detail_Reports : System.Web.UI.Page
    {
        protected string bill_id=""; 
        protected void Page_Load(object sender, EventArgs e)
        {
            bill_id = Request.Params["bill_id"].ToString();
        }
    }
}