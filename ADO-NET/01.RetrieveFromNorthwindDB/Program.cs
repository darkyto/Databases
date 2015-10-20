namespace _01.RetrieveFromNorthwindDB
{
    using System;
    using System.Configuration;
    using System.Data.SqlClient;

    public class Program
    {
        private static SqlConnection dbConnection;

        public static void Main()
        {
            var dbConnectionString = ConfigurationManager.ConnectionStrings["SQLDB"];
            dbConnection = new SqlConnection(dbConnectionString.ConnectionString);
            dbConnection.Open();

            using (dbConnection)
            {
                var cmd = new SqlCommand(GlobalConstants.SQLCommand, dbConnection);
                var categoriesCount = (int)cmd.ExecuteScalar();
                Console.WriteLine(GlobalConstants.CategoriesCount, categoriesCount);
                Console.WriteLine();
            }
        }
    }

    internal class GlobalConstants
    {
    }
}
