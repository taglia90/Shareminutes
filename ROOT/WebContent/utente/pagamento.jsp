<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>

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
			<div style="" class="titoloBlu">Metodo di pagamento</div>
			<br />
			<%
				utente = (Utente) session.getAttribute("utente");
			%>
			<form action="GestioneUtentiServlet?to=salvaMetodoPagamento"
				method="post">

				<div class="clearfix">
					<%
						String emailPayPal = "";
						if (utente.getEmailPayPal() != null)
							emailPayPal = utente.getEmailPayPal();
					%>
					<label>Inserire l'email di PayPal:</label>
					<div class="input">
						<input type="text" name="emailPayPal" value="<%=emailPayPal%>" />
					</div>
				</div>
				<br />
				<div class="actions">
					<button class="bottoneMedium" type="submit">Conferma</button>
					<a
						href="./GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=tok.getIdUtente()%>"
						class="">Annulla</a>
				</div>
			</form>
	</section>
</div>
</div>
<%@ include file="../footer.jsp"%>