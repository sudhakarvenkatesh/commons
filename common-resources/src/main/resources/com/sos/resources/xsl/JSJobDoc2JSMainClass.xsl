<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:jobdoc="http://www.sos-berlin.com/schema/scheduler_job_documentation_v1.1"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="jobdoc">

	<xsl:output method="text" encoding="iso-8859-1" indent="no" />

<xsl:param name="Category" required="no" as="xs:string"/>
<xsl:param name="ClassNameExtension" required="yes" as="xs:string"/>
<xsl:param name="ExtendsClassName"  required="yes" as="xs:string"/>
<xsl:param name="WorkerClassName"  required="yes" as="xs:string"/>
<xsl:param name="XMLDocuFilename"  required="yes" as="xs:string"/>
<xsl:param name="XSLTFilename"  required="yes" as="xs:string"/>
<xsl:param name="timestamp" required="yes" as="xs:string"/> 
<xsl:param name="package_name" required="yes" as="xs:string"/> 
<xsl:param name="standalone" required="yes" as="xs:string"/> 
<xsl:param name="sourcetype" required="yes" as="xs:string"/> 
<xsl:param name="keywords" required="no" as="xs:string"/>
<xsl:param name="default_lang" required="yes" as="xs:string"/>


	<xsl:variable name="nl" select="'&#xa;'" />
	<xsl:template match="//jobdoc:description">
		<xsl:apply-templates />
	</xsl:template>


	<xsl:template match="jobdoc:job">
	<!--  the name of the class is derived from the attribute name of the job-tac -->
		<xsl:variable name="class_name">
			<xsl:value-of select="concat(./@name, $ClassNameExtension)" />
		</xsl:variable>

		<xsl:variable name="class_title">
			<xsl:value-of select="./@title" />
		</xsl:variable>

package <xsl:value-of select="$package_name" />;

import org.apache.log4j.Logger;
import com.sos.JSHelper.Basics.JSToolBox;

public class <xsl:value-of select="$class_name" /> extends <xsl:value-of select="$ExtendsClassName" /> {
	protected <xsl:value-of select="$WorkerClassName" />Options	objOptions = null;
	private static final String CLASSNAME = "<xsl:value-of select="$class_name" />"; 
	private static final Logger LOGGER = Logger.getLogger(<xsl:value-of select="$class_name" />.class);
 
	public final static void main(String[] pstrArgs) {
		final String METHODNAME = CLASSNAME + "::Main"; 
		LOGGER.info("<xsl:value-of select="$WorkerClassName" /> - Main"); 
		try {
			<xsl:value-of select="$WorkerClassName" /> objM = new <xsl:value-of select="$WorkerClassName" />();
			<xsl:value-of select="$WorkerClassName" />Options objO = objM.getOptions();
			objO.commandLineArgs(pstrArgs);
			objM.execute();
		} catch (Exception e) {
			System.err.println(METHODNAME + ": " + "Error occured ..." + e.getMessage()); 
			LOGGER.error(e.getMessage(), e);
			int intExitCode = 99;
			LOGGER.error(String.format("JSJ-E-105: %1$s - terminated with exit-code %2$d", METHODNAME, intExitCode), e);		
			System.exit(intExitCode);
		}
		LOGGER.info(String.format("JSJ-I-106: %1$s - ended without errors", METHODNAME));		
	}

}  
</xsl:template>

	<xsl:template match="text()">
		<!-- 	<xsl:value-of select="normalize-space(.)"/> -->
	</xsl:template>


</xsl:stylesheet>