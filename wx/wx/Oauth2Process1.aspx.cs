using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.web
{
    public partial class Oauth2Process1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //   string appid = "wxde814da6ae102dd9";
            string appid = "wwf427ba730248b6c9";
            if (!IsPostBack)
            {
                string dir = "";//目录导向
                //传递参数，获取用户信息后，可跳转到自己定义的页面
                if (Request.QueryString["dir"] != null && Request.QueryString["dir"] != "")
                {
                    dir = Request.QueryString["dir"].ToString();
                }
                else
                {
                    dir = "";//转到用户未登陆页面
                }            
                //弹出授权页面(如在不弹出授权页面基础下未获得openid，则弹出授权页面，提示用户授权)
                if (Request.QueryString["auth"] != null && Request.QueryString["auth"] != "" && Request.QueryString["auth"] == "1")
                {
                    Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appid + "&redirect_uri=http://www.lyvivo.top/Oauth2Process2.aspx?dir=" + dir  + "&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect");
                }
                else
                {
                    //不弹出授权页面
                    Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appid + "&redirect_uri=http://www.lyvivo.top/Oauth2Process2.aspx?dir=" + dir  + "&response_type=code&scope=snsapi_base&state=1#wechat_redirect");
                }
            }

        }
    }
}