using System;
using System.Data;
using System.Configuration;
using Oracle.ManagedDataAccess.Client;

/// <summary>
/// Oracle Database Helper for KumariCinema Hall
/// Robust connection handling with XEPDB1/XE fallback
/// </summary>
public class DBHelper
{
    private static string _connectionString = ConfigurationManager.ConnectionStrings["OracleConn"].ConnectionString;

    public static OracleConnection GetConnection()
    {
        return new OracleConnection(_connectionString);
    }

    private static void HandleConnection(OracleConnection con)
    {
        try
        {
            con.Open();
        }
        catch (OracleException ex) when (ex.Number == 12514 && _connectionString.Contains("XEPDB1"))
        {
            // Fallback: Try XE if XEPDB1 fails
            _connectionString = _connectionString.Replace("XEPDB1", "XE");
            con.ConnectionString = _connectionString;
            con.Open();
        }
    }

    public static DataTable ExecuteQuery(string sql, OracleParameter[] parameters = null)
    {
        DataTable dt = new DataTable();
        using (OracleConnection con = GetConnection())
        {
            HandleConnection(con);
            using (OracleCommand cmd = new OracleCommand(sql, con))
            {
                cmd.BindByName = true;
                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);
                using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                    da.Fill(dt);
            }
        }
        return dt;
    }

    public static int ExecuteNonQuery(string sql, OracleParameter[] parameters = null)
    {
        using (OracleConnection con = GetConnection())
        {
            HandleConnection(con);
            using (OracleCommand cmd = new OracleCommand(sql, con))
            {
                cmd.BindByName = true;
                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);
                return cmd.ExecuteNonQuery();
            }
        }
    }

    public static object ExecuteScalar(string sql, OracleParameter[] parameters = null)
    {
        using (OracleConnection con = GetConnection())
        {
            HandleConnection(con);
            using (OracleCommand cmd = new OracleCommand(sql, con))
            {
                cmd.BindByName = true;
                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);
                return cmd.ExecuteScalar();
            }
        }
    }

    public static string ExecuteScalarString(string sql, OracleParameter[] parameters = null)
    {
        object res = ExecuteScalar(sql, parameters);
        return res != null ? res.ToString() : "0";
    }
}
