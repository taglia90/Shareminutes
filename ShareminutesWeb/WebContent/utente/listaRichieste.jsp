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
		<h2>Lista Richieste Ricevute</h2>
		<%
			List<Richiesta> listaRichiesteRicevute = (List<Richiesta>) session
					.getAttribute("listaRichiesteRicevute");
			if (listaRichiesteRicevute != null
					&& listaRichiesteRicevute.size() != 0) {
		%>
		<table class="zebra-striped">
			<thead>
				<tr>
					<th>Mittente</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Oggetto</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
					for (Richiesta richiesta : listaRichiesteRicevute) {
				%>
				<tr>
					<td><%=richiesta.getUtenteMittente().getNome()%> <%=richiesta.getUtenteMittente().getCognome()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><%=richiesta.getOggettoRichiesta()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><a
						href="GestioneRichiesteServlet?to=redirectToPaginaDettaglioRichiesta&idRichiesta=<%=richiesta.getIdRichiesta()%>">Visualizza
							richiesta completa.</a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			} else {
		%>
		<strong>Non ci sono richieste.</strong>
		<%
			}
		%>
		<br />
		<h2>Lista Richieste Mandate</h2>
		<%
			List<Richiesta> listaRichiesteMandate = (List<Richiesta>) session
					.getAttribute("listaRichiesteMandate");
			if (listaRichiesteMandate != null
					&& listaRichiesteMandate.size() != 0) {
		%>
		<table class="zebra-striped">
			<thead>
				<tr>
					<th>Destinatario</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Oggetto</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
					for (Richiesta richiesta : listaRichiesteMandate) {
				%>
				<tr>
					<td><%=richiesta.getUtenteDestinatario().getNome()%> <%=richiesta.getUtenteDestinatario().getCognome()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><%=richiesta.getOggettoRichiesta()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><a
						href="GestioneRichiesteServlet?to=redirectToPaginaDettaglioRichiesta&idRichiesta=<%=richiesta.getIdRichiesta()%>">Visualizza
							richiesta completa.</a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			} else {
		%>
		<strong>Non ci sono richieste.</strong>
		<%
			}
		%>
	</section>

</div>
<%@ include file="../footer.jsp"%>