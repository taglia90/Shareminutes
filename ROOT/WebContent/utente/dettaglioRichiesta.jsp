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
		<div class="modificaProfiloContainer">

			<%
				if (richiesta.getUtenteMittente().getUsername()
							.equals(tok.getEmail())) {
			%>


			<div style="" class="titoloBlu">
				Messaggio inviato a:&nbsp; <span><%=richiesta.getUtenteDestinatario().getNome() + " "
							+ richiesta.getUtenteDestinatario().getCognome()%></span>
			</div>



			<%
				} else {
			%>
			<div style="" class="titoloBlu">
				Messaggio ricevuto da:&nbsp; <span><%=richiesta.getUtenteMittente().getNome() + " "
							+ richiesta.getUtenteMittente().getCognome()%> </span>
			</div>
			<%
				}
			%>
			<div style="" class="titoloBlu">
				Oggetto:&nbsp;<span><%=richiesta.getOggettoRichiesta()%></span>
			</div>
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

						<%
							if (messaggio.getUtente().getUsername()
											.equals(tok.getEmail())) {
						%>
						<div class="destra">
						<div class="contenitoreNomeFoto">
							
							<div class="nomeUtenteFeedback">
								<%=messaggio.getUtente().getNome() + " "
								+ messaggio.getUtente().getCognome()%>
							</div>
							<div class="fotoProfiloFeedback ">
								<img
									src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=tok.getIdUtente()%>" />
							</div>
						</div>

							<%
								} else {
							%>
							<div class="sinistra">
							<div class="contenitoreNomeFoto">
								<div class="fotoProfiloFeedback ">
									<img
										src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=messaggio.getUtente().getIdUtente()%>" />
								</div>
								<div class="nomeUtenteFeedback"><a href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=messaggio.getUtente().getIdUtente()%>">
									<%=messaggio.getUtente().getNome() + " "
								+ messaggio.getUtente().getCognome()%>
								</a></div>
							</div>
								<%
									}
								%>
								<br /> <br />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<div class="sfondoGrigio" ><%=messaggio.getCorpoMessaggio()%></div>
								<br /><br /><br />
							</div>
						</div>
						<%
							}
						%>
						<%--		if (!richiesta.getHaRicevutoFeedback()) {
							--%>

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
							<div class="responsiveContainerButton">
							<div class="actions">
								<button class="btn primary bottone" type="submit">Invia</button>
							</div>
							</div>
						</form>
						<%--
								if (richiesta.getUtenteMittente().getUsername()
												.equals(tok.getEmail())) {
							--%>
						<!-- <a
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
		</div>
	</section>
</div>
<%@ include file="../footer.jsp"%>