<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="../header.jsp"%>

<div class="wrapper style1">
	<section id="features" class="container special">
		<%
			String errore = (String) session.getAttribute("Errore");
			if (errore != null) {
		%>
		<div class="alert-message error">
			Errore:
			<%=errore.toString()%>
		</div>
		<%
			session.removeAttribute("Errore");
			}
		%>
		<%
			String successo = (String) session.getAttribute("Successo");
			if (successo != null) {
		%>
		<div class="alert-message info">
			<%=successo.toString()%>
		</div>
		<%
			session.removeAttribute("Successo");
			}
		%>
		
		<div style="margin-top:30px !important; " class="modificaProfiloContainer">
		
		<div style="" class="titoloBlu">Lista Abilità</div>
		<%
			List<Abilita> listaAbilita = (List<Abilita>) session
					.getAttribute("listaAbilita");
			if (listaAbilita != null && listaAbilita.size() != 0) {
		%>
		<table class="zebra-striped">
			<thead>
				<tr>
					<th>Nome</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Descrizione</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					
				</tr>
			</thead>
			<tbody>
				<%
					for (Abilita abilita : listaAbilita) {
				%>
				<tr style="margin-top:10px;">
					<td style="font-size:15px; width: 200px; margin-bottom: 10px ! important; padding-bottom: 10px; padding-top: 15px;"><%=abilita.getNomeAbilita()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="descrizioneAdmin"><%=abilita.getDescrizioneAbilita()%></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a
						href="GestioneAbilitaServlet?to=redirectToPaginaModificaAbilita&idAbilita=<%=abilita.getIdAbilita()%>">Modifica</a></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><a href="GestioneAbilitaServlet?to=eliminaAbilita&idAbilita=<%=abilita.getIdAbilita()%>">Elimina</a></td>
				
			
				</tr>
				
				<%
					}
				%>
			</tbody>
		</table>
		<%
			} else {
		%>
		<strong>Non ci sono abilità.</strong>
		<%
			}
		%>

	<!--	<div class="well">
			<br /> <a
				href="GestioneAbilitaServlet?to=redirectToPaginaCreazioneAbilita">Crea
				una nuova abilità</a>
		</div>  -->
		</div>
	</section>
</div>
<%@ include file="../footer.jsp"%>