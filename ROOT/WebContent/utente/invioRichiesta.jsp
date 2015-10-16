<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>

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
			String idUtenteDestinatario = (String) session
					.getAttribute("idUtenteDestinatario");
			String idRichiesta = (String) session.getAttribute("idRichiesta");
			if (idUtenteDestinatario != null) {
		%>
		<br />
		<h2>Invia richiesta</h2>
		<form
			action="GestioneRichiesteServlet?to=creaNuovaRichiesta&idUtenteDestinatario=<%=idUtenteDestinatario%>"
			method="post" name="form">
			<div class="clearfix">
				<div class="input">
					<!-- <label for="textarea">Destinatario: <%--=idUtenteDestinatario--%>
					</label> -->
				</div>
			</div>
			<br /> <br />
			<div class="clearfix">
				<label for="textarea">Oggetto</label>
				<div class="input">
					<textarea id="textarea2" class="xxlarge" rows="5" cols="50"
						name="oggettoRichiesta"></textarea>
				</div>
			</div>
			<br />
			<div class="clearfix">
				<label for="textarea">Inserisci il tuo messaggio</label>
				<div class="input">
					<textarea id="textarea2" class="xxlarge" rows="10" cols="120"
						name="corpoMessaggio"></textarea>
				</div>
			</div>
			<br />
			<div class="clearfix"></div>
			<div class="actions">
				<button class="btn primary" type="submit">Conferma</button>
				<a href="GestioneRicercheServlet?to=redirectToPaginaRicerca"
					class="btn">Annulla</a>
			</div>
		</form>
		<%
			} else if (idRichiesta != null) {
		%>
		<h2>Crea nuovo messaggio.</h2>

		<form
			action="GestioneRichiesteServlet?to=creaNuovaMessaggio&idRichiesta=<%=idRichiesta%>"
			method="post" name="form">

			<div class="clearfix">
				<label for="textarea">Corpo</label>
				<div class="input">
					<textarea id="textarea2" class="xxlarge" rows="20" cols="50"
						name="corpoMessaggio"></textarea>
					<span class="help-block"> Inserisci il tuo messaggio. </span>
				</div>
			</div>

			<div class="clearfix"></div>

			<div class="actions">
				<button class="btn primary" type="submit">Conferma</button>
				<a
					href="./AutenticazioneServlet?to=login&username=<%=tok.getEmail()%>&password=<%=tok.getEmail()%>"
					class="btn">Annulla</a>
			</div>
		</form>
		<%
			} else {
		%>
		<strong>Errore, perfavore ripeti i passaggi per inoltrare un
			nuovo messaggio.</strong>
		<%
			}
		%>

	</section>

</div>
<%@ include file="../footer.jsp"%>