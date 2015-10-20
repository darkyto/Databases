namespace FindAllCustomers1987Canada
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using CreatingDbContextNorthwind;

    public class Startup
    {
        private static NORTHWNDEntities db;

        public static void Main()
        {
            using (db = new NORTHWNDEntities())
            {
                var customers = db.Customers
                    .Join(db.Orders,
                        (c => c.CustomerID),
                        (o => o.CustomerID),
                        (c, o) => new
                        {
                            CustomerName = c.ContactName,
                            OrderYear = o.OrderDate.Value.Year,
                            o.ShipCountry
                        })
                    .ToList()
                    .FindAll(c => c.ShipCountry == "Canada" && c.OrderYear == 1997)
                    .ToList()
                    .OrderBy(c => c.CustomerName);

                foreach (var c in customers)
                {
                    Console.WriteLine(c.CustomerName + " : " + c.OrderYear + " : " + c.ShipCountry);
                }
            }
        }
    }
}
