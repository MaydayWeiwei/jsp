<%@ page import="java.sql.*"%>

<%@ taglib uri="http://jakarta.apache.org/taglibs/dbtags" prefix="sql"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<!--  connexion à la base de données, avec les balises dbtags,
       la variable conn4 est accessible dans les scriplets  -->
<sql:connection id="conn4">
	<sql:url>jdbc:mysql://localhost:3306/consommation?user=root </sql:url>
	<sql:driver>com.mysql.jdbc.Driver</sql:driver>
</sql:connection>
<%

	String nomConsommable = request.getParameter("nomConso").toLowerCase(); 
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	
	if ((request.getParameter("ajouter") != null)
			&& request.getParameter("ajouter").trim().equals("ajouter")) { //  si paramètre ajouter est présent  -->
		try {
			pstmt = conn4
					.prepareStatement("insert into consommable (nom) values (?)");
			pstmt.setString(1, nomConsommable);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			log(" - probeme  " + e.getClass().getName());
		}
	}
%>

<jsp:forward page="conso.jsp" />

</html>