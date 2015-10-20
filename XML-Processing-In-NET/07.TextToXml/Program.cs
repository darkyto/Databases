namespace _07.TextToXml
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Text;
    using System.Xml;

    public class Program
    {
        public static void Main(string[] args)
        {
            string[] lines = File.ReadAllLines("../../people.txt");
            List<Person> people = new List<Person>();

            for (int i = 0; i < lines.Length; i += 3)
            {
                var person = new Person { Name = lines[i], Address = lines[i + 1], PhoneNumber = lines[i + 2] };
                people.Add(person);
            }

            string filename = "../../people.xml";
            Encoding encoding = Encoding.GetEncoding("utf-8");

            using (XmlTextWriter writer = new XmlTextWriter(filename, encoding))
            {
                writer.Formatting = Formatting.Indented;
                writer.IndentChar = '\t';
                writer.Indentation = 1;

                writer.WriteStartDocument();
                writer.WriteStartElement("people");

                for (int i = 0; i < people.Count; i++)
                {
                    AddPersonInXml(
                        writer, 
                        people[i].Name.ToString(), 
                        people[i].Address.ToString(), 
                        people[i].PhoneNumber.ToString());
                }
                
                writer.WriteEndDocument();
            }

            Console.WriteLine("XML Document people.xml successfuly created!");
        }

        public static void AddPersonInXml(XmlWriter writer, string name, string address, string phone)
        {
            writer.WriteStartElement("person");
            writer.WriteElementString("name", name);
            writer.WriteElementString("address", address);
            writer.WriteElementString("phoneNumber", phone);
            writer.WriteEndElement();
        }
    }
}
