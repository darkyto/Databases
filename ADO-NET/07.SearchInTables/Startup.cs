namespace _07.SearchInTables
{
    using System;
    using System.Data.SqlClient;

    internal class Program
    {
        private const string CONNECTIONSTRING = "Server=.\\SQLEXPRESS; " +
                                                "Database=NORTHWND; Integrated Security=true";
        private static void Main()
        {
            Console.Write("ENTER SEARCH TERM: ");
            var searchTerm = Console.ReadLine();

            FindProduct(searchTerm);
        }

        private static void FindProduct(string searchTerm)
        {
            var dbConnection = new SqlConnection(CONNECTIONSTRING);
            using (dbConnection)
            {
                dbConnection.Open();
                var cmd = SqlSearchByPattern(dbConnection, searchTerm);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var productName = reader["ProductName"];
                        Console.WriteLine("Found:  " + productName);
                    }
                }
                dbConnection.Close();
            }
        }

        private static SqlCommand SqlSearchByPattern(SqlConnection sqlConnection, string pattern)
        {
            var cmd = new SqlCommand(@"SELECT ProductName
                                                     FROM Products
                                                     WHERE CHARINDEX(@pattern, ProductName) > 0", sqlConnection);
            cmd.Parameters.AddWithValue("@pattern", pattern);
            return cmd;
        }
    }
}
