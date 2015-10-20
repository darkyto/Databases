namespace _10.TraverseViaXPath
{
    using System;
    using System.IO;
    using System.Text;
    using System.Xml.Linq;

    public class Program
    {
        public static void Main()
        {
            Console.WriteLine("This program will travese three directories up and make an xml tree file called traversedDirXPath.xml");
            Console.WriteLine("If you want to try it yourself please delete the test created xml file in the working directory");

            var directory = "../../../";

            string filename = "../../traversedDirXPath.xml";
            Encoding encoding = Encoding.GetEncoding("utf-8");
            DirectoryInfo root = new DirectoryInfo(directory);
            
            var traversedDoc = TraverseViaXPath(root);
            traversedDoc.Save(filename);
        }

        private static XElement TraverseViaXPath(DirectoryInfo root)
        {
            var childElements = new XElement("dir", new XAttribute("name", root.Name));

            foreach (var file in root.GetFiles())
            {
                // Path.GetFileNameWithoutExtension(file.ToString())
                childElements.Add(new XElement(
                    "file", 
                    new XAttribute("name", file.Name),
                    new XAttribute("type", Path.GetExtension(file.ToString()).Substring(1))));
            }

            foreach (var dir in root.GetDirectories())
            {
                childElements.Add(TraverseViaXPath(dir));
            }

            return childElements;
        }
    }
}
