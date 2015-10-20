namespace _06.AllSongsWithLINQ
{
    using System;
    using System.Linq;
    using System.Xml.Linq;

    public class Program
    {
        public static void Main()
        {
            XDocument xmlDoc = XDocument.Load("../../../catalogue.xml");

            var songs =
                from song in xmlDoc.Descendants("song")
                select new
                {
                    Title = song.Element("title").Value
                };

            Console.WriteLine(new string('-', 60));
            Console.WriteLine("All songs via LINQ and XDocument");
            Console.WriteLine(new string('-', 60));
            foreach (var song in songs)
            {
                Console.WriteLine(song.Title);
            }

            Console.WriteLine(new string('-', 60));
        }
    }
}
