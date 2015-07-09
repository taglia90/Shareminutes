<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Richiesta"%>
<%@ page import="entity.Messaggio"%>
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

			Richiesta richiesta = (Richiesta) session.getAttribute("richiesta");
			if (richiesta != null) {
		%>
		<br />
		<%
			if (richiesta.getUtenteMittente().getUsername()
						.equals(tok.getEmail())) {
		%>
		<h2>
			Richiesta inviata a:&nbsp; <span><%=richiesta.getUtenteDestinatario().getUsername()%></span>
		</h2>
		<%
			} else {
		%>
		<h2>
			Richiesta ricevuta da:&nbsp; <span><%=richiesta.getUtenteMittente().getUsername()%>
			</span>
		</h2>
		<%
			}
		%>
		<h2>
			Oggetto:&nbsp;<span><%=richiesta.getOggettoRichiesta()%></span>
		</h2>
		<table class="zebra-striped">
			<tbody>
				<%
					List<Messaggio> listaMessaggi = (List<Messaggio>) session
								.getAttribute("listaMessaggi");
						int i;
						for (i = 0; i < listaMessaggi.size(); i++) {
							Messaggio messaggio = listaMessaggi.get(i);
				%>
				<div class="clearfix">
					Utente:&nbsp;&nbsp;
					<%
						if (messaggio.getUtente().getUsername()
										.equals(tok.getEmail())) {
					%>
					Io
					<%
						} else {
					%>
					<%=messaggio.getUtente().getUsername()%>
					<%
						}
					%>
					<br /> <br />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Messaggio:
					<%=messaggio.getCorpoMessaggio()%>
					<br /> <br /> <br />
				</div>
				<%
					}
				%>
				<%--		if (!richiesta.getHaRicevutoFeedback()) {
							--%>
				<!-- 
							<form
								action="GestioneRichiesteServlet?to=creaNuovoMessaggio&idRichiesta=<%=richiesta.getIdRichiesta()%>"
								method="post" name="form">
								<div class="clearfix">
									<label for="textarea">Inserisci la risposta:</label>
									<div class="input">
										<textarea id="textarea2" class="xxlarge" rows="10" cols="120"
											name="corpoMessaggio"></textarea>
									</div>
								</div>
								<br /> <br /> <br />
								<div class="actions">
									<button class="btn primary" type="submit">Conferma</button>
								</div>
							</form>
							<%--
								if (richiesta.getUtenteMittente().getUsername()
												.equals(tok.getEmail())) {
							--%>
							<a
								href="GestioneFeedbackServlet?to=redirectToPaginaNuovoFeedback&usernameDestinatario=<%=richiesta.getUtenteDestinatario().getIdUtente()%>&idRichiesta=<%=richiesta.getIdRichiesta()%>">Rilascia
								Feedback</a> -->
				<%--
								}
									}
							--%>
			</tbody>
		</table>
		<%
			} else {
		%>
		<strong>Errore nel recupero della richiesta.</strong>
		<%
			}
		%>
	</section>
</div>
<%@ include file="../footer.jsp"%>