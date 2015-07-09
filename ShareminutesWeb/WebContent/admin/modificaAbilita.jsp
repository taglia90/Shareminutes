<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Abilita"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="../header.jsp"%>

<div class="wrapper style1">
	<section id="features" class="container special">
		<%
			tok = (LoginToken) session.getAttribute("LoginToken");
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
			Abilita abilita = (Abilita) session.getAttribute("abilita");
		%>
		<br />
		<h2>
			Modifica abilità "<%=abilita.getNomeAbilita()%>"
		</h2>
		<form
			action="GestioneAbilitaServlet?to=modificaAbilita&idAbilita=<%=abilita.getIdAbilita()%>"
			method="post" name="form">
			<div class="clearfix">
				<label>Nome</label>
				<div class="input">
					<input type="text" name="nome"
						value="<%=abilita.getNomeAbilita()%>" />
				</div>
			</div>
			<br /> <br />
			<div class="clearfix">
				<label for="textarea">Descrizione</label>
				<div class="input">
					<textarea id="textarea2" class="xxlarge" rows="10" cols="120"
						name="descrizione"><%=abilita.getDescrizioneAbilita()%></textarea>
				</div>
			</div>
			<br /> <br />
			<div class="actions">
				<button class="btn primary" type="submit">Conferma</button>
				<a
					href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaAdmin"
					class="btn">Annulla</a>
			</div>
		</form>
	</section>
</div>
<%@ include file="../footer.jsp"%>