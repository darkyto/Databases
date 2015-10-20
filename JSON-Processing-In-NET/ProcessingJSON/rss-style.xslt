<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
      <html>
      <head>

      <style>
       body{
          background-color: #F0F1F3;
          font-family: Consolas;
          font-size: 20px;
       }
        .container {
          background-color: #E3E4E9;
          color: #40434A;
          width:250px;
          height: 60px;        
          text-align: center;        
        }
      </style>
      
      </head>
      <body> 
        
        <h3>RSS Feed Youtube Links</h3>

        <div>
        <xsl:for-each select="feed/entry">
          <div>
            <h3><xsl:value-of select="title" /></h3>  
          </div>

          <div>
            <xsl:element name="iframe">
              <xsl:attribute name="src">
                <xsl:value-of select="link[href]"/>
              </xsl:attribute>
            </xsl:element>
          </div>
        </xsl:for-each>
        </div>

      </body>
      </html>
    </xsl:template>
</xsl:stylesheet>
