<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="/">
		<html>
			<head>
				<title>Wagenbestand</title>
				<style>
					body {
						font-family: sans-serif;
						font-size: 14px;
					}
					table {
						    border: 1px solid #eeeeee; 
						    width: 100%;
						    padding: 10px;
						    border-spacing: 1px;
						    box-shadow: 0 10px 18px -8px;

					}
					table td {
						padding-left: 10px;
						padding-right: 10px;
						white-space: nowrap;
					}
					table tr:hover {
						background: yellow;
						transition: all .5s;
					}
				</style>
			</head>
			<body>
				<h3>Aktueller Bestand</h3>
				<table>
					<th>ID</th>
					<th>Modell</th>
					<th>Hersteller</th>
					<th>Baujahr</th>
					<th>Erstzulassung</th>
					<th>KM-Stand</th>
					<th>Neuwagen</th>
					<th>Motor</th>
					<th>PS</th>
					<th>Tankfassung</th>
					<th>Antriebsart</th>
					<th>Form</th>
					<th>Bild</th>
					<th>Unfälle</th>
					<xsl:for-each select="//wagen">
						<!-- <xsl:sort select="motor"/> -->
						<!-- <xsl:sort select="baujahr" order="descending"/> -->
						<tr>
							<xsl:if test="position() mod 2 = 0">
       							<xsl:attribute name="bgcolor">#efefef</xsl:attribute>
    						</xsl:if>
							<td>
								<xsl:value-of select="@WagenID" /> 
							</td>
							<td>
								<xsl:value-of select="modell" /> 
							</td>
							<td>
								<xsl:value-of select="hersteller" /> 
							</td>
							<td>
								<xsl:value-of select="baujahr" /> 
							</td>
							<td>
							<xsl:if test="erstzulassung != ''">
								<xsl:value-of select="erstzulassung/day" />.<xsl:value-of select="erstzulassung/month" />.<xsl:value-of select="erstzulassung/year" />
							</xsl:if>
							<xsl:if test="erstzulassung = ''">
								<xsl:attribute name="style">
								    text-align:center;
								    opacity: 0.5;
								</xsl:attribute>
								-
							</xsl:if>
							</td>
							<td>
								<xsl:attribute name="style">
								    text-align:right;
								</xsl:attribute>
								<xsl:value-of select="km" /> 
							</td>
							<td>
								<xsl:if test="neuwagen">
									Neuwagen
  								</xsl:if>
  								<xsl:if test="not(neuwagen)">
									<xsl:attribute name="style">
								    text-align:center;
								    opacity: 0.5;
									</xsl:attribute>
									-
								</xsl:if>
							</td>
							<td>
								<xsl:if test="motor/elektro">
									Elektro
  								</xsl:if>
  								<xsl:if test="motor/verbrennung">
									<xsl:value-of select="motor/verbrennung/@typ" /> 
  								</xsl:if>
							</td>
							<td>
								<xsl:if test="motor/elektro/ps">
									<xsl:value-of select="motor/elektro/ps" /> PS
  								</xsl:if>
  								<xsl:if test="motor/verbrennung/ps">
									<xsl:value-of select="motor/verbrennung/ps" /> PS
  								</xsl:if>
							</td>
							<td>
								<xsl:if test="motor/elektro/akkukapazitaet">
									<xsl:value-of select="motor/elektro/akkukapazitaet" /> kWh
  								</xsl:if>
  								<xsl:if test="motor/verbrennung/tank">
									<xsl:value-of select="motor/verbrennung/tank" /> Liter
  								</xsl:if>
							</td>
							<td>
								<xsl:value-of select="antriebsart/@typ" /> 
							</td>
							<td>
								<xsl:value-of select="karosserieform/@typ" /> 
							</td>
							<td>
								<xsl:value-of select="url" /> 
							</td>
							<td>
								<ul>
								<xsl:if test="unfall">
									<xsl:for-each select="unfall">
											<li>
												<xsl:value-of select="day" />.<xsl:value-of select="month" />.<xsl:value-of select="year" /> - 
												<xsl:value-of select="beschreibung" />
											</li>
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="not(unfall)">
									<xsl:attribute name="style">
								    text-align:center;
								    padding: 0;
								    opacity: 0.5;
									</xsl:attribute>
									keine
								</xsl:if>
								</ul>
							</td>
						</tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
