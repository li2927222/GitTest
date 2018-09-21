using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using wx.Utils;

namespace wx.Wb
{
    public partial class Default : System.Web.UI.Page
    {
        public string code = "";
        public string token1 = "";
        public string code1= "";
        protected void Page_Load(object sender, EventArgs e)
        {
        //Session["userid"] = "18615612868";//固定userid
            code1 = Session["userid"].ToString();//自动读取微信中userid
        }
        #region 属性
        public string appid = "wxa18c540ba64d0254";  
        public string appsecret = "IjdmpjpZ8fE_JS3qh8RRfJOc0gHKpAdMmmHzVI2kPFY";
        #endregion
        //protected string authtest()
        //{
        //    string rt = "";
        //    string sql = "SELECT (case Isopen when 'False' then 0 else  1 end)as isopen  FROM wx_modulem";
        //    DataSet ds0 = SqlUtils.MSSQLHelper.Query(sql);
        //    for (int i=0;i<ds0.Tables[0].Rows.Count;i++)
        //    {
        //        rt += ds0.Tables[0].Rows[i][0].ToString();
        //    }
        //    return rt;
        //}
        protected OAuthUser Get_UserInfo(string Code)
        {
            string access_token = Get_token();
            token1 = Get_token();
            Session["token"] = access_token;
            string Str = GetJson("https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=" + access_token + "&code=" + Code);//企业号
            OAuthUser Oauth_Token_Model = JsonHelper.ParseFromJson<OAuthUser>(Str);
            return Oauth_Token_Model;
        }
        protected string Get_token()
        {
            //string url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=wxa18c540ba64d0254&corpsecret=IjdmpjpZ8fE_JS3qh8RRfJOc0gHKpAdMmmHzVI2kPFY";
            string url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=wxa18c540ba64d0254&corpsecret=IjdmpjpZ8fE_JS3qh8RRfJOc0gHKpAdMmmHzVI2kPFY";
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