namespace _13.XSLTransform
{
    using System.Xml.Xsl;
    using System.IO;

    public class Program
    {
        public static void Main(string[] args)
        {
            XslCompiledTransform xslt = new XslCompiledTransform();
            xslt.Load("../../xsl-styke.xslt");
            xslt.Transform("../../../catalogue.xml", "../../catalogue.html");

            System.Diagnostics.Process.Start(Path.GetFullPath("../../catalogue.html"));
        }
    }
}
