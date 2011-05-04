<!--

	@author Kevin Lindsey
    @author Ingo Muschenetz
	
	Convert a Dojo 1.6 api.xml file to the ScriptDoc XML schema. Below is a summary of what this stylesheet transforms:
	
	1. There are no @constructor or @super attributes on method elements, so these were stripped
	2. Method elements that have @constructor attributes are skipped for now. These should probably be converted to constructor elements
	3. All object elements were converted to class elements
	4. There are no @classlike attributes on class elements, so these were stripped
	5. The @type attribute on object meant something different than what the schema defined. These were stripped too
	6. The @location attribute on object was the equivalent of @type on class, so these were converted to @type attributes
	7. A number of @scope attributes were defined but were empty. Those have been changed to "instance"
    7. @scope="normal" and @scope="prototype" attributes were converted to @scope="instance"
	8. A number of @location attributes were defined but were empty. Those have been changed to "Object"
	9. Ignore provides, provide, examples, and example
	
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

<xsl:template match="examples">
	<xsl:copy>
		<xsl:apply-templates select="example" />
	</xsl:copy>
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
			<xsl:apply-templates select="@constructor"/>
			-->
			<xsl:apply-templates select="@name" />
			<xsl:apply-templates select="@scope" />
			<!--
			<xsl:apply-templates select="@private" />
			<xsl:apply-templates select="@privateparent" />
			<xsl:apply-templates select="@tags" />
			-->
			<xsl:apply-templates select="description" />
			<xsl:apply-templates select="examples" />
			<xsl:apply-templates select="parameters" />
			<!--
			<xsl:apply-templates select="provides" />
			<xsl:apply-templates select="resources" />
			-->
			<xsl:apply-templates select="return-description" />
			<xsl:apply-templates select="return-types" />
			<!--
			<xsl:apply-templates select="summary" />
			-->
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
		<xsl:apply-templates select="@classlike"/>
		<xsl:apply-templates select="@location"/>
		<xsl:apply-templates select="@private"/>
		<xsl:apply-templates select="@privateparent"/>
		<xsl:apply-templates select="@superclass"/>
		<xsl:apply-templates select="@tags"/>
		<xsl:apply-templates select="@type"/>
		-->
		<xsl:apply-templates select="@location" />
		<xsl:apply-templates select="@superclass" />
		<xsl:apply-templates select="description" />
		<xsl:apply-templates select="example" />
		<xsl:apply-templates select="methods" />
		<xsl:apply-templates select="mixins" />
		<xsl:apply-templates select="properties" />
		<!--
		<xsl:apply-templates select="parameters" />
		<xsl:apply-templates select="provides" />
		<xsl:apply-templates select="resources" />
		<xsl:apply-templates select="return-description" />
		<xsl:apply-templates select="return-types" />
		<xsl:apply-templates select="summary" />
		-->
	</xsl:element>
</xsl:template>

<xsl:template match="parameter">
	<xsl:copy>
		<xsl:apply-templates select="@name" />
		<xsl:apply-templates select="@type" />
		<xsl:apply-templates select="@usage" />
		<xsl:apply-templates select="summary" />
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
		<!--
		<xsl:apply-templates select="@private" />
		<xsl:apply-templates select="@privateparent" />
		<xsl:apply-templates select="@tags" />
		-->
		<xsl:apply-templates select="summary" />
		<!--
		<xsl:apply-templates select="provides" />
		<xsl:apply-templates select="resources" />
		-->
	</xsl:copy>
</xsl:template>

<xsl:template match="provide">
	<!-- ignore -->
</xsl:template>

<xsl:template match="provides">
	<!-- ignore -->
</xsl:template>

<xsl:template match="resource">
	<!-- ignore -->
</xsl:template>

<xsl:template match="resources">
	<!-- ignore -->
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

<xsl:template match="summary">
	<description>
		<xsl:value-of select="text()"/>
	</description>
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
		<xsl:when test=". = 'normal'">
			<xsl:attribute name="scope">
                <xsl:text>instance</xsl:text>
            </xsl:attribute>
		</xsl:when>
		<xsl:when test=". = 'prototype'">
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
	<!-- NOTE: keeping attribute and value in separate statements so we can show the before and after values for the incoming type -->
	<xsl:variable name="type">
		<xsl:call-template name="fixupTypes">
			<xsl:with-param name="item">
				<xsl:choose>
					<xsl:when test="contains(., '||')">
						<xsl:call-template name="reducePipes">
							<xsl:with-param name="item" select="."/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>

	<xsl:attribute name="type">
		<xsl:value-of select="$type"/>
	</xsl:attribute>
</xsl:template>

<!--
	Remove all repeated pipe symbols
-->
<xsl:template name="reducePipes">
	<xsl:param name="item"/>
	<xsl:choose>
		<xsl:when test="contains($item, '||')">
			<xsl:call-template name="reducePipes">
				<xsl:with-param name="item" select="concat(substring-before($item, '||'), '|', substring-after($item, '||'))"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$item"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--
	Fix all types in a list of types
