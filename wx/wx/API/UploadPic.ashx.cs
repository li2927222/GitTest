using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.AccessControl;
using System.Web;
using System.Web.SessionState;
namespace wx.API
{
    /// <summary>
    /// UploadPic 的摘要说明
    /// </summary>
    public class UploadPic : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {//存储图片并把url存储到对应的人，图片的名字由客户名称和随机码以及时间组成
         //Random ran = new Random();
         //int RandKey = ran.Next(1000, 9999);//
         //                                   // string khstr = context.Session["userid"].ToString();
         //时间相同批号标记相同则是同一个客户同一次的回款和图片
           string khstr = context.Session["userid"].ToString();
           // string khstr = "fly_jaysue";
           // string date = System.DateTime.Today.ToString("yyyyMMdd");
            string rand = context.Request["rand"].ToString();
            string numid = context.Request["i"].ToString();
            //string Pic_Path = HttpContext.Current.Server.MapPath("MyPicture.jpg");
          //  string path = "D:/wxvivo/image/"+ khstr+"_"+ rand +"_"+ numid + ".jpg";//前八个数表示是同一批次的
            string imageData = context.Request["imageData"].ToString();//接受png格式的图片数据字符串流
            FileInfo fi = new FileInfo("D:/image");
            System.Security.AccessControl.FileSecurity fileSecurity = fi.GetAccessControl();
            fileSecurity.AddAccessRule(new FileSystemAccessRule("Everyone", FileSystemRights.FullControl, AccessControlType.Allow));
            fileSecurity.AddAccessRule(new FileSystemAccessRule("Users", FileSystemRights.FullControl, AccessControlType.Allow));
            fi.SetAccessControl(fileSecurity);
            string path = "D:/image/" + khstr + "_" + rand + "_" + numid + ".jpg";//前八个数表示是同一批次的
            using (FileStream fs = new FileStream(path, FileMode.OpenOrCreate, FileAccess.ReadWrite))//create
            {
                using (BinaryWriter bw = new BinaryWriter(fs))
                {
                    byte[] data = Convert.FromBase64String(imageData);
                    bw.Write(data);
                    bw.Close();
                }
               // fs.Flush();//清空缓冲区
            }
            context.Response.Write(path);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}