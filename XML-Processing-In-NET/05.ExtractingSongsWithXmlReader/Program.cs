namespace _05.ExtractingSongsWithXmlReader
{
    using System;
    using System.Xml;

    public class Program
    {
        public static void Main(string[] args)
        {
            using (XmlReader reader = XmlReader.Create("../../../catalogue.xml"))
            {
                while (reader.Read())
                {
                    if ((reader.NodeType == XmlNodeType.Element) && (reader.Name == "title"))
                    {
                        Console.WriteLine("{0}", reader.ReadElementContentAsString());   
                    }
                }
            }
        }
    }
}
