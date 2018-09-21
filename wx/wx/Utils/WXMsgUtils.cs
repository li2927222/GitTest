using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Xml;

namespace wx.Utils
{
    public class WXMsgUtils
    {
        //企业的回复支持文本、图片、语音、视频、图文等格式。文档提供格式参照
        //这里只有图文和文本，看需求拓展
        public static string CreateTextMsg(XmlDocument xmlDoc, string content)
        {
            string strTpl = string.Format(@"<xml>
                <ToUserName><![CDATA[{0}]]></ToUserName>
                <FromUserName><![CDATA[{1}]]></FromUserName>
                <CreateTime>{2}</CreateTime>
                <MsgType><![CDATA[text]]></MsgType>
                <Content><![CDATA[{3}]]></Content>
                </xml>", GetFromXML(xmlDoc, "FromUserName"), GetFromXML(xmlDoc, "ToUserName"),
                       DateTime2Int(DateTime.Now), content);

            return strTpl;
        }
        public static string CreateNewsMsg(XmlDocument xmlDoc, List<Dictionary<string, string>> dictList)
        {
            StringBuilder sbItems = new StringBuilder();
            foreach (Dictionary<string, string> dict in dictList)
            {
                sbItems.Append(string.Format(@"
                    <item>
                        <Title><![CDATA[{0}]]></Title> 
                        <Description><![CDATA[{1}]]></Description>
                        <PicUrl><![CDATA[{2}]]></PicUrl>
                        <Url><![CDATA[{3}]]></Url>
                    </item>", dict["Title"], dict["Description"], dict["PicUrl"], dict["Url"]));
            }

            string strTpl = string.Format(@"
                <xml>
                    <ToUserName><![CDATA[{0}]]></ToUserName>
                    <FromUserName><![CDATA[{1}]]></FromUserName>
                    <CreateTime>{2}</CreateTime>
                    <MsgType><![CDATA[news]]></MsgType>
                    <ArticleCount>{3}</ArticleCount>
                    <Articles>
                        {4}
                    </Articles>
                </xml> ", GetFromXML(xmlDoc, "FromUserName"), GetFromXML(xmlDoc, "ToUserName"),
                        DateTime2Int(DateTime.Now), dictList.Count, sbItems.ToString());

            return strTpl;
        }
        public static string GetFromXML(XmlDocument xmlDoc, string name)
        {
            XmlNode node = xmlDoc.SelectSingleNode("xml/" + name);
            if (node != null && node.ChildNodes.Count > 0)
            {
                return node.ChildNodes[0].Value;
            }
            return "";
        }
        #region 时间转换成int
        /// <summary>
        /// 时间转换成int
        /// </summary>
        public static int DateTime2Int(DateTime dt)
        {
            DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1));
            return (int)(dt - startTime).TotalSeconds;
        }
        #endregion



    }
}