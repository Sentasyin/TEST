<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <!-- Identity transform: copy everything by default -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Transform the root element -->
    <xsl:template match="tei:TEI">
        <html>
            <head>
                <title>Roman-Byzantine Coin</title>
                <style>
                    body { font-family: Arial, sans-serif; margin: 20px; }
                    h1 { color: #333; }
                    .section { margin-bottom: 20px; }
                    .section h2 { color: #666; }
                    .images img { max-width: 100%; height: auto; }
                </style>
            </head>
            <body>
                <h1><xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></h1>
                <div class="section">
                    <h2>Publication Information</h2>
                    <p><strong>Authority:</strong> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:authority"/></p>
                    <p><strong>File ID:</strong> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno"/></p>
                </div>
                <div class="section">
                    <h2>Physical Description</h2>
                    <p><strong>Object Type:</strong> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:objectType"/></p>
                    <p><strong>Material:</strong> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:material"/></p>
                    <p><strong>Dimensions:</strong> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:dimensions/tei:diameter"/> diameter, <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:dimensions/tei:weight"/> weight</p>
                    <p><strong>Inscriptions:</strong> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:inscriptions"/></p>
                    <p><strong>Layout:</strong> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:layoutDesc/tei:layout"/></p>
                    <p><strong>Hand Description:</strong> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:handDesc/tei:handNote"/></p>
                </div>
                <div class="section">
                    <h2>History</h2>
                    <p><strong>Origin:</strong> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:history/tei:origin/tei:origPlace"/> (Date: <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:history/tei:origin/tei:origDate"/>)</p>
                    <p><strong>Provenance:</strong> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:history/tei:provenance[@type='found']"/></p>
                    <p><strong>Current Location:</strong> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:history/tei:provenance[@type='observed']"/></p>
                </div>
                <div class="section images">
                    <h2>Images</h2>
                    <xsl:for-each select="tei:facsimile/tei:graphic">
                        <div>
                            <img src="{@url}" alt="{@desc}" />
                            <p><strong>Description:</strong> <xsl:value-of select="@desc"/></p>
                        </div>
                    </xsl:for-each>
                </div>
                <div class="section">
                    <h2>Text</h2>
                    <xsl:apply-templates select="tei:text/tei:body/tei:div"/>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- Templates for different types of content -->
    <xsl:template match="tei:div[@type='edition']">
        <h2>Edition</h2>
        <p><xsl:value-of select="." /></p>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='translation']">
        <h2>Translation</h2>
        <p><xsl:value-of select="." /></p>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='commentary']">
        <h2>Commentary</h2>
        <p><xsl:value-of select="." /></p>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='bibliography']">
        <h2>Bibliography</h2>
        <p><xsl:value-of select="." /></p>
    </xsl:template>
    
</xsl:stylesheet>