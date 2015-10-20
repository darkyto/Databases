namespace _12.ExtractOldAlbumsViaLINQ
{
    using System;
    using System.Linq;
    using System.Xml.Linq;

    public class Program
    {
        public static void Main(string[] args)
        {
            
            XDocument xmlDoc = XDocument.Load("../../../catalogue.xml");

            var albums = from album in xmlDoc.Descendants("album")
                         where int.Parse(album.Element("year").Value) <= 2010
                         select new
                         {
                             Name = album.Element("name").Value,
                             Price = album.Element("price").Value,
                         };

            foreach (var album in albums)
            {
                Console.WriteLine("Album: {0} \\nPrice: {1}", album.Name, album.Price);
            }
                         
        }
    }
}
