<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>
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
		<h2>Ricerca tra le Attività</h2>
		<p>
			<a
				href="GestioneRicercheServlet?to=redirectToPaginaRicercaUtenteNonLoggato">Ricerca</a>
		</p>
		<%
			List<Abilita> listaAbilita = (List<Abilita>) session
					.getAttribute("listaAbilita");
			if (listaAbilita != null && listaAbilita.size() != 0) {
		%>
		<form enctype="multipart/form-data"
			action="GestioneRicercheServlet?to=ricercaUtenteNonLoggato"
			method="post" name="form">
			<select name="abilitaScelta">
				<%
					for (Abilita abilita : listaAbilita) {
				%>
				<option value="<%=abilita.getIdAbilita()%>"><%=abilita.getNomeAbilita()%></option>
				<%
					}
				%>
			</select> <br /> <br /> <br /> <br />
			<div class="actions">
				<button class="btn primary" type="submit">Conferma</button>
				<a href="GestioneUtentiServlet?to=redirectToPaginaProfilo"
					class="btn">Annulla</a>
			</div>
		</form>
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
					<td><img src="./images/logo.png" alt="START SHARING" /><br />
						<br />FAQ con eventuali link.<br /> <br /> <br /></td>
				</tr>
			</tbody>
		</table>

	</section>
</div>
<%@ include file="../footer.jsp"%>