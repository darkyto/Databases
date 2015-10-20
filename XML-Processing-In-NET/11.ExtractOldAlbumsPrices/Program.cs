namespace _11.ExtractOldAlbumsPrices
{
    using System;
    using System.Xml;

    public class Program
    {
        public static void Main(string[] args)
        {
            const string query = "/catalogue/album[year<2010]";
            var xmlDoc = new XmlDocument();
            xmlDoc.Load("../../../catalogue.xml");

            var albums = xmlDoc.SelectNodes(query);

            foreach (XmlNode album in albums)
            {
                var name = album.SelectSingleNode("name").InnerText;
                var price = album.SelectSingleNode("price").InnerText;
                Console.WriteLine("Album: {0} \nPrice: {1}", name, price);            
            }
        }
    }
}
