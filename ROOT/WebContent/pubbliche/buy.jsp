<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>
<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="../headerSfondo.jsp"%>
<div class="sliderHome">

	<h1>
		<div class="containerSlider">
			<a href="index.html" class="testoGrandeHome">PIU' VALORE AL TUO
				TEMPO</a>
		</div>
	</h1>
	<div class="sottotitoloHome">
		<p>SOTTOTITOLO SHAREMINUTES HOME</p>
	</div>

	<div class="responsiveContainerButton">
		<input class="inputHome" type="text" /> <a href="#banner"
			class="bottone">SEARCH</a>
	</div>
</div>
<div class="contenitoreStretto">
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
		<div style="margin-top:330px !important; " class="modificaProfiloContainer">
		
		<div style="" class="titoloBlu">Ricerca tra le Attività</div>
		<p style="text-align:center !important;">
			<a
				href="GestioneRicercheServlet?to=redirectToPaginaRicercaUtenteNonLoggato">Ricerca</a>
		</p>
		<%
			List<Abilita> listaAbilita = (List<Abilita>) session
					.getAttribute("listaAbilita");
			if (listaAbilita != null && listaAbilita.size() != 0) {
		%><div style="width:40%; margin-left:30%;">
		<form style="width:100% !important;" enctype="multipart/form-data"
			action="GestioneRicercheServlet?to=ricercaUtenteNonLoggato"
			method="post" name="form">
			<select style="width:100% !important;" name="stringa">
				<%
					for (Abilita abilita : listaAbilita) {
				%>
				<option value="<%=abilita.getIdAbilita()%>"><%=abilita.getNomeAbilita()%></option>
				<%
					}
				%>
			</select> <br />
			<div class="actions">
			<div class="confermaAnnulla">
				<div class="conferma"><button class="btn primary bottoneFull" type="submit">Conferma</button></div>
				<br />
				<div class="annulla"><a href="GestioneUtentiServlet?to=redirectToPaginaProfilo"
					class="btn">Annulla</a></div></div>
			</div>
		</form>
		</div>
		<br />
		<%
			} else {
		%>
		<strong>Non ci sono abilità tra cui fare la ricerca.</strong>
		<%
			}
		%>

		<table class="zebra-striped">
			<thead>
				<tr>
					<th>MAIN CLAIM SHAREMINUTES COMMUNITY</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><img src="./images/logo.png" alt="START SHARING" /><br />
						<br /> <a
						href="GestioneRicercheServlet?to=redirectToPaginaRicercaUtenteNonLoggato">
							Ricerca</a><br /> <br /> <br /></td>
				</tr>
				<tr>
					<td><img src="./images/logo.png" alt="START SHARING" /><br />
						<br />NUM clienti
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						NUM minuti condivisi
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						EURO stimati di transazioni<br /> <br /> <br /></td>

				</tr>
				<tr>
					<td><img src="./images/logo.png" alt="START SHARING" /><br />
						<br />Inserire foto attività con link all'attività completa.<br />
						<br /> <br /></td>
				</tr>
				<tr>
					<td><img src="./images/logo.png" alt="START SHARING" /><br />
						<br />Schema grafico di come comprare<br /> <br /> <br /></td>
				</tr>
				<tr>
		
				</tr>
			</tbody>
		</table>
<div class="row">
			<article class="4u special">
				<div class="titoloFaq"> Titolo FAQ</div>
				<div class="testoFaq"> Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ</div>
			</article>
			<article class="4u special">
			<div class="titoloFaq"> Titolo FAQ</div>
				<div class="testoFaq"> Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ</div>
			

			</article>
			<article class="4u special">
			<div class="titoloFaq"> Titolo FAQ</div>
				<div class="testoFaq"> Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ</div>
			

			</article>
		</div>
		<div class="row">
			<article class="4u special">
				<div class="titoloFaq"> Titolo FAQ</div>
				<div class="testoFaq"> Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ</div>
			</article>
			<article class="4u special">
			<div class="titoloFaq"> Titolo FAQ</div>
				<div class="testoFaq"> Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ</div>
			

			</article>
			<article class="4u special">
			<div class="titoloFaq"> Titolo FAQ</div>
				<div class="testoFaq"> Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ Testo FAQ</div>
			

			</article>
		</div>
		<br />
		</div>
	</section>
</div>
</div>
<%@ include file="../footer.jsp"%>