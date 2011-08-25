<!--

    @author Kevin Lindsey

    Convert a jQuery 1.6.2 api.xml file to the ScriptDoc XML schema. You can run this on the Mac using the following:

        xsltproc update_jquery_metadata_1.6.2.xsl api.xml > jquery_1.6.2.sdocml 

-->

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.1">

<xsl:output method="xml" indent="yes" />

<!--
	match /
-->
<xsl:template match="/">
	<xsl:variable name="className">jQuery</xsl:variable>
	<xsl:variable name="classNamePrefix" select="concat($className, '.')"/>
	<javascript>
		<aliases>
			<alias name="$" type="{$className}"/>
		</aliases>
		<class type="{$className}">
			<constructors>
				<xsl:apply-templates select="/api/entries/entry[@type='method' and @name=$className]" mode="constructor"/>
			</constructors>
			<properties>
				<xsl:apply-templates select="/api/entries/entry[@type='property' and @name!=$className and (not(contains(@name, '.')) or starts-with(@name, $classNamePrefix))]" mode="property">
					<xsl:with-param name="className" select="$className"/>
				</xsl:apply-templates>
			</properties>
			<methods>
				<xsl:apply-templates select="/api/entries/entry[@type='method' and @name!=$className and (not(contains(@name, '.')) or starts-with(@name, $classNamePrefix))]" mode="method">
					<xsl:with-param name="className" select="$className"/>
				</xsl:apply-templates>
			</methods>
		</class>
	</javascript>
</xsl:template>

<!--
	match entry - for constructors
-->
<xsl:template match="entry" mode="constructor">
	<xsl:element name="constructor">
		<xsl:if test="count(signature/argument) > 0">
			<parameters>
				<xsl:apply-templates select="signature/argument"/>
			</parameters>
		</xsl:if>

		<return-types>
			<return-type>
				<xsl:attribute name="type">
					<xsl:call-template name="fixType">
						<xsl:with-param name="type">
							<xsl:value-of select="@return"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
			</return-type>
		</return-types>

		<xsl:if test="string-length(desc/text()) > 0">
			<description>
				<xsl:value-of select="desc/text()"/>
			</description>
		</xsl:if>
		<xsl:if test="count(example) > 0">
			<examples>
				<xsl:apply-templates select="example"/>
			</examples>
		</xsl:if>
	</xsl:element>
</xsl:template>

<!--
	match entry - for methods
-->
<xsl:template match="entry" mode="method">
	<xsl:param name="className"/>
	<xsl:variable name="classNamePrefix" select="concat($className, '.')"/>
	<xsl:variable name="methodName">
		<xsl:choose>
			<xsl:when test="contains(@name, '.')">
				<xsl:value-of select="substring-after(@name, '.')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@name"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:element name="method">
		<xsl:attribute name="name">
			<xsl:value-of select="$methodName"/>
		</xsl:attribute>

		<xsl:attribute name="scope">
			<xsl:choose>
				<xsl:when test="starts-with(@name, $classNamePrefix)">
					<xsl:text>static</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>instance</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>

		<xsl:if test="count(signature/argument) > 0">
			<parameters>
				<xsl:apply-templates select="signature/argument"/>
			</parameters>
		</xsl:if>

		<xsl:if test="string-length(@return) > 0">
			<return-types>
				<xsl:call-template name="emitReturnTypes">
					<xsl:with-param name="types">
						<xsl:call-template name="fixType">
							<xsl:with-param name="type" select="translate(@return, ' ', '')"/>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</return-types>
		</xsl:if>

		<xsl:if test="string-length(desc/text()) > 0">
			<description>
				<xsl:value-of select="desc/text()"/>
			</description>
		</xsl:if>

		<xsl:if test="count(example) > 0">
			<examples>
				<xsl:apply-templates select="example"/>
			</examples>
		</xsl:if>
	</xsl:element>
</xsl:template>

<!--
	match entry - for properties
