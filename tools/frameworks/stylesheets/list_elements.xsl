<!--

    @author Kevin Lindsey
    
    Generates a list of elements showing their attributes and child elements.
    The list is not unique but on *nix systems it's easy to pipe to sort. For
    example, you can run this on the Mac using the following:
    
        xsltproc list_elements.xsl html_metadata_original.xml | sort -u 

    The primary use of this script is in determining a schema for a given XML
    document. Optionally, the output can be processed by
    make_cloning_stylesheet.pl to generate an XSLT stylesheet that will clone
    the document. See that script for more details
    
-->

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.1">
	
<xsl:output method="text"/>

<xsl:template match="/">
	<xsl:apply-templates select="//*"/>
</xsl:template>

<xsl:template match="*">
	<xsl:value-of select="name()"/>
	<xsl:text>&#x0A;</xsl:text>
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates select="*" mode="display"/>
</xsl:template>

<xsl:template match="*" mode="display">
    <xsl:value-of select="name(..)"/>
    <xsl:text>></xsl:text>
    <xsl:value-of select="name()"/>
    <xsl:text>&#x0A;</xsl:text>
</xsl:template>

<xsl:template match="@*">
    <xsl:value-of select="name(..)"/>
    <xsl:text>@</xsl:text>
    <xsl:value-of select="name()"/>
    <xsl:text>&#x0A;</xsl:text>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>
