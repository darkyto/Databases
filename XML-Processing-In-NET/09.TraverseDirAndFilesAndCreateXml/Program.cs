namespace _09.TraverseDirAndFilesAndCreateXml
{
    using System;
    using System.IO;
    using System.Linq;
    using System.Text;
    using System.Xml;

    public class Program
    {
        public static void Main(string[] args)
        {
            string directory = @"../../../";

            string filename = "../../traversedDir.xml";
            Encoding encoding = Encoding.GetEncoding("utf-8");
            DirectoryInfo root = new DirectoryInfo(directory);

            using (XmlTextWriter writer = new XmlTextWriter(filename, encoding))
            {
                writer.Formatting = Formatting.Indented;
                writer.IndentChar = ' ';
                writer.Indentation = 4;

                writer.WriteStartDocument();
                writer.WriteStartElement("root");
                XmlGeneratedTraversedTreeRecursivly(writer, root);
                writer.WriteEndElement();
                writer.WriteEndDocument();
            }

            Console.WriteLine("File traversedDir.xml successfully created!");
        }
        public static void XmlGeneratedTraversedTreeRecursivly(XmlTextWriter writer, DirectoryInfo rootDirectory)
        {
            if (!rootDirectory.GetDirectories().Any() && !rootDirectory.GetFiles().Any())
            {
                return;
            }

            writer.WriteStartElement("dir");
            writer.WriteAttributeString("name", rootDirectory.Name);

            foreach (var file in rootDirectory.GetFiles())
            {
                writer.WriteStartElement("file");
                writer.WriteAttributeString("name", Path.GetFileNameWithoutExtension(file.ToString()));
                writer.WriteAttributeString("type", Path.GetExtension(file.ToString()).Substring(1));
                writer.WriteEndElement();
            }

            foreach (var dir in rootDirectory.GetDirectories())
            {
                XmlGeneratedTraversedTreeRecursivly(writer, dir);
            }

            writer.WriteEndElement();
        }
    }
}
