namespace _06_08.ExcelManipulatiing
{
    using System;
    using System.Collections.Generic;
    using System.Data.OleDb;
    using System.Text;

    public class Startup
    {
        public static void Main()
        {
            WriteDataToExcelFile();
        }

        private static void WriteDataToExcelFile(int numberOfRecordsToInsert = 10)
        {
            var connectionString = GetConnectionString();
            using (var oleDbConnection = new OleDbConnection(connectionString))
            {
                oleDbConnection.Open();
                var sheetName = GetSheetName(oleDbConnection);
                var cmd = GetCommand(oleDbConnection, sheetName);

                for (var i = 0; i < numberOfRecordsToInsert; i++)
                {
                    var queryResult = cmd.ExecuteNonQuery();
                    Console.WriteLine("({0} row(s) affected)", queryResult);
                }
            }
        }

        private static string GetConnectionString()
        {

            var props = new Dictionary<string, string>();
            props["Provider"] = "Microsoft.Jet.OLEDB.4.0";
            props["Extended Properties"] = "Excel 8.0";
            props["Data Source"] = "../../trainers.xls";

            var sb = new StringBuilder();
            foreach (var prop in props)
            {
                sb.Append(prop.Key);
                sb.Append('=');
                sb.Append(prop.Value);
                sb.Append(';');
            }

            return sb.ToString();
        }

        private static string GetSheetName(OleDbConnection oleDbConnection)
        {
            var excelSchema = oleDbConnection.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            var dataTable = excelSchema.Rows[0]["TABLE_NAME"].ToString();
            return dataTable;
        }

        private static OleDbCommand GetCommand(OleDbConnection oleDbConnection, string sheetName)
        {
            const string name = "John Doe";
            const int score = 25;

            var cmd =
                new OleDbCommand("INSERT INTO [" + sheetName + "] VALUES (@name, @score)", oleDbConnection);

            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@score", score);

            return cmd;
        }
    }
}