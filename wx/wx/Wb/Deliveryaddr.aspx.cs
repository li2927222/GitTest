using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.Wb
{
    public partial class Deliveryaddr : System.Web.UI.Page
    {
        public string action_mark = "";
        public string addrid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            action_mark = Request.Params["mark"].ToString();
            if (action_mark =="update")
            {
                addrid = Request.Params["id"].ToString();
            }
         
        }
    }
}