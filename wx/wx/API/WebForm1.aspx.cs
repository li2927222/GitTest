using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.API
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string str = "1111111111111111111111111111111111111100111111111100101111000110111100000001011000000000110000110000";
            int k = str.Length;
            for (int  i = k;i<150;i++) {
                str = str + "0";

            }
            Response.Write(str+"/"+str.Length);
        }
    }
}