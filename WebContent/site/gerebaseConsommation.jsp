<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<%@ taglib uri="http://jakarta.apache.org/taglibs/dbtags" prefix="sql"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<!--  connexion à la base de données, avec les balises dbtags,
       la variable conn3 est accessible dans les scriplets  -->
<sql:connection id="conn3">
	<sql:url>jdbc:mysql://localhost:3306/consommation?user=root </sql:url>
	<sql:driver>com.mysql.jdbc.Driver</sql:driver>
</sql:connection>

<%
	String[] leMois = new String[] { "Janvier", "Fevrier", "Mars",
			"Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre",
			"Octobre", "Novembre", "Decembre" };
	String lieu = request.getParameter("lieu").toLowerCase();
	String consommable = request.getParameter("consommable")
			.toLowerCase();
	int annee = (request.getParameter("annee") != null) ? Integer
			.parseInt(request.getParameter("annee")) : 0;
	int compteur, mois = 0;
	String moisLu = null;
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	int id = 0;
%>

<%
	if ((request.getParameter("enregistrer") != null)
			&& request.getParameter("enregistrer").trim()
					.equals("enregistrer")) { //  si paramètre enregistrer est présent  -->
		for (int i = 0; i <= 11; i++) { // boucle sur les 12 mois 0 à 11 -->
			id = 0;
			mois = i + 1; // variable  mois  de 1 à 12 -->
			compteur = (request.getParameter(String.valueOf(i)) != null) ? Integer
					.parseInt(request.getParameter(String.valueOf(i)))
					: 0;
			if (compteur > 0) { // valeur compteur du paramètre mois : 0=0&1=23&2=23&3=34&4=34&5=36&6=39&7=41&8=55&9=0&10=0&11=0  -->  
				try { // si le compteur pour le mois courant contient une valeur >= 0 on regarde celle contenu dans de la base-->
					pstmt = conn3
							.prepareStatement("select * from tableau where lieu=? and consommable=? and annee=? and mois=? ");
					pstmt.setString(1, lieu);
					pstmt.setString(2, consommable);
					pstmt.setInt(3, annee);
					pstmt.setInt(4, mois);
					rset = pstmt.executeQuery();
					if (rset.next()) {
						id = rset.getInt("id");
					}
				} catch (Exception E) {
					log(" - probeme  " + E.getClass().getName());
					E.printStackTrace();
				}
				if (id == 0) { //  si le compteur pour ce mois n'est pas dans  dans  la base on l'insère  -->
					try {
						pstmt = conn3
								.prepareStatement("insert into tableau (lieu, consommable, annee, mois, compteur) values (?,?,?,?,?)");
						pstmt.setString(1, lieu);
						pstmt.setString(2, consommable);
						pstmt.setInt(3, annee);
						pstmt.setInt(4, mois);
						pstmt.setInt(5, compteur);
						pstmt.executeUpdate();
					} catch (SQLException e) {
						log(" - probeme  " + e.getClass().getName());
					}
				} else { //sinon, on le modifie 
					try {
						pstmt = conn3
								.prepareStatement("update tableau set lieu=?,consommable=?,annee=?,mois=?,compteur=?  where id=?");
						pstmt.setString(1, lieu);
						pstmt.setString(2, consommable);
						pstmt.setInt(3, annee);
						pstmt.setInt(4, mois);
						pstmt.setInt(5, compteur);
						pstmt.setInt(6, id);
						pstmt.executeUpdate();
					} catch (SQLException e) {
						log(" - probeme  " + e.getClass().getName());
					}
				}

			}
		}
	}
%>
<jsp:forward page="conso.jsp" />