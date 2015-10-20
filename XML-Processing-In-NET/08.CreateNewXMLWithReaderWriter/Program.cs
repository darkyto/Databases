namespace _08.CreateNewXMLWithReaderWriter
{
    using System.Collections.Generic;
    using System.Text;
    using System.Xml;

    public class Program
    {
        public static void Main()
        {
            IDictionary<string, string> resultAlbums = new Dictionary<string, string>();

            IList<string> albums = new List<string>();
            IList<string> artits = new List<string>();

            using (XmlReader reader = XmlReader.Create("../../../catalogue.xml"))
            {
                while (reader.Read())
                {
                    if ((reader.NodeType == XmlNodeType.Element) && (reader.Name == "name"))
                    {
                        albums.Add(reader.ReadElementContentAsString());
                    }

                    if ((reader.NodeType == XmlNodeType.Element) && (reader.Name == "artist"))
                    {
                        artits.Add(reader.ReadElementContentAsString());
                    }
                }
            }

            for (int i = 0; i < albums.Count; i++)
            {
                resultAlbums.Add(albums[i], artits[i]);
            }

            string filename = "../../album.xml";
            Encoding encoding = Encoding.GetEncoding("utf-8");

            using (XmlTextWriter writer = new XmlTextWriter(filename, encoding))
            {
                writer.Formatting = Formatting.Indented;
                writer.IndentChar = '\t';
                writer.Indentation = 1;

                writer.WriteStartDocument();
                writer.WriteStartElement("albums");

                foreach (var album in resultAlbums)
                {
                    writer.WriteStartElement("album");
                    writer.WriteElementString("name", album.Key);
                    writer.WriteElementString("artist", album.Value);
                    writer.WriteEndElement();
                }

                writer.WriteEndDocument();
            }
        }
    }
}
