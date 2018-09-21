using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace wx.SqlUtils
{
    public class MSSQLHelper
    {
        #region 变量
        /// <summary>
        /// 数据库连接字符串 
        /// </summary>
        public static string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        // public static string connectionString1 = ConfigurationManager.ConnectionStrings["PSDBConnectionOPPO"].ToString();
        public static string connectionString1 = ConfigurationManager.ConnectionStrings["017Connection"].ToString();

        #endregion
        #region 执行查询语句，返回DataSet
        /// <summary>
        /// 执行查询语句，返回DataSet
        /// </summary>
        /// <param name="SQLString">查询语句</param>
        /// <returns>DataSet</returns>
        public static DataSet Query(string SQLString)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                    command.Fill(ds, "ds");
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                finally
                {
                    connection.Close();
                    connection.Dispose();
                }
                return ds;
            }
        }
        public static DataSet Query1(string SQLString)
        {
            using (SqlConnection connection = new SqlConnection(connectionString1))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                    command.Fill(ds, "ds");
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                finally
                {
                    connection.Close();
                    connection.Dispose();

                }
                return ds;
            }
        }
        #endregion
        #region//返回受影响的行数
        public static int ExecuteSql(string SQLString)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            using (SqlCommand cmd = new SqlCommand(SQLString, connection))//初始化cmd
            {
                try
                {
                    // if (TranFlag) cmd.Transaction = GetTran();
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException E)
                {
                    connection.Close();
                    throw new Exception(E.Message);
                }
                finally
                {
                    cmd.Dispose();
                    connection.Dispose();
                    // if (!TranFlag) connection.Close();
                }
            }
        }
        #region
        //执行sql回滚

        #endregion
        #endregion
        #region//返回存储过程数据集合
        public static DataTable PrecedureDs(string str, params SqlParameter[] cmdParms)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(str, connection);
            for (int i = 0; i < cmdParms.Length; i++) { cmd.Parameters.Add(cmdParms[i]); };
            cmd.Parameters.Add("@ret", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                connection.Open();
                SqlDataReader myReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();
                DataTable mydt = new DataTable();  /*存放要在Gridview里面显示的最后结果*/
                mydt.Load(myReader);
                myReader.Close();/*就这一句用DataTable.Load(DataReader)来把查询到的数据插入到DataTable中*/
                return mydt;
            }
            catch (System.Data.SqlClient.SqlException e)
            {
                connection.Close();
                throw new Exception(e.Message);

            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
                // if (!TranFlag) connection.Close();
            }
        }
        public static DataTable PrecedureDs1(string str, params SqlParameter[] cmdParms)
        {
            SqlConnection connection = new SqlConnection(connectionString1);
            SqlCommand cmd = new SqlCommand(str, connection);
            for (int i = 0; i < cmdParms.Length; i++) { cmd.Parameters.Add(cmdParms[i]); };
          //  cmd.Parameters.Add("@ret", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                connection.Open();
                SqlDataReader myReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();
                DataTable mydt = new DataTable();  /*存放要在Gridview里面显示的最后结果*/
                mydt.Load(myReader);
                myReader.Close();
                return mydt;
            }
            catch (System.Data.SqlClient.SqlException e)
            {
                connection.Close();
                throw new Exception(e.Message);

            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
                // if (!TranFlag) connection.Close();
            }
        }
        public static string PrecedureRet(string str, params SqlParameter[] cmdParms)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(str, connection);
            for (int i = 0; i < cmdParms.Length; i++) { cmd.Parameters.Add(cmdParms[i]); };
            cmd.Parameters.Add("@ret", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                connection.Open();
                //  cmd.Parameters["@ret"].Direction = ParameterDirection.ReturnValue;
                cmd.ExecuteNonQuery();
                return cmd.Parameters["@ret"].Value.ToString();
            }
            catch (System.Data.SqlClient.SqlException e)
            {
                connection.Close();
                throw new Exception(e.Message);

            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                // if (!TranFlag) connection.Close();
            }
        }
        #region
        //返回错误标记
        //public static DataTable ConvertDataReaderToDataTable(SqlDataReader dataReader)
        //{
        //    ///定义DataTable  
        //    DataTable datatable = new DataTable();

        //    try
        //    {    ///动态添加表的数据列  
        //        for (int i = 0; i < dataReader.FieldCount; i++)
        //        {
        //            DataColumn myDataColumn = new DataColumn();
        //            myDataColumn.DataType = dataReader.GetFieldType(i);
        //            myDataColumn.ColumnName = dataReader.GetName(i);
        //            datatable.Columns.Add(myDataColumn);
        //        }

        //        ///添加表的数据  
        //        while (dataReader.Read())
        //        {
        //            DataRow myDataRow = datatable.NewRow();
        //            for (int i = 0; i < dataReader.FieldCount; i++)
        //            {
        //                if (dataReader[i] != null)
        //                { myDataRow[i] = dataReader[i].ToString(); }
        //             //   else { myDataRow[i] = ""; }

        //            }
        //            datatable.Rows.Add(myDataRow);
        //            myDataRow = null;
        //        }
        //        ///关闭数据读取器  
        //        dataReader.Close();
        //        return datatable;
        //    }
        //    catch (Exception ex)
        //    {
        //        ///抛出类型转换错误  
        //        //SystemError.CreateErrorLog(ex.Message);  
        //        throw new Exception(ex.Message, ex);
        //    }
        //}
        public static string Errormark(string str, params SqlParameter[] cmdParms)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(str, connection);
            string erromark;
            for (int i = 0; i < cmdParms.Length; i++) { cmd.Parameters.Add(cmdParms[i]); };
            cmd.Parameters.Add("@ret", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                connection.Open();
                cmd.ExecuteNonQuery();
                erromark = cmd.Parameters["@ret"].Value.ToString();
                return erromark;
            }
            catch (System.Data.SqlClient.SqlException e)
            {
                connection.Close();
                throw new Exception(e.Message);

            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                // if (!TranFlag) connection.Close();
            }
        }
        #endregion
        #endregion
        #region
        //返回sqldatareaderj数据集合
        //public static SqlDataReader ExecuteReader(string SQLString, params SqlParameter[] cmdParms)
        //{
        //    SqlConnection connection = new SqlConnection(connectionString);
        //    SqlCommand cmd = new SqlCommand();
        //    try
        //    {
        //        PrepareCommand(cmd, connection, null, SQLString, cmdParms);
        //        SqlDataReader myReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        //        cmd.Parameters.Clear();
        //        return myReader;
        //        //..............
        //    }
        //    catch (System.Data.SqlClient.SqlException e)
        //    {
        //        throw new Exception(e.Message);

        //    }
        //    finally
        //    {
        //        cmd.Dispose();
        //        connection.Close();
        //        connection.Dispose();
        //    }

        //}
        #endregion
        #region 执行查询语句，返回DataSet
        /// <summary>
        /// 执行查询语句，返回DataSet
        /// </summary>
        /// <param name="SQLString">查询语句</param>
        /// <returns>DataSet</returns>
        public static DataSet Query(string SQLString, params SqlParameter[] cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand();
                PrepareCommand(cmd, connection, null, SQLString, cmdParms);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataSet ds = new DataSet();
                    try
                    {
                        da.Fill(ds, "ds");
                        cmd.Parameters.Clear();
                    }
                    catch (System.Data.SqlClient.SqlException ex)
                    {
                        throw new Exception(ex.Message);
                    }
                    finally
                    {
                        cmd.Dispose();
                        connection.Dispose();
                    }
                    return ds;
                }
            }
        }
        #endregion

        #region PrepareCommand sqkcommand 拼接语句
        private static void PrepareCommand(SqlCommand cmd, SqlConnection conn, SqlTransaction trans, string cmdText, SqlParameter[] cmdParms)
        {
            if (conn.State != ConnectionState.Open)
                conn.Open();
            cmd.Connection = conn;
            cmd.CommandText = cmdText;
            if (trans != null)
                cmd.Transaction = trans;
            cmd.CommandType = CommandType.Text;//cmdType;
            if (cmdParms != null)
            {
                foreach (SqlParameter parm in cmdParms)
                    cmd.Parameters.Add(parm);
            }
            cmd.Dispose();
           
        }
        #endregion
        #region 结束事务(正常结束)
        /// <summary>
        /// 结束事务(正常结束)
        /// </summary>
        //public static void EndTransaction()
        //{
        //    try
        //    {
        //        GetTran().Commit();
        //        RemoveTranFlag();
        //    }
        //    catch (Exception ex)
        //    {
        //        GetTran().Rollback();
        //        RemoveTranFlag();
        //    }
        //    finally
        //    {
        //        GetOpenConnection().Close();
        //    }
        //}
        //#endregion

        //#region 回滚事务(出错时调用该方法回滚)
        ///// <summary>
        ///// 回滚事务(出错时调用该方法回滚)
        ///// </summary>
        //public static void RollbackTransaction()
        //{
        //    GetTran().Rollback();
        //    RemoveTranFlag();
        //    GetOpenConnection().Close();
        //}
        //#endregion
        //#region 事务对象
        ///// <summary>
        ///// 获取事务对象
        ///// </summary>
        //public static SqlTransaction GetTran()
        //{
        //    SqlTransaction tran = null;

        //    string key = "Simpo_FQD_OracleTransaction";

        //    if (HttpContext.Current.Items[key] == null)
        //    {
        //        tran = GetOpenConnection().BeginTransaction();
        //        HttpContext.Current.Items[key] = tran;
        //    }
        //    else
        //    {
        //        tran = (SqlTransaction)HttpContext.Current.Items[key];
        //    }

        //    return tran;
        //}
        //#endregion
        #endregion
    }
}