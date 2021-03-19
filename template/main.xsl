<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:date="http://exslt.org/dates-and-times"
                extension-element-prefixes="date">
    <xsl:param name="title">Currency conversion</xsl:param>
    <xsl:template match="*">
        <html 	xmlns="http://www.w3.org/1999/xhtml" 		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 		xsi:schemaLocation="http://www.w3.org/MarkUp/SCHEMA/xhtml11.xsd"      	xml:lang="ru" lang="ru">
            <head>
                <title><xsl:value-of select="$title"/></title>
                <meta name="keywords" content="currency"/>
                <meta name="description" content="This form provides currency conversion"/>
                <meta http-equiv="Content-Type" content="text/html; charset=CP1251"/>
                <meta http-equiv="Content-Language" content="RU"/>
                <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=5, minimum-scale=1, user-scalable=yes"/>
                <meta name="theme-color" content="#101030"/>
                <link href="/css/default.css" rel="stylesheet" type="text/css"/>
                <script type="text/javascript" language="javascript" src="/js/common.js"></script>
            </head>
            <body>
                <header>
                    <h1><xsl:value-of select="$title"/></h1>
                </header>
                <main>
                    <aside>
                    </aside>
                    <section>
                        <p>Select currency pairs and its amount.</p>
                        <ul>
                            <li>
                                <label for="amount">Change</label>
                                <input type="text" value="1" id="amount"/>
                                <select id="source">
                                    <option value="0" currency="1">RUB</option>
                                    <xsl:apply-templates select="Valute" mode="selector"/>
                                </select>
                            </li>
                            <li>
                                <label for="result">Result</label>
                                <input type="text" value="" id="result" disabled="disabled"/>
                                <select id="target">
                                    <option value="0" currency="1">RUB</option>
                                    <xsl:apply-templates select="Valute" mode="selector"/>
                                </select>
                                <input type="hidden" disabled="disabled" id="ratio"/>
                            </li>
                        </ul>
                    </section>
                </main>
                <footer>
                </footer>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="Valute" mode="selector">
        <option value="{NumCode}" currency="{Value}"><xsl:value-of select="CharCode"/></option>
    </xsl:template>
</xsl:stylesheet>