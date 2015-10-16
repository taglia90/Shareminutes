<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="../header.jsp"%>

<div class="wrapper style1 sfondo">
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
		<br /> <br />

		<div class="loginContainer">
			<div class="logoLogin"></div>
			<div class="inside">
				<ul class="insurance">
					<div class="titoloBlu">Sign in</div>
					<br />
					<form action="AutenticazioneServlet?to=login" method="post">
						<div class="clearfix">
							<input class="input-medium inputLogin" type="text"
								placeholder="Email" name="email">
						</div>

						<div class="clearfix">
							<input class="input-medium inputLogin" type="password"
								placeholder="Password" name="password">
						</div>
						<div class="dimenticata">
							<strong><a
								href="./AutenticazioneServlet?to=redirectToPasswordDimenticata">Password
									dimenticata</a></strong>
						</div>
						<div class="responsiveContainerButton">
							<input type="checkbox" name="remember_me" value="Ricordami">
							Ricordami <br />
							<button class="btn small primary bottone" type="submit">Accedi</button>
					</form>
			</div>
			<br /> <br />
			<div style="width: 40%; margin-left: 30%; text-align: center;">
				<li>oppure <br /> <strong><a
						href="./RegistrazioneServlet?to=redirectToPaginaRegistrazione">Registrati!</a></strong>
				</li>
			</div>
			</ul>
		</div>
	</section>
</div>
</aside>
</section>
</div>
<%@ include file="../footer.jsp"%>