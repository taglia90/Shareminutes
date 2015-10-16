<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Abilita"%>
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

			<div style="" class="titoloBlu">Lista attività</div>
			<br />
			<%
				List<Abilita> listaAbilita = (List<Abilita>) session
						.getAttribute("listaAbilita");
				if (listaAbilita != null && listaAbilita.size() != 0) {
			%>
			<table class="zebra-striped">
				<%-- INIZIO MIO --%>
				<div class="row">



					<%
						for (Abilita abilita : listaAbilita) {
					%>

					<article class="4u special">

						<div class="listaAbilitaCentro">

							<div class="listaAbilitaFoto">
								<a
									href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>"
									class="image featured"> <img class="fotoAttivita"
									src="GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=abilita.getIdAbilita()%>"
									width=100% " alt="Foto Attività" /></a>
							</div>

							<a class="modificaAbilita"
								href="GestioneAbilitaServlet?to=redirectToPaginaModificaAbilita&idAbilita=<%=abilita.getIdAbilita()%>">

							</a>

						</div>
						<div class="risultatoRicercaFooter">
							<div class="listaAttivitaNome">
								<a
									href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>">
									<%=abilita.getNomeAbilita()%>
								</a>
							</div>

						</div>
					</article>


					<%
						}
					%>
					<article class="4u special">

						<div class="listaAbilitaCentro">

							<div class="listaAbilitaFoto">
								<a
									href="GestioneAbilitaServlet?to=redirectToPaginaCreazioneAbilita"
									class="image featured"> <img class="immagineNuovaAttivita"
									width=100% " src="images/boxVuoto.jpg" />
								</a>

							</div>

							<a class="aggiungiAbilita"
								href="GestioneAbilitaServlet?to=redirectToPaginaCreazioneAbilita">

							</a>

						</div>
						<div class="risultatoRicercaFooter">
							<div class="listaAttivitaNome">
								<a style="color: rgba(0, 0, 0, 0.4);"
									href="GestioneAbilitaServlet?to=redirectToPaginaCreazioneAbilita">
									Aggiungi una nuova abilità. </a>
							</div>

						</div>
					</article>
					<%
						} else {
					%>
					<article class="4u special">

						<div class="listaAbilitaCentro">

							<div class="listaAbilitaFoto">
								<a
									href="GestioneAbilitaServlet?to=redirectToPaginaCreazioneAbilita"
									class="image featured"> <img class="immagineNuovaAttivita"
									width=100% " src="images/boxVuoto.jpg" />
								</a>

							</div>

							<a class="aggiungiAbilita"
								href="GestioneAbilitaServlet?to=redirectToPaginaCreazioneAbilita">

							</a>

						</div>
						<div class="risultatoRicercaFooter">
							<div class="listaAttivitaNome">
								<a style="color: rgba(0, 0, 0, 0.4);"
									href="GestioneAbilitaServlet?to=redirectToPaginaCreazioneAbilita">
									Aggiungi una nuova abilità. </a>
							</div>

						</div>
					</article>

					<%
						}
					%>

				</div>
				<%-- FINE MIO --%>

			</table>

			<br /> <br /> <br /> <br />
			<!-- <a
						href="GestioneAbilitaServlet?to=redirectToPaginaAggiungiAbilitaUtente">Aggiungi
						o elimina le tue abilità.</a>-->
		</div>
	</section>
</div>
<%@ include file="../footer.jsp"%>