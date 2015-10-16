<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>
<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="../headerSfondo.jsp"%>
<div class="sliderRicerca">

	<h1>
		<div class="containerSliderRicerca">
			<a href="index.html" class="testoGrandeHome">PIU' VALORE AL TUO
				TEMPO</a>
		</div>
	</h1>


	<div class="responsiveContainerButton">
		<input class="inputHome" type="text" /> <a href="#banner"
			class="bottone">SEARCH</a>
	</div>
</div>
<div class="contenitoreRicerca">
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
			<div class="titoloBlu">Risultato ricerca</div>
			<div class="wrapper style1">

				<section id="features" class="container special">

					<div class="row">
						<%
							List<Abilita> listaAbilita = (List<Abilita>) session
									.getAttribute("listaAbilita");
							if (listaAbilita != null && listaAbilita.size() != 0) {
						%>


						<%
							for (Abilita abilita : listaAbilita) {
									List<Utente> u = (List<Utente>) abilita.getUtente();
						%>

						<article class="4u special">
							<div class="risultatoRicercaHeader">
								<div class="risultatoRicercaFotoProfilo">
									<a
										href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.get(0).getIdUtente()%>">
										<img class="risultatoRicercaFotoProfilo"
										src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=u.get(0).getIdUtente()%>"
										alt="Foto Attività" />
									</a>
								</div>
								<div class="risultatoRicercaNome">
									<a
										href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.get(0).getIdUtente()%>"><%=u.get(0).getNome() + " " + u.get(0).getCognome()%>
									</a>
								</div>
								<div class="risultatoRicercaCitta">
									<a
										href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.get(0).getIdUtente()%>"><%=u.get(0).getCittaAttuale()%>
									</a>
									<div class="icon-map_pin iconcine" style=""></div>
								</div>
							</div>
							<div class="risultatoRicercaCentro">

								<div class="risultatoRicercaFoto">
									<a
										href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>"
										class="image featured"> <img class="fotoAttivita"
										src="GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=abilita.getIdAbilita()%>"
										height="200" width="200" alt="Foto Attività" /></a>
								</div>
								<div class="risultatoRicercaFeedback">
									<%
										int media = u.get(0).getMediaFeedback();
												for (int i = 1; i < 6; i++) {
													if (i <= media) {
									%>
									<a
										href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=u.get(0).getIdUtente()%>"
										class="fa fa-star" style="color: #2594c2; float: left;"> </a>
									<%
										} else {
									%>
									<a
										href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=u.get(0).getIdUtente()%>"
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
										href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>">
										<%=abilita.getNomeAbilita()%>
									</a>
								</div>
								<div class="risultatoRicercaMinuti">
									<div class="icon-clock iconcine" style="float: left;"></div>
									<a
										href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>">
										<%=abilita.getMinuti() + "min"%>
									</a>
								</div>
								<div class="risultatoRicercaPrezzo">
									<div class=" fa fa-eur iconcine" style="float: left;"></div>
									<a
										href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>">
										<%=abilita.getTariffa()%></a>

								</div>
							</div>
						</article>
						<%
							}
							} else {
						%>
						<strong>Nessun risultato trovato.</strong>
						<%
							}
						%>

					</div>
				</section>

			</div>

			<br /> <br />



		</section>
	</div>
</div>
<%@ include file="../footer.jsp"%>