-->
<xsl:template match="entry" mode="property">
	<xsl:param name="className"/>
	<xsl:variable name="classNamePrefix" select="concat($className, '.')"/>
	<xsl:variable name="propertyName">
		<xsl:choose>
			<xsl:when test="contains(@name, '.')">
				<xsl:value-of select="substring-after(@name, '.')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@name"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:element name="property">
		<xsl:attribute name="name">
			<xsl:value-of select="$propertyName"/>
		</xsl:attribute>

		<xsl:attribute name="scope">
			<xsl:choose>
				<xsl:when test="starts-with(@name, $classNamePrefix)">
					<xsl:text>static</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>instance</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>

		<xsl:attribute name="type">
			<xsl:value-of select="@return"/>
		</xsl:attribute>

		<xsl:if test="string-length(desc/text()) > 0">
			<description>
				<xsl:value-of select="desc/text()"/>
			</description>
		</xsl:if>

		<xsl:if test="count(example) > 0">
			<examples>
				<xsl:apply-templates select="example"/>
			</examples>
		</xsl:if>
	</xsl:element>
</xsl:template>

<!--
	match argument
-->
<xsl:template match="argument">
	<xsl:element name="parameter">
		<xsl:attribute name="name">
			<xsl:call-template name="fixName">
				<xsl:with-param name="name">
					<xsl:value-of select="@name"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:attribute>
		<xsl:attribute name="type">
			<xsl:call-template name="fixType">
				<xsl:with-param name="type">
					<xsl:value-of select="translate(@type, ',', '|')"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:attribute>
		<xsl:attribute name="usage">
			<xsl:choose>
				<xsl:when test="@optional = 'true'">
					<xsl:text>optional</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>required</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:if test="string-length(desc/text()) > 0">
			<description>
				<xsl:value-of select="desc/text()"/>
			</description>
		</xsl:if>
	</xsl:element>
</xsl:template>

<!--
	match example
-->
<xsl:template match="example">
	<example>
		<xsl:if test="string-length(desc) > 0">
			&lt;p&gt;<xsl:value-of select="desc"/>&lt;/p&gt;
		</xsl:if>
		&lt;p&gt;<xsl:value-of select="code"/>&lt;/p&gt;
	</example>
</xsl:template>

<!--
	match text nodes
-->
<xsl:template match="text()"/>

<!--
	emit a list of return types
-->
<xsl:template name="emitReturnTypes">
	<xsl:param name="types"/>

	<xsl:if test="string-length($types) > 0">
		<return-type>
			<xsl:attribute name="type">
				<xsl:choose>
					<xsl:when test="contains($types, ',')">
						<xsl:value-of select="substring-before($types, ',')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$types"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</return-type>

		<!-- recurse -->
		<xsl:if test="contains($types, ',')">
			<xsl:call-template name="emitReturnTypes">
				<xsl:with-param name="types">
					<xsl:value-of select="substring-after($types, ',')"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:if>
</xsl:template>

<!--
	fix invalid names
-->
<xsl:template name="fixName">
	<xsl:param name="name"/>

	<xsl:choose>
		<xsl:when test="starts-with($name, '-')">
			<xsl:value-of select="substring-after($name, '-')"/>
		</xsl:when>
		<xsl:when test="contains($name, '(')">
			<xsl:value-of select="substring-before($name, '(')"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$name"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--
	fix invalid types
-->
<xsl:template name="fixType">
	<xsl:param name="type"/>

	<xsl:choose>
		<xsl:when test="$type = 'Any'">Object</xsl:when>
		<xsl:when test="$type = 'boolean'">Boolean</xsl:when>
		<xsl:when test="$type = 'Callback'">Function</xsl:when>
		<xsl:when test="$type = 'document'">Document</xsl:when>
		<xsl:when test="$type = 'Elements'">Element</xsl:when>
		<xsl:when test="$type = 'HTML'">String</xsl:when>
		<xsl:when test="$type = 'Integer'">Number</xsl:when>
		<xsl:when test="$type = 'jQuery object'">jQuery</xsl:when>
		<xsl:when test="$type = 'selector'">Selector</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$type"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
