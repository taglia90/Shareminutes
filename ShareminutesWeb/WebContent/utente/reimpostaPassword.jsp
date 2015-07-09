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
		<br />
		<h2>Reimposta password</h2>
		<form enctype="multipart/form-data"
			action="RegistrazioneServlet?to=modificaPass" method="post">



			<div class="clearfix">
				<label>Password</label>
				<div class="input">
					<input type="password" name="password" />
				</div>
			</div>

			<br /> <br />
			<div class="clearfix">
				<label>Conferma Password</label>
				<div class="input">
					<input type="password" name="confermaPassword" />
				</div>
			</div>

			<br /> <br />
			<div class="actions">
				<button class="btn primary" type="submit">Conferma</button>
				<a href="./RegistrazioneServlet?to=redirectToIndex" class="btn">Annulla</a>
			</div>
		</form>
	</section>
</div>
<%@ include file="../footer.jsp"%>