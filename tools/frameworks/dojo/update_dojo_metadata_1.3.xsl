<!--

	@author Kevin Lindsey
	
	Convert a malformed Dojo 1.3 ScriptDoc XML file to the ScriptDoc XML schema. This may work on higher
	versions of the Dojo API, but is certainly broken with version 1.6. Below is a summary of what this stylesheet transforms:
	
	1. There are no @constructor or @super attributes on method elements, so these were stripped
	2. Method elements that have @constructor attributes are skipped for now. These should probably be converted to constructor elements
	3. All object elements were converted to class elements
	4. There are no @classlike attributes on class elements, so these were stripped
	5. The @type attribute on object meant something different than what the schema defined. These were stripped too
	6. The @location attribute on object was the equivalent of @type on class, so these were converted to @type attributes
	7. A number of @scope attributes were defined but were empty. Those have been changed to "instance"
	8. A number of @location attributes were defined but were empty. Those have been changed to "Object"
	
	You can run this on the Mac using the following:
	
	xsltproc update_metadata.xsl api_original.xml > api.sdocml
	
	Drop this file into your Dojo project
	
-->

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.1">

<xsl:output method="xml" indent="yes" />

<xsl:template match="description">
	<xsl:copy-of select="." />
</xsl:template>

<xsl:template match="example">
	<xsl:copy-of select="." />
</xsl:template>

<xsl:template match="javascript">
	<xsl:copy>
		<xsl:apply-templates select="object" />
	</xsl:copy>
</xsl:template>

<xsl:template match="method">
	<xsl:if test="not(@constructor)">
		<xsl:copy>
			<!--
				<xsl:apply-templates select="@constructor"/> <xsl:apply-templates
				select="@super"/>
			-->
			<xsl:apply-templates select="@name" />
			<xsl:apply-templates select="@scope" />
			<xsl:apply-templates select="description" />
			<xsl:apply-templates select="example" />
			<xsl:apply-templates select="parameters" />
			<xsl:apply-templates select="return-description" />
			<xsl:apply-templates select="return-types" />
		</xsl:copy>
	</xsl:if>
</xsl:template>

<xsl:template match="methods">
	<xsl:copy>
		<xsl:apply-templates select="method" />
	</xsl:copy>
</xsl:template>

<xsl:template match="mixin">
	<xsl:copy>
		<xsl:apply-templates select="@location" />
		<xsl:apply-templates select="@scope" />
	</xsl:copy>
</xsl:template>

<xsl:template match="mixins">
	<xsl:copy>
		<xsl:apply-templates select="@scope" />
		<xsl:apply-templates select="mixin" />
	</xsl:copy>
</xsl:template>

<xsl:template match="object">
	<xsl:element name="class">
		<!--
			<xsl:apply-templates select="@classlike"/> <xsl:apply-templates
			select="@type"/>
		-->
		<xsl:apply-templates select="@location" />
		<xsl:apply-templates select="@superclass" />
		<xsl:apply-templates select="description" />
		<xsl:apply-templates select="example" />
		<xsl:apply-templates select="methods" />
		<xsl:apply-templates select="mixins" />
		<xsl:apply-templates select="properties" />
	</xsl:element>
</xsl:template>

<xsl:template match="parameter">
	<xsl:copy>
		<xsl:apply-templates select="@name" />
		<xsl:apply-templates select="@type" />
		<xsl:apply-templates select="@usage" />
		<xsl:apply-templates select="description" />
	</xsl:copy>
</xsl:template>

<xsl:template match="parameters">
	<xsl:copy>
		<xsl:apply-templates select="parameter" />
	</xsl:copy>
</xsl:template>

<xsl:template match="properties">
	<xsl:copy>
		<xsl:apply-templates select="property" />
	</xsl:copy>
</xsl:template>

<xsl:template match="property">
	<xsl:copy>
		<xsl:apply-templates select="@name" />
		<xsl:apply-templates select="@scope" />
		<xsl:apply-templates select="@type" />
		<xsl:apply-templates select="description" />
	</xsl:copy>
</xsl:template>

<xsl:template match="return-description">
	<xsl:copy-of select="." />
</xsl:template>

<xsl:template match="return-type">
	<xsl:copy>
		<xsl:apply-templates select="@type" />
	</xsl:copy>
</xsl:template>

<xsl:template match="return-types">
	<xsl:copy>
		<xsl:apply-templates select="return-type" />
	</xsl:copy>
</xsl:template>

<!-- attribute templates -->

<xsl:template match="@location">
	<xsl:attribute name="type">
   <xsl:value-of select="." />
 </xsl:attribute>
</xsl:template>

<xsl:template match="@scope">
	<xsl:choose>
		<xsl:when test="string-length(.) = 0">
			<xsl:attribute name="scope">
       <xsl:text>instance</xsl:text>
     </xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy-of select="." />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="@type">
	<xsl:choose>
		<xsl:when test="string-length(.) = 0">
			<xsl:attribute name="type">
       <xsl:text>Object</xsl:text>
     </xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy-of select="." />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="@*">
	<xsl:copy-of select="." />
</xsl:template>

</xsl:stylesheet>
