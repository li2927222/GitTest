using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Xml;
using Tencent;
using wx.SqlUtils;
using wx.Utils;

namespace wx
{
    /// <summary>
    /// InterFace 的摘要说明
    /// </summary>
    public class InterFace : IHttpHandler
    {

        #region//常量赋值
      //  string sToken = "weixin";
       string sToken = "weixin";
        string sCorpID = "wwf427ba730248b6c9";
      string sEncodingAESKey = "UpZaCZ2guHLNWS6qvSlUoD2I80Ds2FRyV8csHuPXclW";
        #endregion//变量
        public void ProcessRequest(HttpContext context)
        {//获取微信返回的字符串
            #region
            //context.Response.ContentType = "text/plain";
            //string token = "WEIXIN";
            //if (string.IsNullOrEmpty(token))
            //{
            //    return;
            //}
            //string echoString = HttpContext.Current.Request.QueryString["echoStr"];
            ////urldecode处理
            ////如果是页面解码，其实Request.QueryString()会自动做解码的动作。无需再写一遍URLDeCode。
            //string signature = HttpContext.Current.Request.QueryString["signature"];
            //string timestamp = HttpContext.Current.Request.QueryString["timestamp"];
            //string nonce = HttpContext.Current.Request.QueryString["nonce"];
            //if (!string.IsNullOrEmpty(echoString))
            //{
            //    HttpContext.Current.Response.Write(echoString);
            //    HttpContext.Current.Response.End();
            //}
            //context.Response.Write("Hello World");
            #endregion;
            try
            {//回调模式
                Stream stream = context.Request.InputStream;
                byte[] byteArray = new byte[stream.Length];
                stream.Read(byteArray, 0, (int)(stream.Length));//将字符流读入bytearray里
                string postXmlStr = System.Text.Encoding.UTF8.GetString(byteArray);//转成utf8格式的数据
                if (!string.IsNullOrWhiteSpace(postXmlStr))
                {
                    XmlDocument doc = new XmlDocument();
                    doc.LoadXml(postXmlStr);
                    if (!string.IsNullOrWhiteSpace(sCorpID))  //没有AppID则不解密(订阅号没有AppID)
                    {
                        //解密
                        WXBizMsgCrypt wxcpt = new WXBizMsgCrypt(sToken, sEncodingAESKey, sCorpID);
                        string signature = context.Request["msg_signature"];
                        string timestamp = context.Request["timestamp"];
                        string nonce = context.Request["nonce"];
                        string stmp = "";
                        int ret = wxcpt.DecryptMsg(signature, timestamp, nonce, postXmlStr, ref stmp);
                        if (ret == 0)
                        {
                            doc = new XmlDocument();
                            doc.LoadXml(stmp);

                            try
                            {
                                responseMsg(context, doc);
                            }
                            catch (Exception ex)
                            {
                                FileLogger.WriteErrorLog(context, ex.Message);
                            }
                        }
                        else
                        {
                            FileLogger.WriteErrorLog(context, "解密失败，错误码：" + ret);
                        }
                    }
                    else
                    {
                        responseMsg(context, doc);
                    }
                }
                else {
                    valid(context);
                }
                //var echostr = context.Request["echoStr"].ToString();
                //if (!string.IsNullOrEmpty(echostr))
                //{
                //    context.Response.Write(echostr);
                //    context.Response.Flush();//推送echostr,通过验证
                //}
                //  valid(context);
            }
            catch (Exception ex)
            {//错误日志处理
                ex.ToString();
            }
            finally
            {

            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        public void valid(HttpContext context)
        {

            string sVerifyMsgSig = context.Request.QueryString["msg_signature"];//企业号的 msg_signature
            string sVerifyTimeStamp = context.Request.QueryString["timestamp"];
            string sVerifyNonce = context.Request.QueryString["nonce"];
            string sVerifyEchoStr = context.Request.QueryString["echoStr"];
            int ret = 0;
           // int ret1 = 0;
            string sEchoStr = "";
          //  string sEchoStr1 = "";
            WXBizMsgCrypt wxcpt = new WXBizMsgCrypt(sToken, sEncodingAESKey, sCorpID);
           // WXBizMsgCrypt wxcpt1 = new WXBizMsgCrypt(sToken1, sEncodingAESKey1, sCorpID1);
            ret = wxcpt.VerifyURL(sVerifyMsgSig, sVerifyTimeStamp, sVerifyNonce, sVerifyEchoStr, ref sEchoStr);
                if (ret != 0)
                {
                    context.Response.Write("ERR: VerifyURL fail, ret: " + ret);
                    return;
                }


                if (!string.IsNullOrEmpty(sEchoStr))
                {
                    context.Response.Write(sEchoStr);
                    context.Response.Flush();//推送echostr,通过验证}
                }           
        }
        public bool checkSignature(HttpContext context)
        {//企业通过参数msg_signature对请求进行校验，如果确认此次GET请求来自企业号（文档）
            var signature = context.Request["signature"].ToString();
            var timestamp = context.Request["timestamp"].ToString();
            var nonce = context.Request["nonce"].ToString();
            var token = "winxin";
            //加密验证参数生成加密后的
            string[] ArrTmp = { token, timestamp, nonce };
            Array.Sort(ArrTmp);     //字典排序
            string tmpStr = string.Join("", ArrTmp);
            //  tmpStr = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(tmpStr, "SHA1");
            tmpStr = GetSwcSH1(tmpStr);
            tmpStr = tmpStr.ToLower();
            if (tmpStr == signature)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        public static string GetSwcSH1(string value)//不是aes算法么，sha1算法是网上搜的
        {//x2这个偶也不懂~~百度的
            SHA1 algorithm = SHA1.Create();
            byte[] data = algorithm.ComputeHash(Encoding.UTF8.GetBytes(value));
            string sh1 = "";
            for (int i = 0; i < data.Length; i++)
            {
                sh1 += data[i].ToString("x2").ToUpperInvariant();
            }
            return sh1;
        }
        public void responseMsg(HttpContext context, XmlDocument xmlDoc)
        {//企业响应的消息同样应该经过加密，并带上msg_signature、timestamp、nonce及密文，其中timestamp、nonce由企业指定，msg_signature、密文经特定算法生成，
            //企业收到普通消息、成员关注事件、菜单click事件、成员进入应用事件后，可以被动响应消息。
            string result = "";
            string msgType = WXMsgUtils.GetFromXML(xmlDoc, "MsgType"); //获取消息类型
            switch (msgType)
            {
                case "event":
                    switch (WXMsgUtils.GetFromXML(xmlDoc, "Event"))
                    {
                        case "subscribe": //订阅
                            break;
                        case "unsubscribe": //取消订阅
                            break;
                        case "CLICK"://点击事件
                           // DataTable dtMenuMsg = DAL.MenuMsgDal.GetMenuMsg(WXMsgUtils.GetFromXML(xmlDoc, "EventKey"));

                         //   if (dtMenuMsg.Rows.Count > 0 && dtMenuMsg.Rows[0][0].ToString() == "test1key")
                          //  {
                                //List<Dictionary<string, string>> dictList = new List<Dictionary<string, string>>();
                                //foreach (DataRow dr in dtMenuMsg.Rows)
                                //{
                                //    Dictionary<string, string> dict = new Dictionary<string, string>();
                                //    dict["Title"] = dr["Title"].ToString();
                                //    dict["Description"] = dr["Description"].ToString();
                                //    dict["PicUrl"] = dr["PicUrl"].ToString();
                                //    dict["Url"] = dr["Url"].ToString();
                                //    dictList.Add(dict);
                                //}
                                //按格式返回数据
                                // string tmp = "test";
                                //result = WXMsgUtils.CreateNewsMsg(xmlDoc, tmp);
                          //  }
                         //   else
                          //  {
                              result = WXMsgUtils.CreateTextMsg(xmlDoc, "无此消息哦");
                           // }
                            break;
                        case "enter_agent":
                            string touser = WXMsgUtils.GetFromXML(xmlDoc, "ToUserName");
                            string fromuser = WXMsgUtils.GetFromXML(xmlDoc, "FromUserName");
                            string createtime = WXMsgUtils.GetFromXML(xmlDoc, "CreateTime");
                            createtime = GetTime(createtime).ToString();
                            string msgtype = WXMsgUtils.GetFromXML(xmlDoc, "MsgType");
                            string agenid = WXMsgUtils.GetFromXML(xmlDoc, "AgentID");
                            string str = "select * from wx_userload where FromUser ='" + fromuser + "' and AgentID ='" + agenid + "'";
                            DataSet ds1 = SqlUtils.MSSQLHelper.Query(str);
                            if (agenid == "2")
                            {//记录登录信息
                              
                                if (ds1.Tables[0].Rows.Count == 0)
                                {
                                    List<Dictionary<string, string>> dictList = new List<Dictionary<string, string>>();
                                    Dictionary<string, string> dict = new Dictionary<string, string>();
                                    dict["Title"] = "使用说明";
                                    dict["Description"] = "使用说明";
                                    dict["PicUrl"] = "http://sdjnvivo.passingsd.top/image/使用说明.jpg";
                                    dict["Url"] = "http://sdjnvivo.passingsd.top/web/Readme.aspx";
                                    dictList.Add(dict);
                                    result = WXMsgUtils.CreateNewsMsg(xmlDoc, dictList);
                                };
                                string sqlstr = "insert into wx_userload(ToUser,FromUser,CreateTime,MsgType,AgentID)values('" + touser + "','" + fromuser + "','" + createtime + "','" + msgtype + "','" + agenid + "')";
                                SqlUtils.MSSQLHelper.ExecuteSql(sqlstr);
                                FileLogger.WriteErrorLog(result+ fromuser+ ds1.Tables[0].Rows.Count);
                            }                    
                            else {
                                string sqlstr = "insert into wx_userload(ToUser,FromUser,CreateTime,MsgType,AgentID)values('" + touser + "','" + fromuser + "','" + createtime + "','" + msgtype + "','" + agenid + "')";
                                SqlUtils.MSSQLHelper.ExecuteSql(sqlstr);
                            }
                            //如果数据库只有一条该人员登录记录则发送news

                            break;
                        default:
                            break;
                    }
                    break;
                case "text":
                    string text = WXMsgUtils.GetFromXML(xmlDoc, "Content");
                    string temp;
                    string querystr = "select user_name from psdb.dbo.users where user_id = '001'";
                    DataSet ds = MSSQLHelper.Query(querystr);
                    if (text.ToString() == "name")//判断获取的消息文本，执行不同方法返回不同结果
                    {
                        //result = WXMsgUtils.CreateTextMsg(xmlDoc );
                        temp = ds.Tables[0].Rows[0][0].ToString();
                        result = WXMsgUtils.CreateTextMsg(xmlDoc, temp);
                    }
                    else
                    {
                        //  result = WXMsgUtils.CreateTextMsg(xmlDoc);
                        temp = "暂无功能";
                        result = WXMsgUtils.CreateTextMsg(xmlDoc, temp);
                    }
                    break;
                default:
                    break;
            }
            //推送出去消息
            if (!string.IsNullOrWhiteSpace(sCorpID)) //没有AppID则不加密(订阅号没有AppID)
            {
                //加密
                WXBizMsgCrypt wxcpt = new WXBizMsgCrypt(sToken, sEncodingAESKey, sCorpID);
                string sEncryptMsg = result; //xml格式的密文
                string timestamp = context.Request["timestamp"];
                string nonce = context.Request["nonce"];
                int ret = wxcpt.EncryptMsg(result, timestamp, nonce, ref sEncryptMsg);//按要求加密数据
                if (ret != 0)
                {
                   FileLogger.WriteErrorLog(context, "加密失败，错误码：" + ret);
                    return;
                }

                context.Response.Write(sEncryptMsg);
                context.Response.Flush();
            }
            else
            {
                context.Response.Write(result);
                context.Response.Flush();
            }
        }
        private DateTime GetTime(string timeStamp)
        {
            DateTime dtStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
            long lTime = long.Parse(timeStamp + "0000000");
            TimeSpan toNow = new TimeSpan(lTime); return dtStart.Add(toNow);
        }
    }
}