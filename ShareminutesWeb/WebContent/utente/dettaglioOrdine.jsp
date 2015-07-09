<%@page import="entity.Prenotazione"%>
<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Richiesta"%>
<%@ page import="entity.Messaggio"%>
<%@ page import="entity.Abilita"%>
<%@ page import="entity.Utente"%>
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

			Prenotazione prenotazione = (Prenotazione) session
					.getAttribute("prenotazione");
			if (prenotazione != null) {
		%>
		<h2>Dettaglio ordine</h2>
		<br />
		<%
			//AS A BUYER
				if (prenotazione.getUtenteBuyer().getIdUtente() == tok
						.getIdUtente()) {
					Utente u = prenotazione.getUtenteSeller();
					Abilita a = prenotazione.getAbilita();
		%>


		<table class="zebra-striped">
			<tbody>
				<tr>
					<td>Utente seller:&nbsp; <a
						href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.getIdUtente()%>"><%=u.getNome()%>
							<%=u.getCognome()%></a> <br /></td>
					<td><img
						src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=u.getIdUtente()%>"
						height="200" alt="Foto Profilo" /></td>
					<td><label>Attività:</label> <a
						href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a.getIdAbilita()%>"><%=a.getNomeAbilita()%>
					</a></td>
					<td>Rating seller: <a
						href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&usernameUtente=<%=u.getIdUtente()%>">Vedi
							feedback utente</a><br />
					</td>
					<td><label>Stato:</label> <%
 	if (prenotazione.isPagata()) {
 %> <label>Pagamento confermato</label><a
						href="GestioneFeedbackServlet?to=redirectToPaginaNuovoFeedback&usernameDestinatario=<%=u.getIdUtente()%>&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">Rilascia
							Feedback</a> <%
 	} else if (prenotazione.isConfermataBuyer()
 					&& prenotazione.isAccettataSeller()) {
 %><label>PULSANTE PAGAMENTO</label> <%
 	} else if (!prenotazione.isConfermataBuyer()
 					&& prenotazione.isAccettataSeller()) {
 %> <a
						href="GestionePrenotazioniServlet?to=SetConfermataBuyer&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">
							CONCLUDI PRENOTAZIONE</a><br /> <a
						href="GestionePrenotazioniServlet?to=SetRifiutata&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">
							ANNULLA PRENOTAZIONE</a> <%
 	} else {
 %><label>In attesa di una risposta del seller.</label> <%
 	}
 %></td>
				</tr>
			</tbody>
		</table>

		<br /> <br /> <br /> <br />

		<%
			//AS A SELLER
				} else {
					Utente u = prenotazione.getUtenteBuyer();
					Abilita a = prenotazione.getAbilita();
		%>
		<table class="zebra-striped">
			<tbody>
				<tr>
					<td>Utente buyer:&nbsp; <a
						href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.getIdUtente()%>"><%=u.getNome()%>
							<%=u.getCognome()%></a> <br /></td>
					<td><img
						src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=u.getIdUtente()%>"
						height="200" alt="Foto Profilo" /></td>
					<td><label>Attività:</label> <a
						href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a.getIdAbilita()%>"><%=a.getNomeAbilita()%>
					</a></td>
					<td>Rating seller: <a
						href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&usernameUtente=<%=u.getIdUtente()%>">Vedi
							feedback utente</a><br />
					</td>
					<td><label>Stato:</label> <%
 	if (prenotazione.isPagata()) {
 %><label>Pagamento confermato</label> <a
						href="GestioneFeedbackServlet?to=redirectToPaginaNuovoFeedback&usernameDestinatario=<%=u.getIdUtente()%>&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">Rilascia
							Feedback</a> <%
 	} else if (prenotazione.isConfermataBuyer()
 					&& prenotazione.isAccettataSeller()) {
 %><label>In attesa del pagamento</label> <%
 	} else if (!prenotazione.isConfermataBuyer()
 					&& prenotazione.isAccettataSeller()) {
 %> <label> In attesa della conferma del cliente</label> <%
 	} else {
 %> <a
						href="GestionePrenotazioniServlet?to=SetAccettataSeller&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">
							ACCETTA OFFERTA</a><br /> <a
						href="GestionePrenotazioniServlet?to=SetRifiutata&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">
							RIFIUTA OFFERTA</a> <%
 	}
 %></td>
				</tr>
			</tbody>
		</table>
		<%
			}
		%>
		<%
			} else {
		%>
		<strong>Errore nel recupero dell'ordine.</strong>
		<%
			}
		%>

	</section>

</div>
<%@ include file="../footer.jsp"%>