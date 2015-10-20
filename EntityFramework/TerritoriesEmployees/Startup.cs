namespace TerritoriesEmployees
{
    using System;
    using System.Linq;
    using EntityFramework.Data;

    public class Startup
    {
        public static void Main(string[] args)
        {
            using (var db = new NORTHWNDEntities())
            {
                foreach (var employee in db.Employees.Include("Territories"))
                {
                    var correspondingTerritories = employee.Territories.Select(c => c.TerritoryID);
                    var correspondingTerritoriesAsString = string.Join(", ", correspondingTerritories);
                    Console.WriteLine("{0} -> Territory IDs: {1}", employee.FirstName, correspondingTerritoriesAsString);
                }
            }
        }
    }
}
