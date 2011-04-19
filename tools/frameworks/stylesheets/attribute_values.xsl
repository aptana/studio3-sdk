<!--

    @author Kevin Lindsey

    This is mostly a template to be changed on demand. Replace the "select"
    expression with whatever you want to list.  The list is not unique but on
    *nix systems it's easy to pipe to sort. For example, you can run this on
    the Mac using the following:

        xsltproc attribute_values.xsl api.xml | sort -u 

    If you need to get frequency counts for each value, use something like the
    following:

        xsltproc attribute_values.xsl api.xml | sort | uniq -c

    The primary use of this script is in determining what values are being used
    for a given attribute on an element. However, since any expression can be
    used, it may be useful for list other types of values. Mainly, I didn't
    want to have to keep recreating this simple stylesheet over and over again
    :). It would be pretty trivial to write a shell script that uses this as a
    template, fills in the xpath expression, emits a stylesheet, and then runs
    that against an XML file.

-->

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.1">
	
<xsl:output method="text"/>

<xsl:template match="/">
	<xsl:apply-templates select="//method/@super"/>
</xsl:template>

<xsl:template match="@*">
	<xsl:value-of select="."/>
	<xsl:text>&#x0A;</xsl:text>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>
