<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="/">
		<html>
			<head>
				<title>Wagenbestand</title>
			</head>
			<body>
				<h3>Aktueller Bestand</h3>
				<ul>
					<xsl:for-each select="//wagen">
						<li>
							<xsl:value-of select="modell" /> (<xsl:value-of select="hersteller" />) 
						</li>
					</xsl:for-each>
				</ul>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
