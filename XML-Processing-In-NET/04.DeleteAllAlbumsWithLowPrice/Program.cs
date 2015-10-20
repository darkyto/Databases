namespace _04.DeleteAllAlbumsWithLowPrice
{
    using System.Xml;

    public class Program
    {
        public static void Main(string[] args)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load("../../../catalogue.xml");
            XmlElement rootNode = doc.DocumentElement;

            var albums = rootNode.SelectNodes("album");

            foreach (XmlNode album in albums)
            {
                if (double.Parse(album["price"].InnerText) > 20)
                {
                    rootNode.RemoveChild(album);
                }
            }

            doc.Save("../../catalogueWithSelectedPricesOver20.xml");
        }
    }
}
