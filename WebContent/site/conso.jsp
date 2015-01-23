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
	String[] lesMois = new String[] { "Janvier", "Février", "Mars",
			"Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre",
			"Octobre", "Novembre", "Décembre" };
	String lannee = request.getParameter("annee");
	String consommable = request.getParameter("consommable");
	String lieu = request.getParameter("lieu");
	int annee = (lannee != null) ? (new Integer(lannee)).intValue()
			: date.getYear();
	;
	int[] valCompteur = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
	int valCompteurDec = 0;
	int[] valConsommation = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
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
	pstmt = conn3
			.prepareStatement("select * from tableau where annee = ? and lieu=? and consommable=? and mois=12");
	pstmt.setInt(1, annee-1);
	pstmt.setString(2, lieu);
	pstmt.setString(3, consommable);
	rset = pstmt.executeQuery();
	while (rset.next()) {
		leMois = rset.getInt("mois");
		indexCourant = rset.getInt("compteur");
		valCompteurDec = indexCourant;
	}
	
	valConsommation[0] = valCompteur[0]-valCompteurDec;
	for(int i = 1; i < 12; i++){
	valConsommation[i]=valCompteur[i] - valCompteur[i-1];
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
	<form name="modification" method="get" action="gerebaseConsommation.jsp">
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
 %>	<button name="enregistrer" type="submit" value="enregistrer" >enregistrer</button>
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
				<table style="width: 50px;" class="Casebleu1">
					<tr>
						<td><%=lesMois[i]%></td>
					</tr>
					<tr>
						<td><input name="<%=i%>" type="text" value="<%=valCompteur[i]%>"></td>
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
	<input type="hidden" name="annee" value="<%=annee%>"/>
	<input type="hidden" name="lieu" value="<%=lieu%>"/>
	<input type="hidden" name="consommable" value="<%=consommable%>"/>
	</form>
</body>
</html>


