using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.Wb
{
    public partial class ShipBill : System.Web.UI.Page
    {
        public string sigurate;
        protected string noncestr = "wangzhaohuanshigeshabi1";
        protected string ticket;
        protected static string assemble;

        protected void Page_Load(object sender, EventArgs e)
        {
            string timestamp = "1490236320";
            ticket = Get_jsapi_ticket();
            string url = "http://njvivo.passingerp.com/Wb/ShipBill.aspx";//当前网页的url，用来计算签名
            sigurate = GenSigurate(noncestr, timestamp, ticket, url);
        }
        public static string GenSigurate(string noncestr, string sTimeStamp, string jsapi_ticket, string url)
        {
            //步骤1.sort()含义为对所有待签名参数按照字段名的ASCII 码从小到大排序（字典序）
            //注意，此处是是按照【字段名】的ASCII字典序，而不是参数值的字典序（这个细节折磨我很久了)
            //0:jsapi_ticket 1:noncestr 2:timestamp 3:url;

            //步骤2.assemble()含义为根据步骤1中获的参数字段的顺序，使用URL键值对的格式（即key1 = value1 & key2 = value2…）拼接成字符串
            //string assemble = "jsapi_ticket=3fOo5UfWhmvRKnRGMmm6cWwmIxDMCnniyVYL2fqcz1I4GNU4054IOlif0dZjDaXUScEjoOnJWOVrdwTCkYrwSl&noncestr=CUMT1987wlrrlw&timestamp=1461565921&url=https://jackwangcumt.github.io/home.html";
            assemble = string.Format("jsapi_ticket={0}&noncestr={1}&timestamp={2}&url={3}", jsapi_ticket, noncestr, sTimeStamp, url);
            //步骤2.sha1()的含义为对在步骤2拼接好的字符串进行sha1。
            SHA1 sha;
            ASCIIEncoding enc;
            string hash = "";
            try
            {
                sha = new SHA1CryptoServiceProvider();
                enc = new System.Text.ASCIIEncoding();
                byte[] dataToHash = enc.GetBytes(assemble);
                byte[] dataHashed = sha.ComputeHash(dataToHash);
                hash = BitConverter.ToString(dataHashed).Replace("-", "");
                hash = hash.ToLower();
            }
            catch (Exception)
            {
                return "error";
                //写入日志
            }
            return hash;

        }
        protected string Get_jsapi_ticket()
        {
            string access_token = Get_token();
            string url = "https://qyapi.weixin.qq.com/cgi-bin/get_jsapi_ticket?access_token=" + access_token;
            WebClient wc = new WebClient();
            wc.Credentials = CredentialCache.DefaultCredentials;
            wc.Encoding = Encoding.UTF8;
            string returnText = wc.DownloadString(url);
            jsapi_ticket at = JsonHelper.ParseFromJson<jsapi_ticket>(returnText);

            if (returnText.Contains("errcode"))
            {
                //可能发生错误
            }
            return at._ticket;//返回的值里面包含access_token，这个值应该每7200秒获取一次
        }
        protected string Get_token()
        {
            //string url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=wxde814da6ae102dd9&corpsecret=irAgDRT7BBJ-WQ7JCMnh8df9moQcp7Vv1wy6iZfHR8IPhFySoi8qKchqebr4wEdu";
            string url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=wxa18c540ba64d0254&corpsecret=IjdmpjpZ8fE_JS3qh8RRfJOc0gHKpAdMmmHzVI2kPFY";//njvivo
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
        public static string GetTimeStamp()
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
            return Convert.ToInt64(ts.TotalSeconds).ToString();
        }
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
        public class jsapi_ticket
        {
            public string _errcode;
            public string _errmsg;
            public string _ticket;
            public string _expires_in;//票据过期时间
            public string Errcode
            {
                set { _errcode = value; }
                get { return _errcode; }
            }

            public string errmsg
            {
                get
                {
                    return _errmsg;
                }

                set
                {
                    _errmsg = value;
                }
            }
            public string ticket
            {
                get
                {
                    return _ticket;
                }

                set
                {
                    _ticket = value;
                }
            }

            public string expires_in
            {
                get
                {
                    return _expires_in;
                }

                set
                {
                    _expires_in = value;
                }
            }
        }
        public class JsonHelper
        {
            /// 生成Json格式 
            public static string GetJson<T>(T obj)
            {
                DataContractJsonSerializer json = new DataContractJsonSerializer(obj.GetType());
                using (MemoryStream stream = new MemoryStream())
                {
                    json.WriteObject(stream, obj);
                    string szJson = Encoding.UTF8.GetString(stream.ToArray()); return szJson;
                }
            }
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