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
		<h2>Ricerca</h2>
		<form enctype="multipart/form-data"
			action="GestioneRicercheServlet?to=ricercaUtenteNonLoggato" method="post">
			<div class="clearfix">
				<label>Inserisci un'attività, un tag (o parte di essi).</label>
				<div class="input">
					<input type="text" name="stringa" />
				</div>
				<br /> <label>Inserisci una città (o parte di essa) </label>
				<div class="input">
					<input type="text" name="citta" />
				</div>

			</div>
			<br /> <br /> <br /> <br />
			<div class="actions">
			<div class="responsiveContainerBasutton">
				<button class="btn primary bottone" type="submit">Cerca</button>
			</div>
			
		</form>
	</section>
</div>
<%@ include file="../footer.jsp"%>