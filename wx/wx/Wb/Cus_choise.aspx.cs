using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.Wb
{
    public partial class Cus_choise : System.Web.UI.Page
    {
        public  string str="" ;
        protected void Page_Load(object sender, EventArgs e)
        { 
           
             str = Request.Params["str"].ToString();
            //switch (str)
            //{
            //    case "Acc":
                  
            //        break;
            //    case "Detail":
                
            //        break;
            //    //case "":
                  
            //    //    break;
            //    default:
            //        break;
            //}
        }
    }
}