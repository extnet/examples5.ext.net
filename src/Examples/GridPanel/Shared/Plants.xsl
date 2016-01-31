<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="catalog">
		<catalog>
			<xsl:apply-templates select="plant" />
		</catalog>
	</xsl:template>

	<xsl:template match="plant">
		<Plant>
			<xsl:attribute name="Common">
				<xsl:value-of select="common" />
			</xsl:attribute>
			<xsl:attribute name="Botanical">
				<xsl:value-of select="botanical" />
			</xsl:attribute>
			<xsl:attribute name="Zone">
				<xsl:value-of select="zone" />
			</xsl:attribute>
			<xsl:attribute name="Light">
				<xsl:value-of select="light" />
			</xsl:attribute>
			<xsl:attribute name="Price">
				<xsl:value-of select="price" />
			</xsl:attribute>
			<xsl:attribute name="Availability">
				<xsl:value-of select="availability" />
			</xsl:attribute>
			<xsl:attribute name="Indoor">
				<xsl:value-of select="indoor" />
			</xsl:attribute>
		</Plant>
	</xsl:template>

</xsl:stylesheet>