namespace XMLProcessingInNET
{
    using System;
    using System.Collections.Generic;
    using System.Xml;

    public class Program
    {
        public static void Main(string[] args)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load("../../../catalogue.xml");
            XmlElement rootNode = doc.DocumentElement;

            if (rootNode == null)
            {
                throw new NullReferenceException("No XML document to load!");
            }

            Console.WriteLine("task 2.) {0}", new string('=', 40));
            Console.WriteLine("Document rootNode name : {0}", rootNode.Name);

            var artists = new HashSet<string>();

            foreach (XmlNode node in rootNode.ChildNodes)
            {
                artists.Add(node["artist"].InnerText);
            }

            Console.WriteLine("ALL Artists:\n {0}", string.Join("\n ", artists));
            Console.WriteLine(new string('=', 60));

            var albums = NumberOfAlbums(rootNode);
            foreach (var album in albums)
            {
                if (album.Value > 1)
                {
                    Console.WriteLine("{0} has {1} albums ", album.Key, album.Value);
                }
                else
                {
                    Console.WriteLine("{0} has {1} album ", album.Key, album.Value);
                }           
            }
        }

        private static IDictionary<string, int> NumberOfAlbums(XmlElement rootNode)
        {
            var result = new Dictionary<string, int>();

            var albums = rootNode.GetElementsByTagName("album");
            foreach (XmlNode album in albums)
            {
                var artist = album["artist"].InnerText;
                if (!result.ContainsKey(artist))
                {
                    result[artist] = 0;
                }

                result[artist]++;
            }

            return result;
        }
    }
}
