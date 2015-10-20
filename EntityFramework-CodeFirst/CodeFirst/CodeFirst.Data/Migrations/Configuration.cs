namespace CodeFirst.Data.Migrations
{
    using System.Data.Entity.Migrations;
    using CodeFirst.Models;

    public sealed class Configuration : DbMigrationsConfiguration<CodeFirstDbContext>
    {
        public Configuration()
        {
            this.AutomaticMigrationsEnabled = true;
            this.AutomaticMigrationDataLossAllowed = true;
            this.ContextKey = "CodeFirst.Data.CodeFirstDbContext";
        }

        protected override void Seed(CodeFirstDbContext context)
        {
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data. E.g.
            //
            //  context.Courses.AddOrUpdate(
            //      s => s.Name,
            //      new Course()
            //      {
            //          Name = "C# Part One",
            //          Description = @"C# Fundamentals course"
            //      }, 
            //      new Course()
            //      {
            //          Name = "C# Part Two",
            //          Description = @"C# Fundamentals course - part 2"
            //      });

        }
    }
}