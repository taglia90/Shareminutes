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
		<br />
		<h2>Feedback</h2>
		<form enctype="multipart/form-data"
			<%//String idRichiesta = (String) session.getAttribute("idRichiesta");
			String idPrenotazione = (String) session
					.getAttribute("idPrenotazione");
			String idUtenteDestinatario = (String) session
					.getAttribute("idUtenteDestinatario");%>
			action="GestioneFeedbackServlet?to=nuovoFeedback&idUtenteDestinatario=<%=idUtenteDestinatario%>&idPrenotazione=<%=idPrenotazione%>"
			method="post">
			<div class="clearfix">
				<label>Dai un voto da 1 (pessimo) a 5 (ottimo)</label> <select
					name="votoSintetico">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
				</select>
			</div>

			<br /> <br />
			<div class="clearfix">
				<label for="textarea">Voto Esteso</label>
				<div class="input">
					<textarea id="textarea2" class="xxlarge" rows="10" cols="110"
						name="votoEsteso"></textarea>
				</div>
			</div>
			<br /> <br />
			<div class="actions">
				<button class="btn primary" type="submit">Conferma</button>
				<a href="./GestioneUtentiServlet?to=redirectToPaginaProfilo"
					class="btn">Annulla</a>
			</div>
		</form>
	</section>
</div>
<%@ include file="../footer.jsp"%>