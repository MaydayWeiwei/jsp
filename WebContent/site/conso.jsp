<%@ page import="java.sql.*"%>
<%@ taglib uri="http://jakarta.apache.org/taglibs/dbtags" prefix="sql"%>
<%@ page language="java" import="cal.*"%>
<%@ page import="java.util.*"%>



<jsp:useBean id="date" scope="session" class="cal.JspCalendar" />

<sql:connection id="conn3">
	<sql:url>jdbc:mysql://localhost:3306/consommation?user=root </sql:url>
	<sql:driver>com.mysql.jdbc.Driver</sql:driver>
</sql:connection>
<%
	String[] lesMois = new String[]{"Janvier", "Février", "Mars",
			"Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre",
			"Octobre", "Novembre", "Décembre"};
	String lannee = request.getParameter("annee");
	String consommable = request.getParameter("consommable");
	String lieu = request.getParameter("lieu");
	int annee = (lannee != null)
			? (new Integer(lannee)).intValue()
			: date.getYear();;
	int[] valCompteur = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	int valCompteurDec = 0;
	int[] valConsommation = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	ResultSet rset = null;
	PreparedStatement pstmt = null;
	int leMois = 0;
	int indexCourant = 0;
	if (consommable == null)
		consommable = "EAU";
	if (lieu == null)
		lieu = "Ecole";

	// recherche des valeurs de compteurs pour ce consommable, dans ce lieu pour cette année
	pstmt = conn3
			.prepareStatement("select * from tableau where annee = ? and lieu=? and consommable=? order by mois");
	pstmt.setInt(1, annee);
	pstmt.setString(2, lieu);
	pstmt.setString(3, consommable);
	rset = pstmt.executeQuery();
	while (rset.next()) {
		leMois = rset.getInt("mois");
		indexCourant = rset.getInt("compteur");
		valCompteur[leMois - 1] = indexCourant;
	}
	
	//Pour la valeur de consommation de janvier, il faut rechercher la valeur du mois de décembre précédent.
	pstmt = conn3
			.prepareStatement("select * from tableau where annee = ? and lieu=? and consommable=? and mois=12");
	pstmt.setInt(1, annee - 1);
	pstmt.setString(2, lieu);
	pstmt.setString(3, consommable);
	rset = pstmt.executeQuery();
	while (rset.next()) {
		leMois = rset.getInt("mois");
		indexCourant = rset.getInt("compteur");
		valCompteurDec = indexCourant;
	}

	//Calculer la valeur de consommqtion de janvier
	valConsommation[0] = valCompteur[0] - valCompteurDec;
	for (int i = 1; i < 12; i++) {
		if (valCompteur[i] == 0) { //si le mois contient la valeur de compteur 0, la valeur de consommation sera mise à zéro
			valConsommation[i] = 0;
		} else {
			valConsommation[i] = valCompteur[i] - valCompteur[i - 1];
		}
	}
%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link type="text/css" href="../style/deco.css" rel="stylesheet">
<title>Courbes de consommation</TITLE>
</head>

<body BGCOLOR="white">
	<%@ include file="accesmenuConsommation.jsp"%>

	<H1>
		<%=lieu%>
		Consommation en
		<%=consommable%>
	</h1>
	<form name="modification" method="get"
		action="gerebaseConsommation.jsp">
		<table WIDTH=800px class="Casebleu">
			<tr>
				<td><a
					href="conso.jsp?annee=<%=annee - 1%>&consommable=<%=consommable%>&lieu=<%=lieu%>">Précédente
				</a>Annee:<%=annee%> <%
 	if (date.getYear() != annee) {
 %> <a
					href="conso.jsp?annee=<%=annee + 1%>&consommable=<%=consommable%>&lieu=<%=lieu%>">
						Suivante</a> <%
 	}
 %>
					<button name="enregistrer" type="submit" value="enregistrer">enregistrer</button>
				</td>
			</tr>
		</table>


		<table WIDTH=20% BGCOLOR=lightblue BORDER=1>
			<tr>
				<td>
					<table>
						<tr>
							<th BGCOLOR=yellow><%=consommable%></th>
						</tr>
						<tr>
							<th>compteur</th>
						</tr>
						<tr>
							<th>consommation</th>
						</tr>
					</table>
				</td>

				<%
					for (int i = 0; i <= 11; i++) {
				%>
				<%
					if ((annee < date.getYear())
								|| ((annee == date.getYear()) && (i < date
										.getMonthInt()))) {
				%>
				<td>
					<table style="width: 30px;" class="Casebleu1">
						<tr>
							<td><%=lesMois[i]%></td>
						</tr>
						<tr>
							<%
								//Si la personne connectée a la fonction administrateur, il peut modifier le compteur
										if (session.getAttribute("fonction").equals(
												"administrateur")) {
							%>
							<td><input name="<%=i%>" type="text"
								value="<%=valCompteur[i]%>"></td>
							<%
								//sinon, il ne peut pas modifier le compteur
										} else {
							%>
							<td><%=valCompteur[i]%></td>
							<%
								}
							%>

						</tr>
						<tr>
							<td><%=valConsommation[i]%></td>
						</tr>
					</table>
				</td>
				<%
					}
				%>
				<%
					}
				%>
			</tr>
		</table>
		<input type="hidden" name="annee" value="<%=annee%>" /> <input
			type="hidden" name="lieu" value="<%=lieu%>" /> <input type="hidden"
			name="consommable" value="<%=consommable%>" />
	</form>

	<!-- 
	***Affichage de la courbe représentant la valeur des compteurs et des consomations
	 -->
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script type="text/javascript">
		google.load("visualization", "0", {
			packages : [ "corechart" ]
		});
		google.setOnLoadCallback(drawChart);
		function drawChart() {
			var compteur = google.visualization.arrayToDataTable([
					[ 'Mois', 'Compteurs' ] 
					<%for (int i = 0; i < 12; i++) {%> 
					<%if ((annee < date.getYear())
						|| ((annee == date.getYear()) && (i < date
								.getMonthInt()))) {%>
					, [ <%=i + 1%>, <%=valCompteur[i]%> ] 
					<%}
			}%> 
					]);
			var conso = google.visualization.arrayToDataTable([
					[ 'Mois', 'Consos' ]
					<%for (int i = 0; i < 12; i++) {%>
					<%if ((annee < date.getYear())
						|| ((annee == date.getYear()) && (i < date
								.getMonthInt()))) {%>
					, [ <%=i + 1%>, <%=valConsommation[i]%> ]
					<%}
			}%>
					]);
		var options = {
				annotations : {
					textStyle : {
						fontName : 'Times-Roman',
						fontSize : 18,
						bold : true,
						italic : true,
						color : '#871b47', // The color of the text. 
						auraColor: '#d799ae', // The color of the text outline. 
						opacity: 0.8 // The transparency of the text.
					}
				}
			};
			var chart1 = new google.visualization.LineChart(document
					.getElementById('chart_div1'));
			chart1.draw(compteur, options);
			var chart2 = new google.visualization.LineChart(document
					.getElementById('chart_div2'));
			chart2.draw(conso, options);
		}
	</script>
	<div id="chart_div1" style="width: 800px; height: 200px;"></div>
	<div id="chart_div2" style="width: 800px; height: 200px;"></div>
</body>
</html>


