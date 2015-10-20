namespace CreatingTestCustomers
{
    using System;
    using System.Linq;
    using CreatingDbContextNorthwind;

    public class Startup
    {
        private static NORTHWNDEntities context;

        private static void Main()
        {
            Console.WriteLine("Connecting");

            using (context = new NORTHWNDEntities())
            {
                Console.WriteLine("Queries execution");

                InsertNewCustomersToDb();

                ModifyNewInsertedCustomer();

                DeleteNewInsertedCustomer();
            }

            Console.WriteLine("Success!");
        }

        private static void DeleteNewInsertedCustomer()
        {
            var customer = context.Customers.First();
            context.Customers.Remove(customer);
            context.SaveChanges();
            Console.WriteLine("(Row affected)");
        }

        private static void ModifyNewInsertedCustomer()
        {
            var customer = context.Customers.First();
            customer.ContactTitle = "IT Resseler";
            context.SaveChanges();
            Console.WriteLine("(Row affected)");
        }

        private static void InsertNewCustomersToDb()
        {
            var newCustomer = new Customer
            {
                CustomerID = "AAAAA",
                CompanyName = "Telerik",
                ContactName = "Pesho Peshev",
                ContactTitle = "Driver",
                Address = "33 Al.Stamboliiski Str.",
                City = "Sofia",
                PostalCode = "1300",
                Country = "Bulgaria",
                Phone = "02-9992266",
                Fax = "02-9992267"
            };

            context.Customers.Add(newCustomer);
            context.SaveChanges();
            Console.WriteLine("(Row affected)");
        }
    }
}
