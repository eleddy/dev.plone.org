<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dv="http://openplans.org/deliverance" xmlns:exsl="http://exslt.org/common" xmlns:xhtml="http://www.w3.org/1999/xhtml" version="1.0" exclude-result-prefixes="exsl dv xhtml">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes" media-type="text/html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

    <xsl:template match="/">

        <!-- Pass incoming content through initial-stage filter. -->
        <xsl:variable name="initial-stage-rtf">
            <xsl:apply-templates select="/" mode="initial-stage"/>
        </xsl:variable>
        <xsl:variable name="initial-stage" select="exsl:node-set($initial-stage-rtf)"/>

        <!-- Now apply the theme to the initial-stage content -->
        <xsl:variable name="themedcontent-rtf">
            <xsl:apply-templates select="$initial-stage" mode="apply-theme"/>
        </xsl:variable>
        <xsl:variable name="content" select="exsl:node-set($themedcontent-rtf)"/>

        <!-- We're done, so generate some output by passing 
            through a final stage. -->
        <xsl:apply-templates select="$content" mode="final-stage"/>

    </xsl:template>

    <!-- 
    
        Utility templates
    -->
    
    <xsl:template match="node()|@*" mode="initial-stage">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" mode="initial-stage"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="/" mode="apply-theme">
        <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"><head><meta http-equiv="Content-type" content="text/html; charset=utf-8"/><xsl:choose><xsl:when test="/html/head/title"><xsl:copy-of select="/html/head/title"/></xsl:when><xsl:otherwise><title>Plone Development</title></xsl:otherwise></xsl:choose><link rel="alternate" type="application/rss+xml" href="http://feeds.plone.org/plonenews" title="Plone News"/><link rel="alternate" type="application/rss+xml" href="http://feeds.plone.org/plonereleases" title="Plone Releases"/><link rel="alternate" type="application/rss+xml" href="http://feeds.plone.org/ploneevents" title="Upcoming Plone Events"/><link rel="alternate" type="application/rss+xml" href="http://feeds.plone.org/ploneaddons" title="Latest Plone &amp; Add-on Releases"/><link rel="alternate" type="application/rss+xml" href="http://feeds.plone.org/plonetraining" title="Upcoming Plone Training"/><link rel="alternate" type="application/rss+xml" href="http://feeds.plone.org/ploneblogs" title="Plone Blogs"/><link rel="stylesheet" href="http://plone.org/plone.css" type="text/css" media="screen"/><xsl:comment>[if IE]&gt;
        &lt;style type="text/css" media="all"&gt;@import url(/ie.css);&lt;/style&gt;
    &lt;![endif]</xsl:comment><link rel="stylesheet" href="http://dev.plone.org/plone/chrome/common/css/diff.css" type="text/css"/><link rel="stylesheet" href="http://dev.plone.org/plone/chrome/common/css/code.css" type="text/css"/><link rel="stylesheet" href="http://dev.plone.org/plone-trac.css" type="text/css"/><xsl:comment>[if IE]&gt;&lt;style type="text/css" media="all"&gt;@import url(/ie.css);&lt;/style&gt;&lt;![endif]</xsl:comment><xsl:comment>[if lte IE 6]&gt;&lt;script src="/ie6warn.js" type="text/javascript"&gt;&lt;/script&gt;&lt;![endif]</xsl:comment><xsl:copy-of select="/html/head/script"/><xsl:copy-of select="/html/head/style"/><xsl:copy-of select="/html/head/link[@type!=&quot;text/css&quot;]"/></head><body>

<div id="outer-wrapper"><div id="inner-wrapper">

