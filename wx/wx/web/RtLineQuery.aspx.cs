using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.web
{
    public partial class RtLineQuery : System.Web.UI.Page
    {
        protected string datefrom;
        protected string dateto;
        protected string cus;
        protected string userid;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null) { Response.Redirect("../web/Error.aspx"); }
            else
            {
                 datefrom = Request.Params["datefrom"].ToString();
                 dateto = Request.Params["dateto"].ToString();
                 cus = Request.Params["cus"].ToString();//客户编号           
            }
        }
    }
}