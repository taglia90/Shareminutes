<%@page import="entity.Abilita"%>
<%@ page import="entity.Utente"%>
<%@ page import="java.util.List"%>
<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="../header.jsp"%>

<div style="margin-top: 150px;" class="wrapper style1">
	<section id="features" class="container special">
		<div class="ricercaContainer">
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
			<h2>Risultato ricerca</h2>
			<h3>
				Per visualizzare i dettagli della ricerca o effettuare una prenotazione <strong><a
					href="GestionePagineServlet?to=redirectToLogin">accedi</a></strong> o <strong><a
					href="GestioneRicercheServlet?to=redirectToPaginaRegistrazione">registrati</a></strong>.
			</h3>
			<div class="wrapper style1">

				<section id="features" class="container special">

					<div class="row">

						<%
							List<Abilita> listaAbilita = (List<Abilita>) session
									.getAttribute("listaAbilita");
							if (listaAbilita != null && listaAbilita.size() != 0) {
						%>
						<%
							for (Abilita a : listaAbilita) {
						%>
						<article class="4u special">
							<div class="risultatoRicercaHeader">
								<div class="risultatoRicercaNome">
									<%=a.getNomeAbilita()%>
								</div>
								<div class="risultatoRicercaCitta">
									<%=a.getCittaDoveOffreServizio()%>
								</div>
							</div>
							<div class="risultatoRicercaCentro">
								<div class="risultatoRicercaFoto">
									<img class="fotoAttivita"
										src="GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=a.getIdAbilita()%>"
										height="200" width="200" alt="Foto Attività"
										class="image featured" />
								</div>
							</div>
							<div class="risultatoRicercaFooter">
								<div class="risultatoRicercaNomeAttivita">
									<%=a.getNomeAbilita()%>
								</div>
								<div class="risultatoRicercaMinuti">
									<div class="icon-clock iconcine" style="float: left;"></div>
									<%=a.getMinuti()%>
								</div>
								<div class="risultatoRicercaPrezzo">
									<div class="icon-heart iconcine" style="float: left;"></div>
									<%=a.getTariffa() + "min"%>
								</div>
							</div>
						</article>
						<%
							}
						%>

						<%
							} else {
						%>
						<strong>La ricerca non ha prodotto risultati.</strong>
						<%
							}
						%>
					</div>
				</section>
			</div>
		</div>
	</section>
</div>

<%@ include file="../footer.jsp"%>