<div id="nav">

	<form id="search" name="searchform" action="http://dev.plone.org/plone/search" method="get"> 
		<input id="search-site" name="q" type="text" title="Search this site&#x2026;" accesskey="4" class="inputLabel" size="15"/></form>

	<div id="user"><xsl:choose><xsl:when test="//*[@id=&quot;metanav&quot;]/ul/li[@class=&quot;first&quot;]"><xsl:copy-of select="//*[@id=&quot;metanav&quot;]/ul/li[@class=&quot;first&quot;]"/></xsl:when><xsl:otherwise>
		<a href="">Bruce Wayne ▼</a>
	</xsl:otherwise></xsl:choose></div>

	<ul id="main-nav" class="navigation"><li><a href="http://plone.org">Home</a></li><li><a href="http://plone.org/products">Downloads</a></li><li><a href="http://plone.org/documentation">Documentation</a></li><li class="selected"><a href="http://dev.plone.org/plone">Get Involved</a></li><li><a href="http://plone.org/foundation">Plone Foundation</a></li><li><a href="http://plone.org/support">Support</a></li>
	</ul><ul id="sub-nav" class="navigation"><xsl:choose><xsl:when test="//*[@id=&quot;mainnav&quot;]/ul"><xsl:copy-of select="//*[@id=&quot;mainnav&quot;]/ul"/></xsl:when><xsl:otherwise><li><a href="" class="selected">Topics</a></li><li><a href="">Demo Movies</a></li><li><a href="">Frequently Asked Questions</a></li><li><a href="">Error Reference</a></li><li><a href=""><acronym title="Application Programming Interfaces">APIs</acronym></a></li><li><a href="" style="color: #666">Recent Updates</a></li>
	</xsl:otherwise></xsl:choose></ul></div>

<div id="content-wrapper">
	<div id="ctxtnav"><xsl:choose><xsl:when test="//*[@id=&quot;ctxtnav&quot;]/ul"><xsl:copy-of select="//*[@id=&quot;ctxtnav&quot;]/ul"/></xsl:when><xsl:otherwise/></xsl:choose></div>
	<xsl:choose><xsl:when test="//*[@id=&quot;content&quot;]"><xsl:copy-of select="//*[@id=&quot;content&quot;]"/></xsl:when><xsl:otherwise><div id="content">

	<xsl:comment> Content goes here </xsl:comment>

	</div></xsl:otherwise></xsl:choose>
</div>

</div><xsl:comment> end inner-wrapper </xsl:comment>
<div id="push"/>
</div> <xsl:comment> end outer-wrapper </xsl:comment>

