<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:jobdoc="http://www.sos-berlin.com/schema/scheduler_job_documentation_v1.1"
	xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:java="http://xml.apache.org/xslt/java"
	xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:functx="http://www.functx.com"
	exclude-result-prefixes="jobdoc xhtml java">

	<xsl:output method="text" encoding="iso-8859-1" indent="no" />

	<xsl:param name="timestamp" required="yes" as="xs:string" />
	<xsl:param name="package_name" required="yes" as="xs:string" />
	<xsl:param name="XSLTFilename" required="yes" as="xs:string" />
	<xsl:param name="XMLDocuFilename" required="yes" as="xs:string" />
	<xsl:param name="keywords" required="no" as="xs:string" />
	<xsl:param name="Category" required="no" as="xs:string" />
	<xsl:param name="default_lang" required="yes" as="xs:string" />

	<xsl:variable name="nl" select="'&#xa;'" />

	<xsl:template match="/">
		<xsl:apply-templates select="jobdoc:description" />

	</xsl:template>
	<xsl:template match="//description">
		<xsl:apply-templates />
	</xsl:template>


	<xsl:template match="//jobdoc:description">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="jobdoc:job">
		<xsl:variable name="real_class_name">
			<xsl:value-of select="concat(./@name, 'Options')" />
		</xsl:variable>


		<xsl:variable name="class_name">
			<xsl:value-of select="concat('I', ./@name, 'OptionsInterface')" />
		</xsl:variable>

		<xsl:variable name="class_title">
			<xsl:value-of select="concat('Interface for ', ./@title)" />
		</xsl:variable>

		package <xsl:value-of select="$package_name" />;
		import com.sos.JSHelper.Options.*;
/**
* \interface <xsl:value-of select="$class_name" /> - <xsl:value-of select="$class_title" />
*
* \brief
*
* <xsl:copy-of select="//jobdoc/description[lang=$default_lang]" />
*
* see \see <xsl:value-of select="$XMLDocuFilename" /> for (more) details.
*
* \verbatim ;
* mechanicaly created by <xsl:value-of select="$XSLTFilename" />	from http://www.sos-berlin.com at <xsl:value-of select="$timestamp" />
* \endverbatim
*/
public interface 		<xsl:value-of select="$class_name" /> {

<xsl:call-template name="CreateDataElements" />

} // public interface <xsl:value-of select="$class_name" />
	</xsl:template>

	<xsl:template match="jobdoc:configuration">
		<xsl:message>
			jobdoc:configuration reached ...
		</xsl:message>
	</xsl:template>


	<xsl:template match="text()">
		<!-- <xsl:value-of select="normalize-space(.)"/> -->
	</xsl:template>


	<xsl:template match="jobdoc:param">
		<xsl:message>
			<xsl:value-of select="concat('Parameter = ', ./@name)"></xsl:value-of>
		</xsl:message>

		<xsl:choose>
			<xsl:when test="@name and not(@name='') and not(@name='*')">
				<xsl:message>
					..... process param ....
					<xsl:value-of select="concat(@name, ' ', @DataType, ' ', @DefaultValue)"></xsl:value-of>
				</xsl:message>

				<xsl:variable name="title">
					<xsl:value-of
						select="normalize-space(substring(./jobdoc:note[@language=$default_lang and position()=1],2, 80 ))" />
				</xsl:variable>
				<xsl:variable name="descr">
					<xsl:value-of
						select="normalize-space(substring(./jobdoc:note[@language=$default_lang],2, 80 ))" />
				</xsl:variable>

				<xsl:variable name="datatype">
					<xsl:choose>
						<xsl:when test="@data_type and not(@data_type='')">
							<xsl:value-of select="@data_type" />
						</xsl:when>
						<xsl:when test="@DataType and not(@DataType='')">
							<xsl:value-of select="@DataType" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>SOSOptionString</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="initialvalue">
					<xsl:choose>
						<xsl:when test="@default_value and not(@default_value='')">
							<xsl:value-of select="@default_value" />
						</xsl:when>
						<xsl:when test="@DefaultValue and not(@DefaultValue='')">
							<xsl:value-of select="@DefaultValue" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="defaultvalue">
					<xsl:choose>
						<xsl:when test="@default_value and not(@default_value='')">
							<xsl:value-of select="@default_value" />
						</xsl:when>
						<xsl:when test="@DefaultValue and not(@DefaultValue='')">
							<xsl:value-of select="@DefaultValue" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="mandatory">
					<xsl:choose>
						<xsl:when test="@required and not(@required='')">
							<xsl:value-of select="@required" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>false</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="dataclass">
					<xsl:choose>
						<xsl:when test="@DataType and not(@DataType='')">
							<xsl:value-of select="concat('SOSOption', @DataType)" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>SOSOptionString</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

/**
* \brief get<xsl:value-of select="./@name" />:<xsl:value-of select="$title" />
*
* \details
*
<xsl:value-of select="normalize-space(./jobdoc:note[@language=$default_lang]/xhtml:div)" />
*
* \return <xsl:value-of select="$title" />
*
*/
				public abstract <xsl:value-of select="$datatype" />
				<xsl:text> </xsl:text>
				<xsl:value-of select="./@name" />
				() ;

/**
* \brief set				<xsl:value-of select="./@name" />			:			<xsl:value-of select="$title" />
*
* \details
* <xsl:value-of select="normalize-space(./jobdoc:note[@language=$default_lang]/xhtml:div)" />
*
* @param				<xsl:value-of select="concat(./@name, ' : ', $title)" />
*/
public abstract void
<xsl:value-of					select="concat(./@name, ' (', $datatype, ' p_',./@name, ') ;')" />
</xsl:when></xsl:choose>
	</xsl:template>

	<xsl:template match="xi:include" xmlns:xi="http://www.w3.org/2001/XInclude"
		mode="resolve">
		<xsl:for-each select="document(@href)">
			<xsl:apply-templates select="./jobdoc:param" />
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="CreateDataElements">
        <xsl:for-each select="//xi:include">
            <xsl:sort select="./@href" order="ascending" />
            <xsl:apply-templates select="." mode="resolve" />
        </xsl:for-each>
        
		<xsl:for-each select="//jobdoc:param">
			<xsl:sort select="./@name" order="ascending" />
			<xsl:apply-templates select="." />
		</xsl:for-each>
	</xsl:template>


</xsl:stylesheet>