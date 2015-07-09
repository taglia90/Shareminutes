<%@page import="entity.Prenotazione"%>
<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Richiesta"%>
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
		<h2>Lista ordini as a buyer</h2>
		<%
			List<Prenotazione> listaOrdiniAsABuyer = (List<Prenotazione>) session
					.getAttribute("listaOrdiniAsABuyer");
			if (listaOrdiniAsABuyer != null && listaOrdiniAsABuyer.size() != 0) {
		%>
		<table class="zebra-striped">
			<thead>
				<tr>
					<th>Utente Seller</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Attività</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
					for (Prenotazione prenotazione : listaOrdiniAsABuyer) {
				%>
				<tr>
					<td><%=prenotazione.getUtenteSeller().getNome()%> <%=prenotazione.getUtenteSeller().getCognome()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><%=prenotazione.getAbilita().getNomeAbilita()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><a
						href="GestionePagineServlet?to=redirectToDettaglioOrdine&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">Visualizza
							ordine completo.</a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			} else {
		%>
		<strong>Non ci sono ordini.</strong>
		<%
			}
		%>
		<br />
		<h2>Lista ordini as a seller</h2>
		<%
			List<Prenotazione> listaOrdiniAsASeller = (List<Prenotazione>) session
					.getAttribute("listaOrdiniAsASeller");
			if (listaOrdiniAsASeller != null
					&& listaOrdiniAsASeller.size() != 0) {
		%>
		<table class="zebra-striped">
			<thead>
				<tr>
					<th>Utente buyer</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Attività</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
					for (Prenotazione prenotazione : listaOrdiniAsASeller) {
				%>
				<tr>
					<td><%=prenotazione.getUtenteBuyer().getNome()%> <%=prenotazione.getUtenteSeller().getCognome()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><%=prenotazione.getAbilita().getNomeAbilita()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><a
						href="GestionePagineServlet?to=redirectToDettaglioOrdine&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">Visualizza
							ordine completo.</a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			} else {
		%>
		<strong>Non ci sono ordini.</strong>
		<%
			}
		%>
	</section>
</div>
<%@ include file="../footer.jsp"%>