<div id="footer-wrapper">
	<div id="footer-gradient"/>
	<div id="footer">
		<a id="footer-logo" href="http://plone.org" title="Plone CMS, the open source content management system"/>
		<p>The Plone<sup>®</sup> CMS/WCM is © 2000–2009 the Plone Foundation and friends. Hosted by <a href="http://osuosl.org/" style="color: white">OSU Open Source Lab</a>.</p>
		<p>Plone<sup>®</sup> and the Plone logo are registered trademarks of the Plone Foundation. You’re looking good today.</p>


		<div id="sitemap">
			<xsl:comment> &lt;dl&gt;
				&lt;dt&gt;&lt;a href=""&gt;Plone for…&lt;/a&gt;&lt;/dt&gt;
				&lt;dd&gt;&lt;a href=""&gt;Small/Medium Business &lt;/a&gt;&lt;/dd&gt;
				&lt;dd&gt;&lt;a href=""&gt;Enterprise            &lt;/a&gt;&lt;/dd&gt;
				&lt;dd&gt;&lt;a href=""&gt;Non-profits           &lt;/a&gt;&lt;/dd&gt;
				&lt;dd&gt;&lt;a href=""&gt;Government            &lt;/a&gt;&lt;/dd&gt;
				&lt;dd&gt;&lt;a href=""&gt;Education             &lt;/a&gt;&lt;/dd&gt;
				&lt;dd&gt;&lt;a href=""&gt;Science               &lt;/a&gt;&lt;/dd&gt;
				&lt;dd&gt;&lt;a href=""&gt;Media &amp;amp; Publishing&lt;/a&gt;&lt;/dd&gt;
			&lt;/dl&gt; </xsl:comment>

			<dl><dt><a href="http://plone.org/products">Downloads</a></dt>
				<dd><a href="http://plone.org/download">Get Plone</a></dd>
				<dd><a href="http://plone.org/products?getCategories=themes">Themes</a></dd>
				<dd><a href="http://plone.org/products?getCategories=dev">Development tools</a></dd>
				<dd><a href="http://plone.org/products?getCategories=auth">Authentication</a></dd>
				<dd><a href="http://plone.org/products">…and more.</a></dd>
			</dl><dl><dt><a href="http://plone.org/documentation">Documentation</a></dt>
				<dd><a href="http://plone.org/documentation/faq/">FAQs</a></dd>
				<dd><a href="http://plone.org/documentation/movies/">Tutorial videos</a></dd>
				<dd><a href="http://plone.org/documentation/manual">Manuals</a></dd>
				<dd><a href="http://plone.org/documentation/books">Books</a></dd>
				<xsl:comment> &lt;dd&gt;&lt;a href=""&gt;Knowledge Base&lt;/a&gt;&lt;/dd&gt; </xsl:comment>
				<dd><a href="http://plone.org/documentation/error">Error Reference</a></dd>
				<xsl:comment> &lt;dd&gt;&lt;a href=""&gt;Module documentation&lt;/a&gt;&lt;/dd&gt; </xsl:comment>
				<dd><a href="http://plone.net/sites">Sites using Plone</a></dd>
			</dl><dl><dt><a href="http://dev.plone.org/plone">Developers</a></dt>
				<dd><a href="http://dev.plone.org/plone/roadmap">Roadmap</a></dd>
				<dd><a href="http://dev.plone.org/plone">Report bugs in Plone</a></dd>
				<dd><a href="http://dev.plone.org/plone.org">Report website issues</a></dd>
				<dd><a href="http://dev.plone.org/plone/timeline">Latest changes</a></dd>
				<dd><a href="http://dev.plone.org/plone/browser">Browse source</a></dd>
				<dd><a href="http://dev.plone.org/plone">Contribute to Plone</a></dd>
				<dd><a href="http://planet.plone.org">Community blogs</a></dd>
			</dl><dl><dt><a href="http://plone.org/foundation">Plone Foundation</a></dt>
				<dd><a href="http://plone.org/foundation/foundation-donations">Donate</a></dd>
				<dd><a href="http://plone.org/foundation/donors">Sponsors</a></dd>
				<dd><a href="http://plone.org/foundation/meetings/minutes">Meeting minutes</a></dd>
				<dd><a href="http://plone.org/team/FoundationBoard">Current board</a></dd>
				<dd><a href="http://plone.org/foundation/members">Foundation members</a></dd>
				<dd><a href="http://plone.org/foundation/membership">Apply for membership</a></dd>
				<dd><a href="http://plone.org/foundation#contact">Contact</a></dd>
			</dl><dl><dt><a href="http://plone.org/support">Support</a></dt>
				<dd><a href="http://plone.net/providers">Commercial services</a></dd>
				<dd><a href="http://plone.org/support/chat">Chat room</a></dd>
				<dd><a href="http://plone.org/support/forums">Forums</a></dd>
				<dd><a href="http://plone.org/support/for">Sector-specific forums</a></dd>
				<dd><a href="http://plone.org/support/region">Region-specific forums</a></dd>
				<dd><a href="http://plone.org/support/local-user-groups">Local user groups</a></dd>
				<dd><a href="http://plone.org/events/training">Training</a></dd>
			</dl></div>

	</div>
</div>


<script type="text/javascript"><xsl:variable name="tag_text"> 
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</xsl:variable><xsl:value-of select="$tag_text" disable-output-escaping="yes"/></script><script type="text/javascript"><xsl:variable name="tag_text"> 
var pageTracker = _gat._getTracker("UA-1907133-2");
pageTracker._trackPageview();
</xsl:variable><xsl:value-of select="$tag_text" disable-output-escaping="yes"/></script></body></html>
    </xsl:template>
    <xsl:template match="style|script|xhtml:style|xhtml:script" priority="5" mode="final-stage">
        <xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*" mode="final-stage"/>
            <xsl:value-of select="text()" disable-output-escaping="yes"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="*" priority="3" mode="final-stage">
        <!-- Move elements without a namespace into 
        the xhtml namespace. -->
        <xsl:choose>
            <xsl:when test="namespace-uri(.)">
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()" mode="final-stage"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:apply-templates select="@*|node()" mode="final-stage"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="node()|@*" priority="1" mode="final-stage">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" mode="final-stage"/>
        </xsl:copy>
    </xsl:template>

    <!-- 
    
        Extra templates
    -->
    
</xsl:stylesheet>
