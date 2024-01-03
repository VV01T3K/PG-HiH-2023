<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
    >
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <style>
                    .radiant { color: gold; }
                    .high-experience { font-weight: bold; }
                </style>
            </head>
            <body>
                <xsl:for-each select="valorant_state/teams/team">
                    <xsl:call-template name="TeamDetails"/>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template name="TeamDetails">
        <h2><xsl:value-of select="name"/></h2>
        <table border="1">
            <tr>
                <th>Username</th>
                <th>Rank</th>
                <th>Server</th>
                <th>Experience</th>
            </tr>
            <xsl:for-each select="players/player">
                <xsl:sort select="experience" data-type="number" order="descending"/>
                <xsl:call-template name="PlayerDetails"/>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <xsl:template match="valorant_state/teams/team">
        <h2><xsl:value-of select="name"/></h2>
        <table border="1">
            <tr>
                <th>Username</th>
                <th>Rank</th>
                <th>Server</th>
                <th>Experience</th>
            </tr>
            <xsl:for-each select="players/player">
                <xsl:sort select="experience" data-type="number" order="descending"/>
                <xsl:call-template name="PlayerDetails"/>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <xsl:template name="PlayerDetails">
        <xsl:variable name="player_rank" select="player_rank"/>
        <xsl:variable name="experience" select="experience"/>
        <tr>
            <td><xsl:value-of select="username"/></td>
            <td><xsl:value-of select="$player_rank"/></td>
            <td><xsl:value-of select="server"/></td>
            <td>
                <xsl:choose>
                    <xsl:when test="$experience > 1000">
                        <span class="high-experience"><xsl:value-of select="format-number($experience, '#,###')"/></span>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="format-number($experience, '#,###')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="player/@id">
        <!-- This template matches the 'id' attribute of 'player' elements -->
    </xsl:template>
    
</xsl:stylesheet>