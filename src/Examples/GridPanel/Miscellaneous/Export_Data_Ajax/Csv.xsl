<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" />

	<xsl:template match="records">
		<xsl:apply-templates select="record" />
	</xsl:template>

	<xsl:template match="record">
		<xsl:for-each select="*">
			<xsl:text>"</xsl:text>	
			<xsl:value-of select="." />
			<xsl:text>"</xsl:text>
			
			<xsl:if test="position() != last()">
				<xsl:value-of select="','" />
			</xsl:if>
		</xsl:for-each>
		<xsl:text>&#10;</xsl:text>
	</xsl:template>

</xsl:stylesheet>
