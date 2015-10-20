using EntityFramework.Data;

namespace FindSaleByRegionAndPeriod
{
    using System;
    using System.Linq;
    using EntityFramework.Data;

    public class Startup
    {
        private const string region = "RJ";

        public static void Main(string[] args)
        {
            var startDate = new DateTime(1995, 01, 01);
            var endDate = new DateTime(1997, 01, 01);

            using (var db = new NORTHWNDEntities())
            {
                var sales = db.Orders
                    .Where(o => o.ShipRegion == region &&
                                o.OrderDate > startDate &&
                                o.OrderDate < endDate)
                    .ToList();

                foreach (var sale in sales)
                {
                    Console.WriteLine("Order ID: " + sale.OrderID);
                    Console.WriteLine(sale.OrderDate);
                }
            }
        }
    }
}
