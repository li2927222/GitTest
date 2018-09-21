using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace wx.API
{
    /// <summary>
    /// GetUserBank 的摘要说明
    /// </summary>
    public class GetUserBank : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            //
            string cus_id = context.Request.Params["optionId"].ToString();//可能为零,不会为空
            if (cus_id == "0") {
              
            } else {
                string bankstr = "select b.cus_bank from customers as b where b.cus_id ='" + cus_id + "'and b.cus_bank is not null";
                string allbank = "select distinct a.cBCode, a.cBName from bank  as a ";
                string[] test = { "aa", bankstr };
                DataSet ds = SqlUtils.MSSQLHelper.Query(bankstr);//客户能看到的银行
                DataSet ds1 = SqlUtils.MSSQLHelper.Query(allbank);//客户能看到的银行
              
               
                if (ds.Tables[0].Rows.Count>0)
                {
                    string tmp = ds.Tables[0].Rows[0][0].ToString().Trim()+"|";
                    string[] bankid = tmp.Split('|');//split成数组
                    string bankname = "";
                    //  List<string> ktls = bankname.ToList();
                    for (int i = 0; i < bankid.Length; i++)
                    {
                        for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                        {
                            if (ds1.Tables[0].Rows[j][0].ToString() == bankid[i])
                            {
                                bankname = bankname + ds1.Tables[0].Rows[j][1].ToString() + "|";
                            }
                        }
                    }
                    //    bankname = ktls.ToArray();
                    tmp = tmp + "," + bankname;
                    //string resultString = "[";
                    //for (int i = 0; i < bankstr1.Length; i++)
                    //{
                    //    resultString += "'" + bankstr1[i].ToString() + "',";
                    //}
                    //resultString = resultString.TrimEnd(',') + "]";
                    context.Response.Write(tmp);
                }
                else
                { context.Response.Write(0); }//前台接受到0则表示无数据，则绑定请选择或者提示该账户没有对应公司账户
            }
           
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