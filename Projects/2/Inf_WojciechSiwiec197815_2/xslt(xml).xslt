<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" />
    
    <xsl:template match="/">
        <korzonek>
            <ulubione>
                <postacie>
                    <xsl:apply-templates select="//favourites/agent"/>
                </postacie>
                <bronie>
                    <xsl:apply-templates select="//favourites/weapon"/>
                </bronie>
            </ulubione>
            <turnieje>
                <xsl:apply-templates select="//tournaments/tournament"/>
            </turnieje>
        </korzonek>
    </xsl:template>
    
    <xsl:template match="agent">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="weapon">
        <bron>
            <xsl:copy-of select="name"/>
            <skorka>
                <xsl:attribute name="ulepszone">
                    <xsl:value-of select="skin/@upgraded"/>
                </xsl:attribute>
                <xsl:value-of select="skin"/>
            </skorka>
        </bron>
    </xsl:template>
    
    <xsl:template match="tournament">
        <turniej>
            <xsl:for-each select="teams/team">
                <xsl:apply-templates select="(//teams/team[@id=current()/@id])[1]"/>
            </xsl:for-each>
        </turniej>
    </xsl:template>
    
    <xsl:template match="team">
        <xsl:variable name="liczebnosc" select="count(players/player)"/>
        <xsl:if test="$liczebnosc > 0">
            <druzyna>
                <nazwa>
                    <xsl:value-of select="@id"/>
                </nazwa>
                <gracze>
                    <xsl:attribute name="liczebnosc">
                        <xsl:value-of select="$liczebnosc"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="players/player"/>
                </gracze>
            </druzyna>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="player">
        <gracz>
            <xsl:attribute name="doswiadczenie">
                <xsl:value-of select="experience"/>
            </xsl:attribute>
            <nick>
                <xsl:value-of select="username"/>
            </nick>
            <xsl:call-template name="informacje"/>
            <xsl:call-template name="playerRank"/>
        </gracz>
    </xsl:template>
    <xsl:template name="playerRank">
        <xsl:element name="{player_rank}">
            Division: <xsl:value-of select="player_rank/@division"/>
            <xsl:value-of select="/root/ranks/rank[@name=current()/player_rank]/text()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="informacje">
        <informacje>
            <xsl:attribute name="{personal_info/@access}">strict</xsl:attribute>
            <pelne_imie>
                <xsl:value-of select="personal_info/fullname"/>
            </pelne_imie>
            <wiek>
                <xsl:value-of select="personal_info/age"/>
            </wiek>
            <xsl:element name="{server}">
                <xsl:value-of select="personal_info/country"/>
            </xsl:element>
        </informacje>
    </xsl:template>
</xsl:stylesheet>