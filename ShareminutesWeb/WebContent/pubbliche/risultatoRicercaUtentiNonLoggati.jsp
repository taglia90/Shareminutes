<%@ page import="entity.Utente"%>
<%@ page import="java.util.List"%>
<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>

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
		<h2>Risultato ricerca</h2>
		<h3>
			Per aggiungere un utente ai tuoi amici o inviargli un messaggio <strong><a
				href="GestioneRicercheServlet?to=redirectToIndex">accedi</a></strong> o <strong><a
				href="GestioneRicercheServlet?to=redirectToPaginaRegistrazione">registrati</a></strong>.
		</h3>
		<br />
		<%
			List<Utente> listaUtenti = (List<Utente>) session
					.getAttribute("listaUtentiConAbilita");
			if (listaUtenti != null && listaUtenti.size() != 0) {
		%>
		<table class="zebra-striped">
			<thead>
				<tr>
					<th>Username</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Nome</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Cognome</th>
				</tr>
			</thead>
			<tbody>

				<%
					for (Utente u : listaUtenti) {
				%>

				<tr>
					<td><%=u.getUsername()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><%=u.getNome()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><%=u.getCognome()%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			} else {
		%>
		<strong>La ricerca non ha prodotto risultati.</strong>
		<%
			}
		%>
	</section>
</div>
<%@ include file="../footer.jsp"%>