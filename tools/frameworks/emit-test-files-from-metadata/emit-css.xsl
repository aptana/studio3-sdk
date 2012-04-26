<!--

    @author Kevin Lindsey

    This script is used to generate a CSS file suitable for testing. The
    content of that file is generated via the content of our CSS metadata file.
    This stylesheet emits a rule for each element in that file. All properties
    for the element are emitted, one for each property value we have in the
    metadata file. If there are no values for the propety, then "" is emitted
    as its value.

    To run this script on a Mac or *nix machine, use something like the
    following:

        xsltproc emit-css.xsl css_metadata.xml > from-metadata.css 

    This assumes the CSS metadata file is in the same directory as stylesheet.
    I just copy it into the directory and delete it when I'm done.

-->

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.1">

<xsl:output method="text"/>

<xsl:template match="/">
	<xsl:apply-templates select="/css/elements/element"/>
</xsl:template>

<xsl:template match="element">
	<xsl:value-of select="@name"/>
	<xsl:text> {&#x0A;</xsl:text>
	<xsl:for-each select="property-refs/property-ref">
		<xsl:variable name="propertyName" select="@name"/>
		<xsl:apply-templates select="/css/properties/property[@name=$propertyName]"/>
	</xsl:for-each>
	<xsl:text>}&#x0A;</xsl:text>
</xsl:template>

<xsl:template match="property">
	<xsl:choose>
		<xsl:when test="count(values/value) > 0">
			<xsl:for-each select="values/value">
				<xsl:if test="@name != '*'">
					<xsl:text>&#x09;</xsl:text>
					<xsl:value-of select="../../@name"/>
					<xsl:text>: </xsl:text>
					<xsl:value-of select="@name"/>
					<xsl:text>;&#x0A;</xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>&#x09;</xsl:text>
			<xsl:value-of select="@name"/>
			<xsl:text>: "";&#x0A;</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
