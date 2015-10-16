<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Feedback"%>
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

			<div style="" class="titoloBlu">
				Lista Feedback Ricevuti di <span> <%=(String) session.getAttribute("nomeCognome")%>
				</span>
			</div>
			<%
				List<Feedback> listaFeedbackRicevuti = (List<Feedback>) session
						.getAttribute("listaFeedbackRicevuti");
				if (listaFeedbackRicevuti != null
						&& listaFeedbackRicevuti.size() != 0) {
			%>
			<table class="zebra-striped">

				<div class="listaFeedback">
					<%
						for (Feedback feedback : listaFeedbackRicevuti) {
					%>
					<div class="singoloFeedback">
						<div class="fotoProfiloFeedback">
							<img
								src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=feedback.getUtenteGiudicante().getIdUtente()%>" />
						</div>
						<div class="nomeUtenteFeedback"><%=feedback.getUtenteGiudicante().getNome()%>
							<%=feedback.getUtenteGiudicante().getCognome()%></div>
						<div class="ratingFeedback">
							<%
								int media = feedback.getVotoSintetico();
										for (int i = 1; i < 6; i++) {
											if (i <= media) {
							%>
							<a
								href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=feedback.getUtenteGiudicante()
									.getIdUtente()%>"
								class="fa fa-star" style="color: #2594c2; float: left;"> </a>
							<%
								} else {
							%>
							<a
								href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=feedback.getUtenteGiudicante()
									.getIdUtente()%>"
								class="fa fa-star cuori" style="color: #f8f8f8; float: left;"></a>
							<%
								}
										}
							%>
						</div>


						<div class="sfondoFeedback">
							<div class="votoEsteso"><%=feedback.getVotoEsteso()%></div>
						</div></div>
						<%
							}
						%>

					</div>
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
					<div style="" class="titoloBlu">
						Lista Feedback Rilasciati da <span> <%=(String) session.getAttribute("nomeCognome")%>
						</span>
					</div>

					<table class="zebra-striped">

						<div class="listaFeedback">
							<%
								for (Feedback feedback : listaFeedbackCreati) {
							%>
							<div class="singoloFeedback">
								<div class="fotoProfiloFeedback">
									<img
										src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=feedback.getUtenteRicevente().getIdUtente()%>" />
								</div>
								<div class="nomeUtenteFeedback"><%=feedback.getUtenteRicevente().getNome()%>
									<%=feedback.getUtenteRicevente().getCognome()%></div>
								<div class="ratingFeedback">
									<%
										int media = feedback.getVotoSintetico();
												for (int i = 1; i < 6; i++) {
													if (i <= media) {
									%>
									<a
										href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=feedback.getUtenteRicevente()
									.getIdUtente()%>"
										class="fa fa-star" style="color: #2594c2; float: left;"> </a>
									<%
										} else {
									%>
									<a
										href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=feedback.getUtenteRicevente()
									.getIdUtente()%>"
										class="fa fa-star cuori" style="color: #f8f8f8; float: left;"></a>
									<%
										}
												}
									%>
								</div>


								<div class="sfondoFeedback">
									<div class="votoEsteso"><%=feedback.getVotoEsteso()%></div>
								</div>
								<%
									}
								%>

							</div>
							<%
								} else {
							%>
							<strong>Non ci sono feedback rilasciati.</strong>
							<%
								}
							%>
						</div>
						</section>

						</div>
						<%@ include file="../footer.jsp"%>