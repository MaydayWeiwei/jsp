<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="../style/deco.css" rel="stylesheet">
</head>
<body>
	<h3>Veuillez ajouter un nouveau consommable</h3>
	<form name="consommable" method="get" action="gerebaseConsommable.jsp">
		<table width="400" class="Casebleu1">
			<tr>
				<th>nom :</th>
				<td><input name="nomConso" type="text"></td>
			</tr>
			<tr>
				<th colspan="2">
					<button name="ajouter" type="submit" value="ajouter">
						ajouter</button>
				</th>
			</tr>
		</table>
	</form>
</body>
</html>