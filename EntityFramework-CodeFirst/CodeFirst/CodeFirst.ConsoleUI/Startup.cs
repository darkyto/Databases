namespace CodeFirst.ConsoleUI
{
    using System;
    using System.Collections.Generic;
    using System.Data.Entity;
    using System.Linq;
    using CodeFirst.Data;
    using CodeFirst.Models;
    using CodeFirst.Data.Migrations;

    public class Startup
    {
        public static void Main(string[] args)
        {
            Database.SetInitializer(new MigrateDatabaseToLatestVersion<CodeFirstDbContext, Configuration>());

            var db = new CodeFirstDbContext();

            var newCourse = new Course()
            {
                Name = "Databases",
                Description = @"In this course we are learning about MSSQL, MySQL, MongoDB, ADNO.NET, 
                                DatabaseFirst & CodeFirst techniques, ENtityFramework and others."
            };
            //// db.Courses.Add(newCourse);
            //// DeleteCourseById();

            var newStudent = new Student()
            {
                FirstName = "John",
                LastName = "Snow",
                BirthDate = new DateTime(1980, 04, 20, 11, 59, 59),
                Gender = Gender.Male,
                StudentNumber = 123456789
            };
            //// db.Students.Add(newStudent);
            //// DeleteStudentById(2);
           
            var newHomework = new Homework()
            {
                Title = "Code First Entity Framework",
                Attachments = new byte[1000 * 1000 * 3],
                AttachmentsName = "codeFirstHomework",
                AttachmentsExtension = "zip",
                CourseId = 3,
                StudentId = 3
            };

            db.Homeworks.Add(newHomework);

            db.SaveChanges();

            Console.WriteLine(db.Courses.Count());
            Console.WriteLine(db.Students.Count());
            Console.WriteLine(db.Homeworks.Count());
        }

        private static void DeleteCourseById(int wantedId)
        {
            var db = new CodeFirstDbContext();

            var itemToRemove = db.Courses.SingleOrDefault(x => x.Id == wantedId); // returns a single item.
            if (itemToRemove != null)
            {
                db.Courses.Remove(itemToRemove);
                db.SaveChanges();
            }
        }

        private static void DeleteStudentById(int wantedId)
        {
            var db = new CodeFirstDbContext();

            var itemToRemove = db.Students.SingleOrDefault(x => x.Id == wantedId); // returns a single item.
            if (itemToRemove != null)
            {
                db.Students.Remove(itemToRemove);
                db.SaveChanges();
            }
        }
    }
}
