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
		<br />
		<h2>Attività</h2>
		<%
			List<Abilita> listaAbilita = (List<Abilita>) session
					.getAttribute("listaAbilita");
			if (listaAbilita != null && listaAbilita.size() != 0) {
		%>
		<table class="zebra-striped">
			<thead>
				<tr>
					<th>Foto</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Nome</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Descrizione</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Modifica</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Elimina</th>
				</tr>
			</thead>
			<tbody>
				<%
					for (Abilita abilita : listaAbilita) {
				%>
				<tr>
					<td><img
						src="GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=abilita.getIdAbilita()%>"
						height="200" alt="Foto Attività" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><%=abilita.getNomeAbilita()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><%=abilita.getDescrizioneAbilita()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><a
						href="GestioneAbilitaServlet?to=redirectToPaginaModificaAbilita&idAbilita=<%=abilita.getIdAbilita()%>">Modifica</a></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><a
						href="GestioneAbilitaServlet?to=eliminaAbilita&idAbilita=<%=abilita.getIdAbilita()%>">Elimina</a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			} else {
		%>
		<strong>Non hai ancora selezionato nessuna abilità.</strong>
		<%
			}
		%>
		<br /> <br /> <a
			href="GestioneAbilitaServlet?to=redirectToPaginaCreazioneAbilita">Proponi
			una nuova abilità</a> <br /> <br />
		<!-- <a
						href="GestioneAbilitaServlet?to=redirectToPaginaAggiungiAbilitaUtente">Aggiungi
						o elimina le tue abilità.</a>-->

	</section>
</div>
<%@ include file="../footer.jsp"%>