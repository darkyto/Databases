namespace FindAllCustomers1987CanadaNativeSql
{
    using System;
    using EntityFramework.Data;

    public class Startup
    {
        private static void Main()
        {
            Console.WriteLine("\nList of employees from London:");
            SelectEmployeeNamesByCountryAndCity("Canada", 1997);
        }

        private static void SelectEmployeeNamesByCountryAndCity( string country, int year)
        {
            NORTHWNDEntities northwindEntities = new NORTHWNDEntities();
            string nativeSqlQuery =
                "SELECT CONCAT(c.ContactName , ' | ' , o.OrderDate , ' | ' , o.ShipCountry) AS [Customer]" +
                "FROM Customers c " +
                "JOIN Orders o " +
                "ON c.CustomerID = o.CustomerID " +
                "WHERE YEAR(o.OrderDate) = {1} AND o.ShipCountry = {0} " +
                "ORDER BY c.ContactName DESC";
            object[] parameters = { country, year };
            var customers = northwindEntities.Database.SqlQuery<string>(
                nativeSqlQuery, parameters);
            foreach (var emp in customers)
            {
                Console.WriteLine(emp);
            }
        }
    }
}
