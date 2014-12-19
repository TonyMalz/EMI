<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:variable name="test">generate-id(.)=generate-id(key('motor_verbrennung', motor/verbrennung/@typ)[1])</xsl:variable>

	<xsl:key name="antrieb" match="wagen" use="antriebsart/@typ"/>
	<xsl:key name="motor_verbrennung" match="wagen" use="motor/verbrennung/@typ"/>
	<xsl:key name="motor_elektro" match="wagen" use="motor/elektro"/>
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
					table th {
						padding:10px;
						white-space: nowrap;
					}


					.content:hover {
						background: yellow;
						transition: all .5s;
					}

					.sep {
						font-size: 1.2em;
						padding-top: 30px;
						padding-bottom: 20px;
						padding-left: 17px;
						border-bottom: 1px solid #efefef;
						margin-bottom: 30px;
					}

				</style>
			</head>
			<body>
				<h2>Aktueller Bestand</h2>
				<table>
					<xsl:for-each select="//wagen[generate-id(.)=generate-id(key('motor_verbrennung', motor/verbrennung/@typ)[1])]">
						<tr>
							<td class="sep" colspan="14">
								<xsl:value-of select="motor/verbrennung/@typ" /> 
							</td>
						</tr>
						<tr>
							<th>ID</th>
							<th>Hersteller</th>
							<th>Modell</th>
							<th>Motor</th>
							<th>Baujahr</th>
							<th>Erstzulassung</th>
							<th>KM-Stand</th>
							<th>Neuwagen</th>
							<th>PS</th>
							<th>Tankfassung</th>
							<th>Antriebsart</th>
							<th>Form</th>
							<th>Bild</th>
							<th>Unfälle</th>
						</tr>
						<!-- <xsl:for-each select="//wagen"> -->
							<xsl:for-each select="key('motor_verbrennung', motor/verbrennung/@typ)">
								<xsl:sort select="motor/verbrennung/ps" order="descending"/>
								<!-- <xsl:sort select="motor/elektro/ps" order="descending"/> -->
								<xsl:sort select="baujahr" order="ascending"/>
								<tr class="content">
									<xsl:if test="position() mod 2 = 0">
		       							<xsl:attribute name="bgcolor">#efefef</xsl:attribute>
		    						</xsl:if>
									<td>
										<xsl:value-of select="@WagenID" /> 
									</td>
									<td>
										<xsl:value-of select="hersteller" /> 
									</td>
									<td>
										<xsl:value-of select="modell" /> 
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
					</xsl:for-each>

					<tr>
						<td class="sep" colspan="14">
							Elektro
						</td>
					</tr>
					<tr>
						<th>ID</th>
						<th>Hersteller</th>
						<th>Modell</th>
						<th>Motor</th>
						<th>Baujahr</th>
						<th>Erstzulassung</th>
						<th>KM-Stand</th>
						<th>Neuwagen</th>
						<th>PS</th>
						<th>Tankfassung</th>
						<th>Antriebsart</th>
						<th>Form</th>
						<th>Bild</th>
						<th>Unfälle</th>
					</tr>
					
					<xsl:for-each select="//wagen[descendant::elektro]">
						<xsl:sort select="motor/elektro/ps" order="descending"/>
						<xsl:sort select="baujahr" order="ascending"/>
						<tr class="content">
							<xsl:if test="position() mod 2 = 0">
       							<xsl:attribute name="bgcolor">#efefef</xsl:attribute>
    						</xsl:if>
							<td>
								<xsl:value-of select="@WagenID" /> 
							</td>
							<td>
								<xsl:value-of select="hersteller" /> 
							</td>
							<td>
								<xsl:value-of select="modell" /> 
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
				<br />
				<br />
				<h2>Wagenverzeichnis</h2>
				<table>
					<xsl:for-each select="//wagen[generate-id(.)=generate-id(key('antrieb', antriebsart/@typ)[1])]">
					<tr>
						<td class="sep" colspan="14">
							<xsl:value-of select="antriebsart/@typ" /> 
						</td>
					</tr>
					<tr>
						<th>ID</th>
						<th>Hersteller</th>
						<th>Modell</th>
						<th>Motor</th>
						<th>Baujahr</th>
						<th>Erstzulassung</th>
						<th>KM-Stand</th>
						<th>Neuwagen</th>
						<th>PS</th>
						<th>Tankfassung</th>
						<th>Antriebsart</th>
						<th>Form</th>
						<th>Bild</th>
						<th>Unfälle</th>
					</tr>
						<xsl:for-each select="key('antrieb', antriebsart/@typ)">
						<xsl:sort select="hersteller" order="ascending"/>
						<xsl:sort select="modell" order="ascending"/>
						<tr class="content">
							<xsl:if test="position() mod 2 = 0">
       							<xsl:attribute name="bgcolor">#efefef</xsl:attribute>
    						</xsl:if>
							<td>
								<xsl:value-of select="@WagenID" /> 
							</td>
							<td>
								<xsl:value-of select="hersteller" /> 
							</td>
							<td>
								<xsl:value-of select="modell" /> 
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
					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
