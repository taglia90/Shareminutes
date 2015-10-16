<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Richiesta"%>
<%@ page import="java.util.List"%>
<%@ page import="entity.Messaggio"%>

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

		<div class="modificaProfiloContainer">

			<div style="" class="titoloBlu">Lista Messaggi Ricevuti</div>
			<%
				List<Richiesta> listaRichiesteRicevute = (List<Richiesta>) session
						.getAttribute("listaRichiesteRicevute");
				List<Messaggio> listaMessaggi = (List<Messaggio>) session
						.getAttribute("listaMessaggi");
				//int k =listaMessaggi.size();
				//if(k>0){
				//	Messaggio mess =listaMessaggi.get(k-1);}

				if (listaRichiesteRicevute != null
						&& listaRichiesteRicevute.size() != 0) {
			%>
			<div class="tabellaRichieste">
				<%
					for (Richiesta richiesta : listaRichiesteRicevute) {
				%>
				<div class="singoloOrdine">
					<%
						int lettoDa = richiesta.getLettoDa();

								if (lettoDa != 0 && lettoDa != tok.getIdUtente()) {
					%>
					<div class="notifica"></div>
					<%
						}
								GestioneRichiesteServlet gr = new GestioneRichiesteServlet();
								List<Messaggio> lm = gr.recuperaListaMessaggi(richiesta
										.getIdRichiesta());
								Messaggio m = lm.get(lm.size() - 1);
					%>
					<div class="fotoProfiloFeedback">
						<img
							src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=richiesta.getUtenteMittente().getIdUtente()%>" />
					</div>
					<div class="nomeUtenteFeedback"><%=richiesta.getUtenteMittente().getNome()%>
						<%=richiesta.getUtenteMittente().getCognome()%></div>

					<%--<div class="oggettoMessaggio"><%=richiesta.getOggettoRichiesta()%></div> --%>
					<div class="sfondoAnteprimaMessaggio">
						<div class="anteprimaMessaggio"><%=m.getCorpoMessaggio()%></div>
					</div>
					<div class="vaiADettaglioOrdine">
						<a
							href="GestioneRichiesteServlet?to=redirectToPaginaDettaglioRichiesta&idRichiesta=<%=richiesta.getIdRichiesta()%>">Visualizza
							conversazione</a>
					</div>
				</div>
				<%
					}
				%>

			</div>
			<%
				} else {
			%>
			<strong>Non ci sono messaggi.</strong>
			<%
				}
			%>
		</div>
		<div style="margin-top: 50px !important;"
			class="modificaProfiloContainer">

			<div style="" class="titoloBlu">Lista Messaggi Mandati</div>
			<%
				List<Richiesta> listaRichiesteMandate = (List<Richiesta>) session
						.getAttribute("listaRichiesteMandate");
				if (listaRichiesteMandate != null
						&& listaRichiesteMandate.size() != 0) {
			%>
			<div class="tabellaRichieste">

				<%
					for (Richiesta richiesta : listaRichiesteMandate) {
				%>
				<div class="singoloOrdine">
					<%
						int lettoDa = richiesta.getLettoDa();

								if (lettoDa != 0 && lettoDa != tok.getIdUtente()) {
					%>
					<div class="notifica"></div>
					<%
						}
								GestioneRichiesteServlet gr = new GestioneRichiesteServlet();
								List<Messaggio> lm = gr.recuperaListaMessaggi(richiesta
										.getIdRichiesta());
								Messaggio m = lm.get(lm.size() - 1);
					%>
					<div class="fotoProfiloFeedback">
						<img
							src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=richiesta.getUtenteDestinatario().getIdUtente()%>" />
					</div>
					<div class="nomeUtenteFeedback">
						<a
							href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=richiesta.getUtenteDestinatario().getIdUtente()%>"><%=richiesta.getUtenteDestinatario().getNome()%>
							<%=richiesta.getUtenteDestinatario().getCognome()%></a>
					</div>

					<%--	<div class="oggettoMessaggio"><%=richiesta.getOggettoRichiesta()%></div> --%>
					<div class="sfondoAnteprimaMessaggio"><%=m.getCorpoMessaggio()%></div>
					<div class="vaiADettaglioOrdine">
						<a
							href="GestioneRichiesteServlet?to=redirectToPaginaDettaglioRichiesta&idRichiesta=<%=richiesta.getIdRichiesta()%>">Visualizza
							conversazione</a>
					</div>
				</div>
				<%
					}
				%>

			</div>
			<%
				} else {
			%>
			<strong>Non ci sono messaggi.</strong>
			<%
				}
			%>
		</div>
	</section>

</div>
<%@ include file="../footer.jsp"%>