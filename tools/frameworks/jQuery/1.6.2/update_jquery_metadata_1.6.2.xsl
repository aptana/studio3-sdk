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

		<!-- Uncomment type-maps once the updated schema is out in the wild
		<type-maps>
			<type-map source-type="jQuery" destination-type="Function&lt;jQuery&gt;:jQuery"/>
		</type-maps>
		-->

		<!-- Promise Object -->
		<xsl:variable name="classNamePrefixDeferred" select="concat('deferred', '.')"/>
		<class type="Promise" superclass="Object">
			<methods>
				<xsl:apply-templates select="/api/entries/entry[@type='method' and (@name='deferred.done' or @name='deferred.fail' or @name='deferred.isResolved' or @name='deferred.isRejected' or @name='deferred.promise' or @name='deferred.then' or @name='deferred.always' or @name='deferred.pipe')]" mode="method">
					<xsl:with-param name="className" select="Deferred"/>
				</xsl:apply-templates>
			</methods>
		</class>

		<!-- Deferred Object -->
		<class type="Deferred" superclass="Object">
			<methods>
				<xsl:apply-templates select="/api/entries/entry[@type='method' and starts-with(@name, $classNamePrefixDeferred)]" mode="method">
					<xsl:with-param name="className" select="Deferred"/>
				</xsl:apply-templates>
			</methods>
		</class>

		<!-- jqXHR Object -->
	    <class type="jqXHR" superclass="Promise" visibility="basic">
	        <description>Object that transfers data between a web client and a remote web server.</description>
	        <properties>
	            <property name="readyState" type="Number" access="read" visibility="basic">
	                <description>Returns the current state of an object. Valid values are 0=uninitialized, 1=open, 2=sent, 3=receiving, 4=loaded.</description>
	            </property>
	            <property name="responseText" type="String" access="read" visibility="basic">
	                <description>Response formatted as a string.</description>
	            </property>
	            <property  name="responseXML" type="Document" access="read" visibility="basic">
	                <description>Response formatted as an XML document.</description>
	            </property>
	            <property name="status" type="Number" access="read" visibility="basic">
	                <description>Status of the Response. (e.g. 200="OK", 404="Not Found", etc.)</description>
	            </property>
	            <property name="statusText" type="String" access="read" visibility="basic">
	                <description>Response text corresonding to status (e.g. "OK", "Not Found", etc.)</description>
	            </property>
	        </properties>
	        <methods>
	            <method name="overrideMimeType">
	                <description>May be used in the beforeSend() callback function, for example, to modify the response content-type header.</description>
	                <parameters>
	                    <parameter name="type" type="String" usage="required">
	                        <description>String representing the mime type.</description>
	                    </parameter>
	                </parameters>
	                <return-types>
	                    <return-type type="void"/>
	                </return-types>
	                <example/>
	                <remarks>Although currently recognized by most browsers, the XMLHttpRequest object will be part of the HTML DOM Level 3 specification.</remarks>
	            </method>
	            <method name="abort">
	                <description>Cancels the current request.</description>
	                <return-types>
	                    <return-type type="void"/>
	                </return-types>
	                <example/>
	                <remarks>Although currently recognized by most browsers, the XMLHttpRequest object will be part of the HTML DOM Level 3 specification.</remarks>
	            </method>
	            <method name="getAllResponseHeaders">
	                <description>Returns all HTTP headers as a single string.</description>
	                <return-description>Returns all HTTP headers as a single string.</return-description>
	                <return-types>
	                    <return-type type="String"/>
	                </return-types>
	                <example/>
	                <remarks>Although currently recognized by most browsers, the XMLHttpRequest object will be part of the HTML DOM Level 3 specification.</remarks>
	            </method>

	            <method name="getResponseHeader">
	                <description>Returns the value of the specified HTTP header.</description>
	                <return-description>Returns the value of the specified HTTP header.</return-description>
	                <parameters>
	                    <parameter name="header" type="String" usage="required">
	                        <description>Name of the HTTP header.</description>
	                    </parameter>
	                </parameters>
	                <return-types>
	                    <return-type type="String"/>
	                </return-types>
	                <example/>
	                <remarks>Although currently recognized by most browsers, the XMLHttpRequest object will be part of the HTML DOM Level 3 specification.</remarks>
	            </method>
	            <method name="setRequestHeader">
	                <description>Sets a header and a value for the request.</description>
	                <parameters>
	                    <parameter name="header" type="String, Document" usage="required">
	                        <description>Name of the header.</description>
	                    </parameter>
	                    <parameter name="value" type="String, Document" usage="required">
	                        <description>Value of the header.</description>
	                    </parameter>
	                </parameters>
	                <return-types>
	                    <return-type type="void"/>
	                </return-types>
	                <exceptions>
	                    <exception type="DOMException">
	                        <description>Throws an UNKNOWN_ERR error.</description>
	                    </exception>
	                </exceptions>
	                <example/>
	                <remarks>Although currently recognized by most browsers, the XMLHttpRequest object will be part of the HTML DOM Level 3 specification.</remarks>
	            </method>
	            <method name="statusCode">
	                <description>Invoke status-code-specific callbacks. If the request is successful, the status code functions take the same parameters as the success callback; if it results in an error, they take the same parameters as the error callback.</description>
	                <parameters>
	                    <parameter name="map" type="Object" usage="required">
	                        <description>A map of numeric HTTP codes and functions to be called when the response has the corresponding code.</description>
	                    </parameter>
	                </parameters>
	                <return-types>
	                    <return-type type="void"/>
	                </return-types>
	                <example/>
	                <remarks/>
	            </method>
	            <method name="success">
	                <description></description>
	                <parameters>
	                	<parameter name="callback" type="Function" usage="required"></parameter>
	                </parameters>
	                <return-types>
	                    <return-type type="jqXHR"/>
	                </return-types>
	                <example/>
	                <remarks/>
	            </method>
	            <method name="error">
	                <description></description>
	                <parameters>
	                	<parameter name="callback" type="Function" usage="required"></parameter>
	                </parameters>
	                <return-types>
	                    <return-type type="jqXHR"/>
	                </return-types>
	                <example/>
	                <remarks/>
	            </method>
	            <method name="complete">
	                <description></description>
	                <parameters>
	                	<parameter name="callback" type="Function" usage="required"></parameter>
	                </parameters>
	                <return-types>
	                    <return-type type="jqXHR"/>
	                </return-types>
	                <example/>
	                <remarks/>
	            </method>
	            <method name="send">
	                <description></description>
	                <parameters/>
	                <return-types>
	                    <return-type type="void"/>
	                </return-types>
	                <example/>
	                <remarks/>
	            </method>
	        </methods>
	        <example/>
	        <remarks>Although currently recognized by most browsers, the XMLHttpRequest object will be part of the HTML DOM Level 3 specification.</remarks>
	    </class>

		<!-- jQuery Object -->
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
	            <method name="Deferred" visibility="basic">
			        <parameters>
			          <parameter name="function" type="Function" usage="optional">
			            <description>An optional function which is called just before the constructor returns and is passed the constructed deferred object as both the this object and as the first argument to the function.</description>
			          </parameter>
			        </parameters>
			        <return-types>
			          <return-type type="Deferred"/>
			        </return-types>
			        <description>A chainable utility object that can register multiple callbacks into callback queues, invoke callback queues, and relay the success or failure state of any synchronous or asynchronous function.</description>
	            </method>

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
