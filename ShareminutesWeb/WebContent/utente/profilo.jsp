<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>

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
		<h2>Profilo Utente</h2>
		<br />
		<%
			if (utente.getIdUtente() == tok.getIdUtente()) {
		%>

		<div class="clearfix">
			<a
				href="GestioneUtentiServlet?to=redirectToPaginaModificaProfilo&idUtente=<%=tok.getIdUtente()%>"
				class="btn">Modifica Profilo</a> <br /> <br />
		</div>
		<%
			} else {
		%>
		<div class="clearfix">
			<a
				href="GestioneAmicizieServlet?to=aggiungiFollower&idUtenteFoll=<%=utente.getIdUtente()%>"
				class="btn">Follow</a> <br /> <br />
		</div>
		<%
			}
		%>
		<div class="clearfix">
			<img
				src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=tok.getIdUtente()%>"
				height="200" alt="Foto Profilo" />
		</div>
		<br /> <br />
		<div class="clearfix">
			<label>Headline:</label>
			<%
				String head = "";
				if (utente.getHeadline() != null)
					head = utente.getHeadline();
			%>
			<%=head%>
		</div>
		<br /> <br />
		<div class="clearfix">
			<label>Nome:</label>
			<%
				String nome = "";
				String cognome = "";
				if (utente.getNome() != null)
					nome = utente.getNome();
				if (utente.getCognome() != null)
					cognome = utente.getCognome();
			%>
			<%=nome + " " + cognome%>
		</div>
		<br /> <br />
		<div class="clearfix">
			<label>Location:</label>
			<%
				String citta = "";
				if (utente.getCittaAttuale() != null)
					citta = utente.getCittaAttuale();
			%>
			<%=citta%>
		</div>

		<br /> <br />
		<!-- 
					<div class="clearfix">
						<label>Attività 1:</label>
						<%--=utente.getAbilita()%>
					</div>

					<br /> <br />
					<div class="clearfix">
						<label>Attività 2:</label>
						<%=utente.getAbilita()--%></div>

					<br /> <br /> -->
		<div class="clearfix">
			<label>Biografia:</label>
			<%
				String bio = "";
				if (utente.getBiografia() != null)
					bio = utente.getBiografia();
			%>
			<%=bio%>
		</div>
	</section>
</div>
<%@ include file="../footer.jsp"%>