namespace _03.ExtractUsingXPath
{
    using System;
    using System.Collections.Generic;
    using System.Xml;

    public class Program
    {
        public static void Main()
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("../../../catalogue.xml");
            var pathQuery = "/catalogue/album/artist";

            XmlNodeList artistList = xmlDoc.SelectNodes(pathQuery);

            var artists = new HashSet<string>();
            foreach (XmlNode artistNode in artistList)
            {
                artists.Add(artistNode.InnerText);
            }

            Console.WriteLine("ALL Artists (non-reapating): \n {0}", string.Join("\n ", artists));

            var rootNode = xmlDoc.DocumentElement;
            var artistsAndAlbum = NumberOfAlbumsByArtist(rootNode);

            Console.WriteLine(new string('-', 60));
            foreach (var artist in artistsAndAlbum)
            {
                Console.WriteLine("Artist: {0}\nNumber of Albums: {1}", artist.Key, artist.Value);
                Console.WriteLine(new string('-', 60));
            }
        }

        private static IDictionary<string, int> NumberOfAlbumsByArtist(XmlElement rootNode)
        {
            var result = new Dictionary<string, int>();

            var artists = rootNode.SelectNodes("/catalogue/album/artist");

            foreach (XmlNode artist in artists)
            {
                if (result.ContainsKey(artist.InnerText))
                {
                    result[artist.InnerText] += 1;
                }
                else
                {
                    result.Add(artist.InnerText, 1);  
                }
            }

            return result;
        }
    }
}
