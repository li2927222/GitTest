using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.web
{
    public partial class OauthProcess2 : System.Web.UI.Page
    {
        #region//静态量
       // private static string access_token = "rcGuUV-VtB5JfjeSgeGgbEtZsNeEpybSBKmT3TEYR1s-p7ss_puJPuQXeQkAFOkw";//这个access_token和主动调用的相同，公众号之类的要有区别。企业号可能在安全上已经做过一层次的保护不需要另外的加密
        #endregion
        public string dir = "";
        public string ischeckacc = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            string cusid = "";
            string cusname = "";
            string log_id = "";
            if (!IsPostBack)
            {
               
                //获取从wxProcess.aspx传递过来的跳转地址dir
                if (Request.QueryString["dir"] != null && Request.QueryString["dir"] != "")
                {
                    dir = Request.QueryString["dir"].ToString();
                    cusid = dir.Split('|')[0];
                    cusname = dir.Split('|')[1];
                    log_id = dir.Split('|')[2];
                }
                            
                string code = "";
                if (Request.QueryString["code"] != null && Request.QueryString["code"] != "")
                {
                    //获取微信回传的code
                    code = Request.QueryString["code"].ToString();
             
                    OAuthUser Model = Get_UserInfo(code);  //获取token,存入全局变量
                                                           //判断token是否有效
                   Session["userid"]= Model._UserId.ToString();    
                    
                  //   rtmsg msg = Get_Rtmsg(Model.access_token, Model.openid);这个token时长较长，但是关注的用户访问是直接pass的，所以此处无需验证                                
                    if (Model._UserId != null && Model._UserId != "")  //已获取得openid及其他信息
                    {
                        //    //在页面上输出用户信息


                        Response.Write("userid:" + Model._UserId +dir);
                        if (Request.QueryString["dir"] != null && Request.QueryString["dir"] != "")
                        { Response.Redirect("./Wb/CheckAccount.aspx?cusid="+cusid+"&cusname="+cusname+"&log_id="+log_id); }else
                       { Response.Redirect("./Wb/Default.aspx"); } 
                        //或跳转到自己的页面，想怎么处理就怎么处理
                      //  Response.Redirect("./web/Readme.aspx");
                        
                    }
                    else  //未获得openid，回到wxProcess.aspx，访问弹出微信授权页面
                    {
                        //Response.Redirect("wxProcess.aspx?auth=1");
                        Response.Write( code);
                       // Response.Redirect("./web/Readme.aspx?code="+code);
                    }
                }
            }
        }



        #region 属性
        public string appid = "wwf427ba730248b6c9";  //公众微信平台下可以找到
        public string appsecret = "fCx3vNAPMbdeonhKCPUoSN5vQPudNAObRIjIBTnoZXQ";
        #endregion



        //根据appid，secret，code获取微信openid、access token信息
        protected OAuthUser Get_UserInfo(string Code)
        {
            string access_token = Get_token();
                   string Str = GetJson("https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=" + access_token + "&code=" + Code);//企业号
            //微信回传的数据为Json格式，将Json格式转化成对象i
            OAuthUser Oauth_Token_Model = JsonHelper.ParseFromJson<OAuthUser>(Str);
            return Oauth_Token_Model;
        }
        protected string Get_token()
        {
            string url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=wwf427ba730248b6c9&corpsecret=Oc7XJ3G4DJmTVwey8srmVfSazk8ic2Ebk1VRRStFFL0";
            WebClient wc = new WebClient();
            wc.Credentials = CredentialCache.DefaultCredentials;
            wc.Encoding = Encoding.UTF8;
            string returnText = wc.DownloadString(url);


            Access_token at = JsonHelper.ParseFromJson<Access_token>(returnText);

            if (returnText.Contains("errcode"))
            {
                //可能发生错误
            }
            return at._access_token;//返回的值里面包含access_token，这个值应该每7200秒获取一次
        }
        //protected Access_Token()
        //{ }
        //访问微信url并返回微信信息
        protected string GetJson(string url)
        {
            WebClient wc = new WebClient();
            wc.Credentials = CredentialCache.DefaultCredentials;
            wc.Encoding = Encoding.UTF8;
            string returnText = wc.DownloadString(url);

            if (returnText.Contains("errcode"))
            {
                //可能发生错误
            }
            return returnText;
        }

        /// 用户信息类
        public class OAuthUser
        {
            public OAuthUser()
            {
            }
            public string _UserId;
            public string _DeviceId;
            public string UserId
            {
                set { _UserId = value; }
                get { return _UserId; }
            }
            public string DeviceId
            {
                set { _DeviceId = value; }
                get { return _DeviceId; }
            }

        }
        //获取access_toke值
        public class Access_token
        {
            public Access_token()
            {
            }
            public string _access_token;
            public string _expires_in;
            public string access_token
            {
                set { _access_token = value; }
                get { return _access_token; }
            }
            public string expires_in
            {
                set { _expires_in = value; }
                get { return _expires_in; }
            }

        }
        ///
        /// 将Json格式数据转化成对象
        ///
        public class JsonHelper
        {
            ///  
            /// 生成Json格式 
            ///  
            ///  
            ///  
            ///  
            public static string GetJson<T>(T obj)
            {
                DataContractJsonSerializer json = new DataContractJsonSerializer(obj.GetType());
                using (MemoryStream stream = new MemoryStream())
                {
                    json.WriteObject(stream, obj);
                    string szJson = Encoding.UTF8.GetString(stream.ToArray()); return szJson;
                }
            }
            ///  
            /// 获取Json的Model 
            ///  
            ///  
            ///  
            ///  
            public static T ParseFromJson<T>(string szJson)
            {
                T obj = Activator.CreateInstance<T>();
                using (MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(szJson)))
                {
                    DataContractJsonSerializer serializer = new DataContractJsonSerializer(obj.GetType());
                    return (T)serializer.ReadObject(ms);//json格式的字符串可以强转化成对象
                }
            }
        }

    }
}