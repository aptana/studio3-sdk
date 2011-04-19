<!--

    @author Kevin Lindsey

    Generates a list of elements along with their attributes. The attribute
    lists are canonicalized by sorting them by name.  The list is not unique
    but on *nix systems it's easy to pipe to sort. For example, you can run
    this on the Mac using the following:

        xsltproc list_attribute_groups.xsl api.xml | sort -u 

    If you need to get frequency counts for each attribute set, use something
    like the following:

        xsltproc list_attribute_groups.xsl api.xml | sort | uniq -c

    The primary use of this script is in determining which group of attributes
    are used together for a given element

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
    <xsl:apply-templates select="@*">
        <xsl:sort select="name()"/>
    </xsl:apply-templates>
    <xsl:text>&#x0A;</xsl:text>
</xsl:template>

<xsl:template match="@*">
    <xsl:choose>
        <xsl:when test="position() = 1">
            <xsl:text>:</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>,</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>@</xsl:text>
    <xsl:value-of select="name()"/>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>
