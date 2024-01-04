<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html"/>
    
    <xsl:variable name="currentDate" select="'2021-09-12'"/>
    
    <xsl:variable name="RomanNumerals">
        <numeral value="1" roman="I"/>
        <numeral value="2" roman="II"/>
        <numeral value="3" roman="III"/>
        <numeral value="4" roman="IV"/>
        <numeral value="5" roman="V"/>
        <numeral value="6" roman="VI"/>
        <numeral value="7" roman="VII"/>
        <numeral value="8" roman="VIII"/>
        <numeral value="9" roman="IX"/>
        <numeral value="10" roman="X"/>
    </xsl:variable>
    
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8" />
                <title>Hypertext hypermedia</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" href="Static/style.css" />
            </head>
            <body>
                <xsl:apply-templates select="valorant_state"/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="valorant_state">
        <h1>Valorant State</h1>
        <p>Current date: <xsl:value-of select="$currentDate"/></p>
        <section class='ranks'>
            <xsl:apply-templates select="ranks"/>
        </section>
        <section class='teams'>
            <xsl:apply-templates select="teams"/>
        </section>
        <section class='tournaments'>
            <xsl:apply-templates select="tournaments"/>
        </section>
    </xsl:template>
    
    <xsl:template match="ranks">
        <h2>Ranks</h2>
        <div>
            <xsl:for-each select="rank">
                <xsl:sort select="playerbase_percent" data-type="number" order="descending"/>
                <div>
                    <h3><xsl:number value="position()"/>. <xsl:value-of select="name"/></h3>
                    <xsl:choose>
                        <xsl:when test="contains(divisions, ' ')">
                            <xsl:variable name="first" select="substring-before(divisions, ' ')"/>
                            <xsl:variable name="rest" select="substring-after(divisions, ' ')"/>
                            <xsl:variable name="second" select="substring-before($rest, ' ')"/>
                            <xsl:variable name="third" select="substring-after($rest, ' ')"/>
                            <p>Divisions: | <xsl:value-of select="concat($first, ' | ', $second, ' | ', $third)"/> |</p>
                        </xsl:when>
                        <xsl:otherwise>
                            <p>Divisions: | <xsl:value-of select="divisions"/> |</p>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="name='Radiant'">
                            <img class="dark_background" src="{image/@src}" alt="{image}"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <img src="{image/@src}" alt="{image}"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <p>Playerbase percent: <xsl:value-of select="format-number(playerbase_percent, '##.00')"/>%</p>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template match="teams">
        <h2>Teams</h2>
        <div>
            <xsl:apply-templates select="team[players/player[@active='yes']]"/>
        </div>
    </xsl:template>
    
    <xsl:template match="team">
        <div>
            <h3><xsl:value-of select="name"/></h3>
            <xsl:apply-templates select="players/player[@active='yes']"/>
            <xsl:apply-templates select="players/player[@active='no']"/>
        </div>
    </xsl:template>
    
    <xsl:template match="player[@active='no']">
        <div>
            <xsl:attribute name="data-active">
                <xsl:value-of select="@active"/>
            </xsl:attribute>
            <h4>Inactive: <xsl:value-of select="username"/></h4>
            <p>Rank: <xsl:value-of select="player_rank"/></p>
            <p>Server: <xsl:value-of select="server"/></p>
        </div>
    </xsl:template>
    
    <xsl:template match="player[@active='yes']">
        <xsl:call-template name="displayPlayer"/>
    </xsl:template>
    
    <xsl:template name="displayPlayer">
        <div>
            <h4><xsl:number value="position()"/>. <xsl:value-of select="username"/></h4>
            <p>Rank: <xsl:value-of select="player_rank"/></p>
            <p>Server: <xsl:value-of select="server"/></p>
            <p>Experience: <xsl:value-of select="experience"/></p>
            <xsl:apply-templates select="socials"/>
            <xsl:choose>
                <xsl:when test="personal_info/@access='free'">
                    <p>Personal Info:</p>
                    <table border="1">
                        <tr>
                            <th>Full Name</th>
                            <th>Age</th>
                            <th>Country</th>
                        </tr>
                        <xsl:apply-templates select="personal_info"/>
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <p>Personal Info: Information not available</p>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:template match="personal_info">
        <tr>
            <td><xsl:value-of select="fullname"/></td>
            <td><xsl:value-of select="age"/></td>
            <td><xsl:value-of select="country"/></td>
        </tr>
    </xsl:template>
    
    <xsl:template match="socials">
        <xsl:apply-templates select="link"/>
    </xsl:template>
    
    <xsl:template match="link">
        <p><a href="{@url}">
                <xsl:value-of select="."/>
            </a></p>
    </xsl:template>
    
    
    <xsl:template match="tournament[prize_pool>5000.00]">
        <div>
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="translate(date/start, '-', '') &gt; translate($currentDate, '-', '')">yellow</xsl:when>
                    <xsl:when test="translate(date/start, '-', '') &lt;= translate($currentDate, '-', '') and translate(date/end, '-', '') &gt;= translate($currentDate, '-', '')">green</xsl:when>
                    <xsl:otherwise>red</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <h3>
                <xsl:value-of select="name/text()"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="document('')/xsl:stylesheet/xsl:variable[@name='RomanNumerals']/numeral[@value=current()/name/edition]/@roman"/>
            </h3>
            <p>Location: <xsl:value-of select="location"/></p>
            <p>Start date: <xsl:value-of select="date/start"/></p>
            <p>End date: <xsl:value-of select="date/end"/></p>
            <p>Prize pool: <xsl:value-of select="concat(format-number(prize_pool, '###,###.00'), ' ', @currency)"/></p>
        </div>
    </xsl:template>
    
</xsl:stylesheet>