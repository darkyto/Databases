<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">

    <xsl:template match="/">
        <html>
         <head>
           <title>Album acatalog</title>
           <style>
           body {background-color: darkgreen; color:yellow; font-size:24px;}
           .box {border:5px solid white; border-radius:20px}
           li {border: 2px solid green; border-radius:20px}
           </style>
        </head>
        <body>
          <h1>Album Catalog</h1>
          <xsl:for-each select="catalogue/album">
          <div class="box">
            <h3><xsl:value-of select="name"/></h3>
            <ul>
              <li>Artits: <xsl:value-of select="artist"/></li>
              <li>Year: <xsl:value-of select="year"/></li>
              <li>Producer: <xsl:value-of select="producer"/></li>
              <li>Price: <xsl:value-of select="price"/></li>
              <li>
                <xsl:for-each select="songs/song">
                 Title: <xsl:value-of select="title"/>
                 Duration: <xsl:value-of select="duration"/>
                </xsl:for-each>
              </li>
            </ul>
          </div>
          </xsl:for-each>
        </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
