using System.Data.Entity;

namespace NorthwindTwinCreation
{
    using System;
    using EntityFramework.Data;

    public class Startup
    {
        /// <summary>
        /// In order for this to create a twin base of NORTHWIND you have to change 
        /// the 'initial catalog' to the name of the twin db (NORTHWINDtwin in this case)
        /// This will create a twin base ONLY if no such base with the same name exists in MSSQL database catalog
        /// </summary>
        public static void Main()
        {
            var dbContext = new NORTHWNDEntities();

            CreateTwinDatabase(dbContext);

            // DeleteDatabase(dbContext);
        }

        /// <summary>
        /// Must assign the twin db name in app.config - rename it in "initial catalg = NEW_NAME"
        /// </summary>
        /// <param name="dbContext"></param>
        private static void CreateTwinDatabase(DbContext dbContext)
        {
            using (dbContext)
            {
                var isCreated = dbContext.Database.CreateIfNotExists();
                Console.WriteLine(isCreated ? "Twin database created" : "Error in creation of twin database (one with this name already exists?!)");
            }
        }
        private static void DeleteDatabase(DbContext dbContext)
        {
            using (dbContext)
            {
                var isCreated = dbContext.Database.Delete();
                Console.WriteLine(isCreated ? "Database deleted" : "Error deleting database from catalog)");
            }
        }
    }
}
