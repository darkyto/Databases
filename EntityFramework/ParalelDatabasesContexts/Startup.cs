namespace ParalelDatabasesContexts
{
    using System;
    using EntityFramework.Data;

    public class Startup
    {
        private static void Main()
        {
            Console.WriteLine("-- Establishing first connection to database Northwind...");

            using (var firstDb = new NORTHWNDEntities())
            {
                var firstCategory = firstDb.Categories.Find(4);
                Console.WriteLine("Initial category description: {0}", firstCategory.Description);

                firstCategory.Description = "Cheese and many more";
                Console.WriteLine("Category description after changing: {0}", firstCategory.Description);

                Console.WriteLine("-- Establishing second connection to database Northwind...");

                using (var secondDb = new NORTHWNDEntities())
                {
                    var secondCategory = secondDb.Categories.Find(4);
                    Console.WriteLine("Initial category description: {0}", secondCategory.Description);

                    secondCategory.Description = "Cheese and many, many more";
                    Console.WriteLine("Category description after changing: {0}", secondCategory.Description);

                    firstDb.SaveChanges();
                    secondDb.SaveChanges();

                    Console.WriteLine("Category description after saving: {0}", secondCategory.Description);
                }

                Console.WriteLine("-- Closing second connection to the database...");

                Console.WriteLine("Category description after saving: {0}", firstCategory.Description);
            }

            Console.WriteLine("-- Closing first connection to the database...");

            using (var db = new NORTHWNDEntities())
            {
                Console.WriteLine("Actual result: {0}", db.Categories.Find(4).Description);
            }
        }
    }
}
