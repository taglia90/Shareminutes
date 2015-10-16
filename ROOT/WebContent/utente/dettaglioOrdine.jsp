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
		<div style="" class="modificaProfiloContainer">

			<div style="" class="titoloBlu">Dettaglio ordine</div>
			<br />
			<%
				//AS A BUYER
					if (prenotazione.getUtenteBuyer().getIdUtente() == tok
							.getIdUtente()) {
						Utente u = prenotazione.getUtenteSeller();
						Abilita a = prenotazione.getAbilita();
						String data = (String) prenotazione.getDataPrenotazione()
								.toString().substring(0, 10);
						String ora = (String) prenotazione.getOrarioPrenotato()
								.toString();
			%>


			<%--<table class="zebra-striped">
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
						href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtenteUtente=<%=u.getIdUtente()%>">Vedi
							feedback utente</a><br />
					</td>
					<td><label>Stato:</label> <%
 	if (prenotazione.isPagata()) {
 %> <label>Pagamento confermato</label><a
						href="GestioneFeedbackServlet?to=redirectToPaginaNuovoFeedback&idUtenteDestinatario=<%=u.getIdUtente()%>&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">Rilascia
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
				</table> OLD --%>
			<%-- parte mia --%>
			<article style="" class="4u special ordine">
				<div class="risultatoRicercaHeader">
					<div class="risultatoRicercaFotoProfilo">
						<a
							href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.getIdUtente()%>">
							<img class="risultatoRicercaFotoProfilo"
							src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=u.getIdUtente()%>"
							alt="Foto Attività" />
						</a>
					</div>
					<div class="risultatoRicercaNome">
						<a
							href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.getIdUtente()%>"><%=u.getNome()%>
							<%=u.getCognome()%></a>
					</div>

				</div>
				<div class="risultatoRicercaCentro">

					<div class="risultatoRicercaFoto">
						<a
							href="
							GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=
							<%=a.getIdAbilita()%>"
							class="image featured"> <img class="fotoAttivita"
							src="GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=a.getIdAbilita()%>"
							height="200" width="200" alt="Foto Attività" /></a>
					</div>
					<div class="risultatoRicercaFeedback">
						<%
							int media = utente.getMediaFeedback();
									for (int i = 1; i < 6; i++) {
										if (i <= media) {
						%>
						<a
							href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=u.getIdUtente()%>"
							class="fa fa-star" style="color: #2594c2; float: left;"> </a>

						<%
							} else {
						%>
						<a
							href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=u.getIdUtente()%>"
							class="fa fa-star cuori" style="color: #f8f8f8; float: left;"></a>

						<%
							}
									}
						%>
					</div>
				</div>
				<div class="risultatoRicercaFooter">
					<div class="risultatoRicercaNomeAttivita">
						<a
							href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a.getIdAbilita()%>">
							<%=a.getNomeAbilita()%>
						</a>
					</div>
					<div class="risultatoRicercaMinuti">
						<div class="icon-clock iconcine" style="float: left;"></div>
						<a
							href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a.getIdAbilita()%>">
							<%=a.getMinuti()%>
						</a>
					</div>
					<div class="risultatoRicercaPrezzo">
						<div class="icon-heart iconcine" style="float: left;"></div>
						<a
							href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a.getIdAbilita()%>">
							<%=a.getTariffa()%></a>

					</div>
				</div>
			</article>
			<div class="dataPrenotazione">
				<%=data%>
			</div>
			<div class="oraPrenotazione">
				<%=ora%>
			</div>

			<div style="text-align: center;" class="stato">
				<label>Stato:</label>
				<%
					if (prenotazione.isPagata()) {
				%>
				<label>Pagamento confermato</label>
				<%
					if (!prenotazione.isFeedbackRilasciatoBuyer()) {
				%>
				<a
					href="GestioneFeedbackServlet?to=redirectToPaginaNuovoFeedback&idUtenteDestinatario=<%=u.getIdUtente()%>&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">Rilascia
					Feedback</a>
				<%
					}
							} else if (prenotazione.isConfermataBuyer()
									&& prenotazione.isAccettataSeller()) {
				%><label>PULSANTE PAGAMENTO</label>
				<form
					action="https://www.paypal.com/webapps/adaptivepayment/flow/pay"
					target="PPDGFrame">
					<input id="type" type="hidden" name="expType" value="light">
					<input id="paykey" type="hidden" name="paykey" value="AP-123">
					<input id="preapprovalkey" type="hidden" name="preapprovalkey"
						value="PA-..."> <input type="submit" id="submitBtn"
						value="Pay with PayPal">
				</form>

				<%--CODICE PER IL RITORNO dgFlow = top.dgFlow || top.opener.top.dgFlow;
dgFlow.closeFlow();
top.close(); --%>




				<%
					} else if (!prenotazione.isConfermataBuyer()
									&& prenotazione.isAccettataSeller()) {
				%>
				<a
					href="GestionePrenotazioniServlet?to=SetConfermataBuyer&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">
					CONCLUDI PRENOTAZIONE</a><br /> <a
					href="GestionePrenotazioniServlet?to=SetRifiutata&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">
					ANNULLA PRENOTAZIONE</a>
				<%
					} else {
				%><label>In attesa di una risposta del seller.</label>
				<%
					}
				%>
			</div>
			<%-- parte mia --%>


			<br /> <br /> <br /> <br />

			<%
				//AS A SELLER
					} else {
						Utente u = prenotazione.getUtenteBuyer();
						Abilita a = prenotazione.getAbilita();
						String data = (String) prenotazione.getDataPrenotazione()
								.toString().substring(0, 10);
						String ora = (String) prenotazione.getOrarioPrenotato()
								.toString();
			%>

			<article style="" class="4u special ordine centraTesto ">

				<div class="nomeUtente">
					Utente buyer:&nbsp; <a
						href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.getIdUtente()%>"><%=u.getNome()%>
						<%=u.getCognome()%></a> <br />
				</div>
				<div class="fotoProfilo">
					<img
						src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=u.getIdUtente()%>"
						height="200" alt="Foto Profilo" />
				</div>
				<div class="attivita">
					<label>Attività:</label> <a
						href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a.getIdAbilita()%>"><%=a.getNomeAbilita()%>
					</a>
				</div>
				<div class="rating">
					Rating buyer: <a
						href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=u.getIdUtente()%>">Vedi
						feedback utente</a><br />
				</div>
			</article>
			<div class="dataPrenotazione">
				<%=data%>
			</div>
			<div class="oraPrenotazione">
				<%=ora%>
			</div>
			<div style="text-align: center;" class="stato">
				<label>Stato:</label>
				<%
					if (prenotazione.isPagata()) {
				%><label>Pagamento confermato</label>
				<%
					if (!prenotazione.isFeedbackRilasciatoSeller()) {
				%>
				<a
					href="GestioneFeedbackServlet?to=redirectToPaginaNuovoFeedback&idUtenteDestinatario=<%=u.getIdUtente()%>&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">Rilascia
					Feedback</a>
				<%
					}
							} else if (prenotazione.isConfermataBuyer()
									&& prenotazione.isAccettataSeller()) {
				%><label>In attesa del pagamento</label>
				<%
					} else if (!prenotazione.isConfermataBuyer()
									&& prenotazione.isAccettataSeller()) {
				%>
				<label> In attesa della conferma del cliente</label>
				<%
					} else {
				%>
				<div class="centraTesto">
					<a
						href="GestionePrenotazioniServlet?to=SetAccettataSeller&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">
						ACCETTA OFFERTA</a><br /> <a
						href="GestionePrenotazioniServlet?to=SetRifiutata&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">
						RIFIUTA OFFERTA</a>
				</div>
				<%
					}
				%>
			</div>

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
		</div>
	</section>

</div>
<%@ include file="../footer.jsp"%>