namespace CreatingDbContextNorthwind
{
    using System;
    using System.Linq;

    public class Startup
    {
        public static void Main()
        {
            using (var ctx = new NORTHWNDEntities())
            {
                foreach (var customer in ctx.Customers.Where(x => x.Country == "UK"))
                {
                    Console.WriteLine(customer.ContactName + " : " + customer.CompanyName);
                }
                Console.WriteLine(new string('=',40));

                var customers =
                    from c in ctx.Customers
                    where c.City == "Madrid"
                    select c;
                foreach (var c in customers)
                {
                        Console.WriteLine(c.ContactName);
                }
                Console.WriteLine(new string('=', 40));
            }
        }
    }
}
