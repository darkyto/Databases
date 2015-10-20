namespace CodeFirst.Data
{
    using System;
    using System.Data.Entity;
    using CodeFirst.Models;

    public class CodeFirstDbContext : DbContext
    {
        public CodeFirstDbContext()
            : base("CodeFirst")
        {
        }

        public virtual IDbSet<Course> Courses { get; set; }

        public virtual IDbSet<Student> Students { get; set; }

        public virtual IDbSet<Homework> Homeworks { get; set; }

        public virtual IDbSet<Material> Materials { get; set; }
    }
}