-->
<xsl:template name="fixupTypes">
	<xsl:param name="item"/>
	<xsl:variable name="result">
		<xsl:choose>
			<xsl:when test="contains($item, '|')">
				<xsl:variable name="first">
					<xsl:call-template name="fixupType">
						<xsl:with-param name="item" select="substring-before($item, '|')"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="rest">
					<xsl:call-template name="fixupTypes">
						<xsl:with-param name="item" select="substring-after($item, '|')"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="concat($first, '|', $rest)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="fixupType">
					<xsl:with-param name="item" select="$item"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<!-- show before and after -->
	<!--xsl:message><xsl:value-of select="concat($item, ' => ', $result, '&#xA;')"/></xsl:message-->

	<xsl:value-of select="$result"/>
</xsl:template>

<!--
	Fix a single type
-->
<xsl:template name="fixupType">
	<xsl:param name="item"/>
	<xsl:variable name="lastChar" select="substring($item, string-length($item))"/>
	<xsl:choose>
		<!--
			Map empty types to Object
		-->
		<xsl:when test="string-length($item) = 0">
           	<xsl:text>Object</xsl:text>
		</xsl:when>

		<!--
			Remove trailing trash characters and further process the result according to the conditions below
		-->
		<xsl:when test="contains(':;,.&quot;', $lastChar)">
			<xsl:call-template name="fixupType">
				<xsl:with-param name="item">
					<xsl:value-of select="substring($item, 1, string-length($item) - 1)"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>

		<!--
			Add missing closing bracket and further process the result according to the conditions below
		-->
		<xsl:when test="$lastChar = '['">
			<xsl:call-template name="fixupType">
				<xsl:with-param name="item">
					<xsl:value-of select="concat($item, ']')"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>

		<!--
			Convert Type[] to Array<Type> and further process the result to cover nested cases
		-->
		<xsl:when test="contains($item, '[]')">
			<xsl:call-template name="fixupType">
				<xsl:with-param name="item">
					<xsl:value-of select="concat('Array&lt;', substring-before($item, '[]'), '&gt;', substring-after($item, '[]'))"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>

		<!--
			The following tests basically map strings to a known type
		-->
		<xsl:when test="$item = 'Boolean: contents? true : false'">
			<xsl:text>Boolean</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'Date or null'">
			<xsl:text>Date</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'new Date(value)'">
			<xsl:text>Date</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'Function(node'">
			<xsl:text>Function</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'attribute-name-string'">
			<xsl:text>String</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'XML string'">
			<xsl:text>String</xsl:text>
		</xsl:when>
		<xsl:when test="starts-with($item, 'String (')">
			<xsl:text>String</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'Integer/Float'">
			<xsl:text>Number</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'Number (integer)'">
			<xsl:text>Number</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'read-only-Number'">
			<xsl:text>Number</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'Whole Number'">
			<xsl:text>Number</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'int {-1,0,1}'">
			<xsl:text>Number</xsl:text>
		</xsl:when>
		<xsl:when test="$item = '-1'">
			<xsl:text>Number</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'integer (either 0, 1, or -1)'">
			<xsl:text>Number</xsl:text>
		</xsl:when>
		<xsl:when test="starts-with($item, 'Number or NaN for ')">
			<xsl:text>Number</xsl:text>
		</xsl:when>
		<xsl:when test="$item = '?'">
			<xsl:text>Object</xsl:text>
		</xsl:when>
		<xsl:when test="$item = &quot;&apos;&apos;&quot;">
			<xsl:text>Object</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'read-only-Object'">
			<xsl:text>Object</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'Set&lt;String&gt;'">
			<xsl:text>Object</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'Hash&lt;String'">
			<xsl:text>Object</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'Widget(dijit.Menu)'">
			<xsl:text>dijit.Menu</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'Channel/resource'">
			<xsl:text>Channel</xsl:text>
		</xsl:when>
		<xsl:when test="$item = 'read-only-SWF'">
			<xsl:text>SWF</xsl:text>
		</xsl:when>
		<xsl:when test="starts-with($item, 'StyleSheet or')">
			<xsl:text>StyleSheet</xsl:text>
		</xsl:when>
		<xsl:when test="starts-with($item, '(in)')">
			<xsl:value-of select="substring($item, 5)"/>
		</xsl:when>
		<xsl:when test="starts-with($item, '(out)')">
			<xsl:value-of select="substring($item, 6)"/>
		</xsl:when>
		<xsl:when test="starts-with($item, '(in|out)')">
			<xsl:value-of select="substring($item, 9)"/>
		</xsl:when>
		<xsl:when test="starts-with($item, 'function(')">
			<xsl:value-of select="concat('Function(', substring($item, 10), ')')"/>
		</xsl:when>

		<!--
			No conversion necessary, so use what we have
		-->
		<xsl:otherwise>
			<xsl:value-of select="$item" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="@*">
	<xsl:copy-of select="." />
</xsl:template>

</xsl:stylesheet>
