using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wx.web
{
 
    public partial class RtCash_s : System.Web.UI.Page
    {
        protected string str;//汇出账号
        protected string str1;//银行名
        protected string str2;//客户名
        protected string str3;//客户编码
        protected string str4;//银行编码
        protected string str5;
        protected string str6;
        protected string sigurate;
        protected string noncestr = "wangzhaohuanshigeshabi";
        protected string ticket;
        protected static string assemble;
        protected static string timestamp;
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["token"] = Get_token();
         //  Session["userid"] = "admin01";
            //查询token，判断当前时间戳差是否大于7200秒，大于则重新获取并刷新数据库时间戳，小于就用该数据库的时间戳      
             ticket = Get_jsapi_ticket();//同时给时间戳赋值   
               timestamp = GetTimeStamp();
              string url = "http://www.lyvivo.top/web/RtCash_s.aspx";//当前网页的url，用来计算签名
              sigurate = GenSigurate(noncestr, timestamp, ticket, url);
            //业务逻辑
            if (Session["userid"] == null) { Response.Redirect("../web/Error.aspx"); }
            else {
                string last_info = "select a.bank_last,b.bank_name,c.cus_name,a.com_bank_last,a.cus_id_last from con_rtcash_lastinfo as a ,con_selBank as b,customers as c where a.cus_id_last = c.cus_id and a.com_bank_last = b.bank_id and a.wx_id = '" + Session["userid"].ToString() + "'";
                DataSet ds = SqlUtils.MSSQLHelper.Query(last_info);
                int i = ds.Tables[0].Rows.Count;
                if (ds.Tables[0].Rows.Count > 0)
                {
                    str = ds.Tables[0].Rows[0][0].ToString().Replace("\n", "").Trim();
                    str1 = ds.Tables[0].Rows[0][1].ToString().Trim();
                    str2 = ds.Tables[0].Rows[0][2].ToString().Trim();
                    str3 = ds.Tables[0].Rows[0][4].ToString().Trim();
                    str4 = ds.Tables[0].Rows[0][3].ToString().Trim();
                    str5 = str.Substring(str.LastIndexOf("/") + 1).Trim();
                }
                else {
                    str2 = "- 请选择 -";
                    str = "- 请选择 -";
                    str3 = "0";
                    str4 = "0";
                    str5 = "0";
                }

            }//编号自动生成



        }
        public string getdata(string tmp)
        {
            string khstr = "select distinct b.cus_name,a.cus_id from con_cus as a ,customers as b where a.cus_id = b.cus_id and a.wx_id = '" + Session["userid"].ToString() + "'";
            string khzhstr = "select distinct a.acc_kind+'/'+ a.acc_name+'/'+a.acc_bank+'/'+a.acc_num as khname,a.acc_num from con_account as a where a.wx_id = '" + Session["userid"].ToString() + "'";
            //  string khstr = "select distinct b.cus_name ,a.cus_id from con_cus as a ,customers as b where a.cus_id = b.cus_id and a.wx_id = 'kh13584012107'";
            //  string khzhstr = "select  distinct a.acc_name+'/'+a.acc_num as khname,a.acc_num from con_account as a where a.wx_id = 'kh13584012107'";
            //  string gszhstr = "select b.cus_bank from customers as b where b.cus_id = '"+0210016+"'";//暂时全部显示
            string last_info = "select a.bank_last,b.bank_name,c.cus_name,a.com_bank_last,a.cus_id_last from con_rtcash_lastinfo as a ,con_selBank as b,customers as c where a.cus_id_last = c.cus_id and a.com_bank_last = b.bank_id and a.wx_id = '" + Session["userid"].ToString() + "'";
            DataSet ds0 = SqlUtils.MSSQLHelper.Query(last_info);
            DataSet ds = SqlUtils.MSSQLHelper.Query(khstr);//客户选择
            DataSet ds1 = SqlUtils.MSSQLHelper.Query(khzhstr);//客户账户选择
            string htmlstr = "";
            int tmp1 = ds0.Tables[0].Rows.Count;
            if (ds0.Tables[0].Rows.Count > 0)
            {//存在上次保留的信息
                htmlstr = "<option value='0' style='color:#888'>- 请选择 -</option>";
                switch (tmp)
                {//选择设定：
                    case "select1":
                        if (ds != null)
                        {
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {//如果存在相同的cus_id 则不绑定
                                if (ds0.Tables[0].Rows[0][4].ToString().Trim() != ds.Tables[0].Rows[i][1].ToString().Trim())
                                {
                                    htmlstr = htmlstr + "<option value='" + ds.Tables[0].Rows[i][1].ToString().Replace(" ", "") + "'>" + ds.Tables[0].Rows[i][0].ToString().Replace(" ", "") + "</option>";
                                }

                            }
                        }
                        else
                        {
                            htmlstr = "< option value = '0'>  无数据 </ option > ";
                        }
                        break;
                    case "select2":
                        if (ds1 != null)
                        {

                            for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                            {
                                if (ds0.Tables[0].Rows[0][0].ToString() != ds1.Tables[0].Rows[i][0].ToString().Replace("\n", "").Trim())
                                {
                                    string tm1p = ds0.Tables[0].Rows[0][3].ToString();
                                    htmlstr = htmlstr + "<option value='" + ds1.Tables[0].Rows[i][1].ToString() + "' style='font-size:x-small'>" + ds1.Tables[0].Rows[i][0].ToString().Replace("/n", "").Trim() + "</option>";
                                }
                                else {
                                    string temp = ds1.Tables[0].Rows[i][1].ToString().Replace(" ", "");
                                }
                            }
                        }
                        else
                        {
                            htmlstr = "< option value = '0' style='font-size:x-small' >  无数据 </ option > ";
                        }
                        break;
                    default:

                        break;//select3
                }
            }
            else {//不存在正常绑定
                htmlstr = "<option value='0' style='color:#888'>- 请选择 -</option>";
                switch (tmp)
                {//选择设定：
                    case "select1":
                        if (ds != null)
                        {

                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                htmlstr = htmlstr + "<option value='" + ds.Tables[0].Rows[i][1].ToString() + "'>" + ds.Tables[0].Rows[i][0].ToString().Trim() + "</option>";

                            }
                        }
                        else
                        {
                            htmlstr = "< option value = '0'>  无数据 </ option > ";
                        }
                        break;
                    case "select2":
                        if (ds1 != null)
                        {

                            for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                            {
                                htmlstr = htmlstr + "<option value='" + ds1.Tables[0].Rows[i][1].ToString() + "' style='font-size:x-small'>" + ds1.Tables[0].Rows[i][0].ToString().Trim() + "</option>";

                            }
                        }
                        else
                        {
                            htmlstr = "< option value = '0' style='font-size:x-small' >  无数据 </ option > ";
                        }
                        break;
                    default:

                        break;//select3
                }
            }

            return htmlstr;
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
           // string sqlstring = "select Access_token_time,Access_token from AToken";
           // DataSet tokends = SqlUtils.MSSQLHelper.Query(sqlstring);
            jsapi_ticket at = new jsapi_ticket();
           // if (tokends.Tables[0].Rows.Count > 0)
         //   {
                //string timestamp = GetTimeStamp();
                //if (Convert.ToInt32(tokends.Tables[0].Rows[0][0]) - Convert.ToInt32(timestamp) > 7100)
                //{//更新数据库的token值，理论上不会存在在这个页面呆2个小时的，这里可以不用刷新
                //}
                //else
                //{
                    // string access_token = Get_token();
                    string url = "https://qyapi.weixin.qq.com/cgi-bin/get_jsapi_ticket?access_token=" + Session["token"].ToString();
                    WebClient wc = new WebClient();
                    wc.Credentials = CredentialCache.DefaultCredentials;
                    wc.Encoding = Encoding.UTF8;
                    string returnText = wc.DownloadString(url);
                    at = JsonHelper.ParseFromJson<jsapi_ticket>(returnText);

                
            //    }

          //  }
            //else {//数据库这个字段的值为空，则新增数据。但是在api测试阶段，这个值

            //}
            //if (returnText.Contains("errcode"))
            //{
            //    //可能发生错误
            //}
            return at._ticket;//返回的值里面包含access_token，这个值应该每7200秒获取一次
        }
        protected string Get_token()
        {
            //string url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=wxde814da6ae102dd9&corpsecret=irAgDRT7BBJ-WQ7JCMnh8df9moQcp7Vv1wy6iZfHR8IPhFySoi8qKchqebr4wEdu";
            string url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=wwf427ba730248b6c9&corpsecret=fCx3vNAPMbdeonhKCPUoSN5vQPudNAObRIjIBTnoZXQ";
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