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
		<br /> <br />

		<aside>
			<div class="inside">
				<ul class="insurance">
					<h3>Password dimenticata</h3>
					<br />
					<form action="AutenticazioneServlet?to=passwordDimenticata" method="post">
						<div class="clearfix">
							<input class="input-medium" type="text" placeholder="Email"
								name="email">
						</div>
						<br /> <br />
						<button class="btn small primary" type="submit">Accedi</button>
					</form>
				</ul>
			</div>
		</aside>
	</section>
</div>
<%@ include file="../footer.jsp"%>