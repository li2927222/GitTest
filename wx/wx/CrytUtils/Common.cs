using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;

namespace wx.CrytUtils
{
    public class Common
    {
        public static string ObjectToJson<T>(Object jsonObject, Encoding encoding)
        {
            string result = String.Empty;
            DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(T));
            using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
            {
                serializer.WriteObject(ms, jsonObject);
                result = encoding.GetString(ms.ToArray());
            }
            return result;
        }
    }
}