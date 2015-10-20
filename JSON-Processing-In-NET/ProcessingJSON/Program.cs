namespace ProcessingJSON
{
    using Newtonsoft.Json;
    using Newtonsoft.Json.Linq;
    using System;
    using System.Text;
    using System.Linq;
    using System.Collections.Generic;
    using System.Net;
    using System.IO;
    using System.Xml;
    using System.Xml.Xsl;

    public class Program
    {
        private const string XML_FILE = "../../rss-feed.xml";
        private const string XSLT_FILE = "../../rss-style.xslt";
        private const string RSS_FEED = "https://www.youtube.com/feeds/videos.xml?channel_id=UCLC-vbm7OWvpbqzXaoAMGGw";
        private const string HTML_FILE = "../../videos.html";

        public static void Main(string[] args)
        {
            Console.OutputEncoding = Encoding.UTF8;

            DownloadRssFeed(RSS_FEED, XML_FILE);
            XmlDocument xmlFile = GetXmlFile(XML_FILE);
            JObject jsonObject = XmlToJson(xmlFile);

            var titles = GetVideoTitles(jsonObject);
            foreach (var title in titles)
            {
                Console.WriteLine(title.ToString());
            }

            GenerateHtml(XSLT_FILE, XML_FILE, HTML_FILE);
        }

        internal static void DownloadRssFeed(string source, string destination)
        {

            using (WebClient wc = new WebClient())
            {
                wc.Encoding = Encoding.UTF8;
                wc.DownloadFile(source, destination);
            }
        }

        internal static XmlDocument GetXmlFile(string xmlFilePath)
        {
            XmlDocument xml = new XmlDocument();
            xml.Load(xmlFilePath);

            return xml;
        }

        internal static JObject XmlToJson(XmlDocument xml)
        {
            string jsonString = JsonConvert.SerializeXmlNode(xml);
            var jsonObject = JObject.Parse(jsonString);

            return jsonObject;
        }

        internal static IEnumerable<JToken> GetVideoTitles(JObject jsonObject)
        {
            return jsonObject["feed"]["entry"]
                .Select(entry => entry["title"]);
        }

        internal static void GenerateHtml(string xsltFile, string xmlFile, string destination)
        {
            XslCompiledTransform xslt = new XslCompiledTransform();
            xslt.Load(xsltFile);
            xslt.Transform(xmlFile, destination);
        }
    }
}
