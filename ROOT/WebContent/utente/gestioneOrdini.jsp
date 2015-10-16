<%@page import="entity.Prenotazione"%>
<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Richiesta"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="../header.jsp"%>

<div class="wrapper style1 conSecondoMenu">
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

		<div class="modificaProfiloContainer">

			<div style="" class="titoloBlu">Lista ordini as a buyer</div>
			<%
				List<Prenotazione> listaOrdiniAsABuyer = (List<Prenotazione>) session
						.getAttribute("listaOrdiniAsABuyer");
				if (listaOrdiniAsABuyer != null && listaOrdiniAsABuyer.size() != 0) {
			%>
			<div class="tabellaOrdini">
				
				
					<%
						for (Prenotazione prenotazione : listaOrdiniAsABuyer) {
					%>
					<div class="singoloOrdine">
						<%
							if (prenotazione.isAccettataSeller()
											&& !prenotazione.isPagata()
											|| !prenotazione.isFeedbackRilasciatoBuyer()) {
						%>
						<div class="notifica"></div>
						<%
							}
						%>

						<div class="dataPrenotazioneOrdine"><%=prenotazione.getDataPrenotazione().toString()
							.substring(0, 10)%></div>
						<div class="fotoProfiloFeedback"><img
								src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=prenotazione.getUtenteSeller().getIdUtente()%>" />
						</div>
						<div class="nomeUtenteFeedback"><a href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=prenotazione.getUtenteSeller().getIdUtente()%>"><%=prenotazione.getUtenteSeller().getNome()%> <%=prenotazione.getUtenteSeller().getCognome()%></a></div>
						
						<div class="abilitaOrdine"><a href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=
							<%=prenotazione.getAbilita().getIdAbilita()%>"><%=prenotazione.getAbilita().getNomeAbilita()%></a></div>
				
						<div class="vaiADettaglioOrdine"><a
							href="GestionePagineServlet?to=redirectToDettaglioOrdine&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">Visualizza
								ordine </a></div>
					</div>
					<%
						}
					%>
				
			</div>
			<%
				} else {
			%>
			<strong>Non ci sono ordini.</strong>
			<%
				}
			%>

		</div>
		<div style="margin-top: 50px !important;"
			class="modificaProfiloContainer">

			<div style="" class="titoloBlu">Lista ordini as a seller</div>
			<%
				List<Prenotazione> listaOrdiniAsASeller = (List<Prenotazione>) session
						.getAttribute("listaOrdiniAsASeller");
				if (listaOrdiniAsASeller != null
						&& listaOrdiniAsASeller.size() != 0) {
			%>
			<div class="tabellaOrdini">
				
				
					<%
						for (Prenotazione prenotazione : listaOrdiniAsASeller) {
					%>
					<div class="singoloOrdine">
						<%
							if ((!prenotazione.isAccettataSeller()
											|| prenotazione.isConfermataBuyer()
											|| prenotazione.isPagata())
											&& !prenotazione.isFeedbackRilasciatoSeller()) {
						%>
							
				
						<div class="notifica"></div>
						<%
							}
						%>

						<div class="dataPrenotazioneOrdine"><%=prenotazione.getDataPrenotazione().toString()
							.substring(0, 10)%></div>
						<div class="fotoProfiloFeedback"><img
								src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=prenotazione.getUtenteBuyer().getIdUtente()%>" />
						</div>
						<div class="nomeUtenteFeedback"><a href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=prenotazione.getUtenteBuyer().getIdUtente()%>"><%=prenotazione.getUtenteBuyer().getNome()%> <%=prenotazione.getUtenteSeller().getCognome()%></a></div>
						
						<div class="abilitaOrdine"><a href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=
							<%=prenotazione.getAbilita().getIdAbilita()%>"><%=prenotazione.getAbilita().getNomeAbilita()%></a></div>
				
						<div class="vaiADettaglioOrdine"><a
							href="GestionePagineServlet?to=redirectToDettaglioOrdine&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">Visualizza
								ordine </a></div>
					</div>
					<%
						}
					%>
				
			</div>
			<%
				} else {
			%>
			<strong>Non ci sono ordini.</strong>
			<%
				}
			%>
		</div>
	</section>
</div>
<%@ include file="../footer.jsp"%>