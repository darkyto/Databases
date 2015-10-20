namespace _01.RetrivingDataFromNW
{
    using System;
    using System.Data.SqlClient;
    using System.Data.OleDb;
    using System.Drawing;
    using System.IO;

    /// <summary>
    ///  Write a program that retrieves from the Northwind sample database
    ///  in MS SQL Server the number of rows in the Categories table.
    /// </summary>
    public class Startup
    {
        private const string CONNECTIONSTRING = "Server=.\\SQLEXPRESS; " +
                                             "Database=NORTHWND; Integrated Security=true";

        private const string TASKMESSAGE = "Homewrok task number {0}";

        public static void Main()
        {
            SqlConnection sqlConnection = new SqlConnection(CONNECTIONSTRING);
            sqlConnection.Open();

            using (sqlConnection)
            {
                Console.WriteLine(TASKMESSAGE, 1);
                ProductsByCategories(sqlConnection);

                Console.WriteLine(TASKMESSAGE, 2);
                RetrieveCategoriesInfo(sqlConnection);

                Console.WriteLine(TASKMESSAGE, 3);
                AllProductByCategories(sqlConnection);

                Console.WriteLine(TASKMESSAGE, 4);
                AddProduct(sqlConnection);

                Console.WriteLine(TASKMESSAGE, 5);
                ExtractImageFromDbToFile(sqlConnection);
            }

            sqlConnection.Close();

        }

        public static void ProductsByCategories(SqlConnection sqlConnection)
        {
            SqlCommand cmdCount = new SqlCommand("SELECT COUNT(*) FROM Categories", sqlConnection);
            int categoriesCount = (int)cmdCount.ExecuteScalar();
            Console.WriteLine("Categories count: {0} ", categoriesCount);
            Console.WriteLine();
        }

        public static void RetrieveCategoriesInfo(SqlConnection sqlConnection)
        {
            SqlCommand categoriesInfo = new SqlCommand(
                    "SELECT c.CategoryName, c.Description FROM Categories c", sqlConnection);
            SqlDataReader reader = categoriesInfo.ExecuteReader();
            using (reader)
            {
                while (reader.Read())
                {
                    string categoryName = (string)reader["CategoryName"];
                    string description = (string)reader["Description"];

                    Console.WriteLine("{0} :  {1} ", categoryName, description);
                }
            }

            Console.WriteLine();
        }

        public static void AllProductByCategories(SqlConnection sqlConnection)
        {
            var sqlStringCommand = @"
                    SELECT c.CategoryName, p.ProductName
                    FROM Categories c
                    JOIN Products p
                        ON c.CategoryID = p.CategoryID
                    ORDER BY c.CategoryName DESC, p.ProductName ASC";

            var allProductByCategories = new SqlCommand(sqlStringCommand, sqlConnection);
            var reader = allProductByCategories.ExecuteReader();
            using (reader)
            {
                while (reader.Read())
                {
                    var categoryName = (string)reader["CategoryName"];
                    var productName = (string)reader["ProductName"];
                    Console.WriteLine($"{categoryName} -> {productName}");
                }
            }

            Console.WriteLine();
        }

        public static void AddProduct(SqlConnection sqlConnection)
        {
            SqlCommand command = new SqlCommand(
                    @"INSERT INTO Products 
                    (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
                    VALUES
                    (@name,@supplierId,@categoryId,@quantityPerUnit,@unitPrice,@unitInStock,@unitsOnOrder,@recordLevel,@discontinued)",
                    sqlConnection);

            // var nameValue = Console.ReadLine(); // for real-time console test supply each row with value
            command.Parameters.AddWithValue("@name", "Coca-Cola");
            command.Parameters.AddWithValue("@supplierId", 1);
            command.Parameters.AddWithValue("@categoryId", 1);
            command.Parameters.AddWithValue("@quantityPerUnit", "330ml");
            command.Parameters.AddWithValue("@unitPrice", 1.20);
            command.Parameters.AddWithValue("@unitInStock", 1000);
            command.Parameters.AddWithValue("@unitsOnOrder", 50);
            command.Parameters.AddWithValue("@recordLevel", 12);
            command.Parameters.AddWithValue("@discontinued", 0);

            command.ExecuteNonQuery();
            Console.WriteLine("New product added sucsessfully!");
            Console.WriteLine();
        }

        public static void CreateImageFile(string filePath, byte[] fileContent)
        {
            using (var memoryStream = new MemoryStream(fileContent, 78, fileContent.Length - 78))
            {
                var img = Image.FromStream(memoryStream);

                img.Save(filePath);
            }
        }

        public static void ExtractImageFromDbToFile(SqlConnection sqlConnection)
        {
            var command = new SqlCommand(
                @"SELECT c.Picture 
                  FROM Categories c",
                sqlConnection);
            var reader = command.ExecuteReader();
            var counter = 1;
            while (reader.Read())
            {
                var filePath = string.Format(@"..\..\Pictures\category{0}.jpg", counter);
                var image = (byte[])reader["Picture"];
                CreateImageFile(filePath, image);
                counter++;
            }

            Console.WriteLine("Images succsessfully extracted to files!");
            Console.WriteLine();
        }

    }
}
