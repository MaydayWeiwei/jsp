<%@ page import="java.sql.*"%>
<%@ taglib uri="http://jakarta.apache.org/taglibs/dbtags" prefix="sql"%>

<%
	String couleur = ";background:#c0ebe7";
%>

<%
	//Récupérer les consommable dans la table "consommable"
	pstmt = conn3.prepareStatement("select * from consommable");
	rset = pstmt.executeQuery();
%>

<table class="Casebleu" style="border: 0px; margin: 0; padding: 0px;">
	<tr>
		<%@ include file="accesmenuBarreSup.jsp"%>
		<td>
			<table class="Casebleu" style="border: 0px; margin: 0; padding: 0px;">
				<tr>
					<td><b> Gestion des consommations </b></td>
					<td>
						<%
							while (rset.next()) {
								String nomConso = rset.getString("nom");
						%>
						<button name="choix"
							onClick="self.location.href='conso.jsp?consommable=<%=nomConso%>&lieu=<%=lieu%>'"
							type="button"
							style="width: 130px <%=(consommable.toLowerCase().equals(nomConso)) ? couleur
						: " "%> ">
							<%=nomConso%></button> <%
 	}
 %>
					</td>
					<%
						if (session.getAttribute("fonction").equals("administrateur")) {
							//si la fonction de l'utilisateur est administrateur, le button "ajouter un consommable" est affiché
					%>
					<td>
						<button name="choix"
							onClick="self.location.href='ajoutConsommable.jsp'" type="button"
							style="width: 150px">Ajouter un consommable</button>
					</td>
					<%
						}
					%>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table class="Casebleu" style="border: 0px; margin: 0; padding: 0px;">
				<tr>
					<td style="width: 100px;"><b> <%=consommable%>
					</b>
					<td>
						<button name="choix"
							onClick="self.location.href='conso.jsp?lieu=Centre_Technique&consommable=<%=consommable%>'"
							type="button"
							style="width:80px; height:40px <%=(lieu.equals("Centre_Technique")) ? couleur : " "%>">
							Centre Technique</button>
					</td>
					<td>
						<button name="choix"
							onClick="self.location.href='conso.jsp?lieu=Ecole&consommable=<%=consommable%>'"
							type="button"
							style="width:60px; height:40px <%=(lieu.equals("Ecole")) ? couleur : " "%>">
							Ecole</button>
					</td>
					<td>
						<button name="choix"
							onClick="self.location.href='conso.jsp?lieu=Mairie&consommable=<%=consommable%>'"
							type="button"
							style="width:60px; height:40px <%=(lieu.equals("Mairie")) ? couleur : " "%>">
							Mairie</button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


