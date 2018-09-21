﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;
using System.Web;

namespace wx.Utils
{
    public class FileLogger
    {
        #region 字段
        public static object _lock = new object();
        #endregion

        #region 写文件
        /// <summary>
        /// 写文件
        /// </summary>
        public static void WriteFile(string log, string path)
        {
            Thread thread = new Thread(new ParameterizedThreadStart(delegate (object obj)
            {
                lock (_lock)
                {
                    if (!File.Exists(path))
                    {
                        using (FileStream fs = new FileStream(path, FileMode.Create)) { }
                    }

                    using (FileStream fs = new FileStream(path, FileMode.Append, FileAccess.Write))
                    {
                        using (StreamWriter sw = new StreamWriter(fs))
                        {
                            #region 日志内容
                            string value = string.Format(@"{0} {1}", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), obj.ToString());
                            #endregion

                            sw.WriteLine(value);
                            sw.Flush();
                        }
                    }
                }
            }));
            thread.Start(log);
        }
        #endregion

        #region 写日志
        /// <summary>
        /// 写日志
        /// </summary>
        public static void WriteLog(HttpContext context, string log)
        {
            string logPath = context.Request.MapPath("\\SWX_Log.txt");
            WriteFile(log, logPath);
        }
        #endregion

        #region 写错误日志
        /// <summary>
        /// 写错误日志
        /// </summary>
        public static void WriteErrorLog(HttpContext context, string log)
        {
            string logPath = context.Request.MapPath("\\SWX_ErrorLog.txt");
            WriteFile(log, logPath);
        }
        #endregion
        public static void WriteErrorLog( string log)
        {
            WriteFile(log, "D:\\wxvivo_nj\\\\SWX_ErrorLog.txt");
        }
    }
}