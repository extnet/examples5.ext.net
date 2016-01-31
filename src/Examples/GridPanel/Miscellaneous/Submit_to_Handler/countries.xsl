<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="Countries">
		<Countries>
			<xsl:apply-templates select="Country" />
		</Countries>
	</xsl:template>

	<xsl:template match="Country">
		<Country>
			<xsl:attribute name="Name">
				<xsl:value-of select="Name" />
			</xsl:attribute>			
		</Country>
	</xsl:template>

</xsl:stylesheet>