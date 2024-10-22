<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="1.0">
<xsl:output method="text" />
    <xsl:template match="/">
        <!-- Selecting all the xml elements "e" -->
        <xsl:for-each select="/dictionary/section[@id='main']/e">
            <xsl:apply-templates select="."></xsl:apply-templates>
            <xsl:if test="@lm">
                <xsl:text>;</xsl:text>
                <xsl:call-template name="lemma"></xsl:call-template>
            </xsl:if>
            <xsl:if test="position()!=last()">
                <xsl:text>&#xa;</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <!-- Template for the element "i" -->
    <xsl:template match="i">
        <xsl:text>(</xsl:text>
        <xsl:for-each select="text()|b|s">
            <xsl:apply-templates select="."></xsl:apply-templates>
        </xsl:for-each>       
        <xsl:text>:</xsl:text>
        <xsl:if test="../@r='RL'">
            <xsl:text disable-output-escaping="yes">&lt;:</xsl:text>
        </xsl:if>
        <xsl:if test="../@r='LR'">
            <xsl:text disable-output-escaping="yes">&gt;:</xsl:text>
        </xsl:if>    
        <xsl:for-each select="text()|b|s">
            <xsl:apply-templates select="."></xsl:apply-templates>
        </xsl:for-each>  
        <xsl:text>)</xsl:text>
    </xsl:template>
    <!-- Template for the element "par" -->
    <xsl:template match="par">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="@n"></xsl:value-of>  
        <xsl:text>]</xsl:text>
    </xsl:template>
    <!-- Template for the attribute "lm" -->
    <xsl:template name="lemma">
        <xsl:text> # </xsl:text>
        <xsl:value-of select="@lm"></xsl:value-of> 
        <xsl:if test="@a">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="@a"></xsl:value-of>  
            <xsl:text>)</xsl:text>
        </xsl:if>
    </xsl:template>
    <!-- Template for the element "p" -->
    <xsl:template match="p">
        <xsl:text>(</xsl:text>
        <xsl:if test="l">
            <xsl:call-template name="lorr">
                <xsl:with-param name="currnode" select="l"></xsl:with-param>
            </xsl:call-template>
        </xsl:if> 
        <xsl:text>:</xsl:text>
        <xsl:if test="r">     
            <xsl:if test="../@r='RL'">
                <xsl:text disable-output-escaping="yes">&lt;:</xsl:text>
            </xsl:if>
            <xsl:if test="../@r='LR'">
                <xsl:text disable-output-escaping="yes">&gt;:</xsl:text>
            </xsl:if> 
            <xsl:if test="r/g">
                <xsl:text>#</xsl:text>
                <xsl:call-template name="lorr">  
                    <xsl:with-param name="currnode" select="r/g"></xsl:with-param>
                </xsl:call-template> 
            </xsl:if>
            <xsl:if test="not(r/g)">
                <xsl:call-template name="lorr">  
                    <xsl:with-param name="currnode" select="r"></xsl:with-param>
                </xsl:call-template> 
            </xsl:if>
        </xsl:if> 
        <xsl:text>)</xsl:text>
    </xsl:template>
    <!-- Template for the element "s" -->
    <xsl:template match="s">
        <xsl:text disable-output-escaping="yes">&lt;</xsl:text>
        <xsl:value-of select="@n"></xsl:value-of>  
        <xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:if test="ancestor::p | parent::i">
	 <xsl:value-of select="."></xsl:value-of>
        </xsl:if>
    </xsl:template>
    <!-- Template for the element "b" -->
    <xsl:template match="b">
        <xsl:text>_</xsl:text>
    </xsl:template>
    <xsl:template name="lorr">
        <xsl:param name="currnode"></xsl:param>
        <xsl:for-each select="$currnode/text()|$currnode/b|$currnode/s">
            <xsl:apply-templates select="."></xsl:apply-templates>
        </xsl:for-each>
    </xsl:template>
    <!-- Template for the element "g" -->
</xsl:stylesheet>
