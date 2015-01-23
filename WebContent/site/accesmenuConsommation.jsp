 
 
 <% 
    String couleur = ";background:#c0ebe7";
 
 %>
 
 <table class="Casebleu" style="border: 0px; margin:0 ; padding:0px;" >
 	<tr>
	<%@ include file="accesmenuBarreSup.jsp" %>  
	 <td>
    <table class="Casebleu" style="border: 0px; margin:0 ; padding:0px;" >
      <tr> 
       <td> 
       <b>  Gestion des consommations  </b>
	     </td>  <td>
			    <button  name="choix" onClick="self.location.href='conso.jsp?consommable=EAU&lieu=<%=lieu%>'" type="button"  style="width: 130px <%= (consommable.equals("EAU"))?couleur:" " %> " >  Eau </button> 
         </td>  <td>
				<button  name="choix" onClick="self.location.href='conso.jsp?consommable=ELECTRICITE&lieu=<%=lieu%>'" type="button"  style="width: 150px <%= (consommable.equals("ELECTRICITE"))?couleur:" " %>"> Electricité  </button> 
         </td> 	  		 
	  </tr> 
    </table>
    </td>
	</tr><tr>
		 <td>
    <table class="Casebleu" style="border: 0px; margin:0 ; padding:0px;" >
      <tr> 
         <td  style="width:100px;" > 
       <b>  <%=consommable%> </b>
	      <td>
				<button  name="choix" onClick="self.location.href='conso.jsp?lieu=Centre_Technique&consommable=<%=consommable%>'" type="button"  style="width:80px; height:40px <%= (lieu.equals("Centre_Technique"))?couleur:" " %>"> Centre Technique </button>	
         </td> 	 <td>
        		<button  name="choix" onClick="self.location.href='conso.jsp?lieu=Ecole&consommable=<%=consommable%>'" type="button"  style="width:60px; height:40px <%= (lieu.equals("Ecole"))?couleur:" " %>"> Ecole </button>	
		</td> 	 <td>
        		<button  name="choix" onClick="self.location.href='conso.jsp?lieu=Mairie&consommable=<%=consommable%>'" type="button"  style="width:60px; height:40px <%= (lieu.equals("Mairie"))?couleur:" " %>"> Mairie </button>	
  		</td> 	  
	  </tr> 
    </table>
    </td>
	</tr>
 </table>	


