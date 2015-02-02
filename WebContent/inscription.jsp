<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%
	String inscrire = request.getParameter("inscrire");
	String inscrit = request.getParameter("inscrit");
	String erreur = request.getParameter("erreur");
	String finsession = request.getParameter("finsession");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>identification utilisateurs</title>
<link type="text/css" href="style/deco.css" rel="stylesheet">
</head>
<body>

	<h3>Service de Gestion des consommations</h3>
	<!-- 
***   Affichage d'un message d'erreur en cas de mauvaise identification (paramètre erreur présent)
--!>

<%if (erreur != null) {
				out.println(erreur);
			}%>


<!-- 
****   Affichage d'un message indiquant la fin de session, identification obligatoire
****  parametre "finsession" present
-->

	<%
		if (finsession != null) {
			out.println("Fin de la session");
		}
	%>

	<!--  Si on n'est pas dans le cas ou on a demandé une inscrption 
***
-->

	<h3>Veuillez vous identifier pour la connexion</h3>
	<form name="commande" method="get" action="verificationIdentite.jsp">
		<table width="400" class="Casebleu1">
			<tr>
				<th>votre nom :</th>
				<td><input name="leNom" type="text"></td>
			</tr>
			<tr>
				<th>votre prenom :</th>
				<td><input name="lePrenom" type="text"></td>
			</tr>
			<tr>
				<th>votre mot de passe :</th>
				<td><input type="password" name="leMotPasse"></td>
			</tr>
			<tr>
				<th colspan="2">
					<button name="connexion" type="submit" value="> se connecter">
						> se connecter</button>
				</th>
			</tr>
		</table>
	</form>
	<!-- 
****   Rajoutez un  bouton d'inscription,   ainsi on peut s'inscrire ou se connecter
****   ce bouton sera  absent si la personne  vient de s'inscrire  ( parametre " inscrit " present )
-->
	<%
		if (inscrit == null) {
	%>
	<button name="connexion" type="submit" value="> demande inscription">
		> demande inscription</button>
	<%
		}
	%>


	<!--  Si on est dans le cas ou on a demandé une inscription 
***********
-->

	<h3>Veuillez remplir la fiche d'inscription suivante</h3>
	<form name="commande" method="get" action="verificationIdentite.jsp">
		<table width="400" class="Casebleu1">
			<tr>
				<th>votre nom :</th>
				<td><input name="leNom" type="text"></td>
			</tr>
			<tr>
				<th>votre prenom :</th>
				<td><input name="lePrenom" type="text"></td>
			</tr>
			<tr>
				<th>votre mot de passe :</th>
				<td><input type="password" name="leMotPasse"></td>
			</tr>
			<tr>
				<th>mail :</th>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>
				<th>votre numero téléphone :</th>
				<td><input type="text" name="telephone"></td>
			</tr>
			<tr>
				<th colspan="2">
					<button name="inscrire" type="submit" value="> inscrire">>
						inscrire</button>
				</th>
			</tr>
		</table>
	</form>


	<p>Attention, si vous restez inactifs pendant un certain temps ,
		vous devrez vous reconnecter</p>

<%-- 
	<!--  connexion à la base de données  -->
	<sql:setDataSource var="conn1" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/consommation?user=root"
		scope="session" />

	<!-- recherche des clients dans la base  -->
	<sql:query var="result" dataSource="${conn1}">
	SELECT * FROM utilisateur
	</sql:query>

	<h3>Ensemble des personnes inscrites :</h3>
	<table border="3" width="500" class="Casebleu1">
		<tr>
			<th>nom</th>
			<th>prénom</th>
			<th>mot de passe</th>
			<th>fonction</th>
		</tr>

		<!-- 
***   parcourt de la table emprunteur pour faire un tableau avec les caractéristiques des personnes
****    nom, prenom, mot de passe, fonction
***    ce parcourt doit se faire avec les balises sql
-->
		<c:forEach var="row" items="${result.rows}">
			<tr>
				<td><c:out value="${row.nom }" /></td>
				<td><c:out value="${row.prenom }" /></td>
				<td><c:out value="${row.motpasse }" /></td>
				<td><c:out value="${row.fonction }" /></td>
			</tr>
		</c:forEach>


	</table> --%>
</body>
</html>
