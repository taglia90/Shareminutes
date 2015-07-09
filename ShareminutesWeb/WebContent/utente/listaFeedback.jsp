<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Feedback"%>
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
		<h2>
			Lista Feedback Ricevuti di <span> <%=(String) session.getAttribute("idUtente")%>
			</span>
		</h2>
		<%
			List<Feedback> listaFeedbackRicevuti = (List<Feedback>) session
					.getAttribute("listaFeedbackRicevuti");
			if (listaFeedbackRicevuti != null
					&& listaFeedbackRicevuti.size() != 0) {
		%>
		<table class="zebra-striped">
			<thead>
				<tr>
					<th>UtenteGiudicante</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Voto Sintetico</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Voto Esteso</th>
				</tr>
			</thead>
			<tbody>
				<%
					for (Feedback feedback : listaFeedbackRicevuti) {
				%>
				<tr>
					<td><%=feedback.getUtenteGiudicante().getNome()%> <%=feedback.getUtenteGiudicante().getCognome()%></td>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<td><%=feedback.getVotoSintetico()%></td>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<td><%=feedback.getVotoEsteso()%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			} else {
		%>
		<strong>Non ci sono feedback ricevuti.</strong>
		<%
			}
		%>
		<br />
		<%
			List<Feedback> listaFeedbackCreati = (List<Feedback>) session
					.getAttribute("listaFeedbackCreati");
			if (listaFeedbackCreati != null && listaFeedbackCreati.size() != 0) {
		%>
		<h2>Lista Feedback Creati</h2>

		<table class="zebra-striped">
			<thead>
				<tr>
					<th>UtenteDestinatario</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>

					<th>Voto Sintetico</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>

					<th>Voto Esteso</th>

				</tr>
			</thead>
			<tbody>
				<%
					for (Feedback feedback : listaFeedbackCreati) {
				%>
				<tr>
					<td><%=feedback.getUtenteRicevente().getNome()%> <%=feedback.getUtenteRicevente().getCognome()%></td>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>

					<td><%=feedback.getVotoSintetico()%></td>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>

					<td><%=feedback.getVotoEsteso()%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			} else {
		%>
		<strong>Non ci sono feedback rilasciati.</strong>
		<%
			}
		%>
	</section>

</div>
<%@ include file="../footer.jsp"%>