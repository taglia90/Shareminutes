<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<title>Shareminutes</title>
<meta name="description" content="Shareminutes" />
<meta charset="utf-8" />
<link rel="stylesheet" href="css/reset.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/layout.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<script type="text/javascript" src="js/maxheight.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<!--[if lt IE 7]>
	<link rel="stylesheet" href="css/ie6.css" type="text/css" media="screen">
	<script type="text/javascript" src="js/ie_png.js"></script>
	<script type="text/javascript">
		ie_png.fix('.png');
	</script>
<![endif]-->
<!--[if lt IE 9]>
	<script type="text/javascript" src="js/html5.js"></script>
<![endif]-->
</head>
<body id="page1" onLoad="new ElementMaxHeight();">
	<div class="tail-bottom">
		<div id="main">
			<!-- header -->
			<header>
			<div class="nav-box">
				<nav>
				<ul class="nav">
					<li class="current"><a href="#">Logo</a></li>
					<li><a
						href="GestionePagineServlet?to=redirectToPaginaCommunity">Community</a></li>
					<li><a href="GestionePagineServlet?to=redirectToPaginaSell">Sell</a></li>
					<li><a href="GestionePagineServlet?to=redirectToPaginaBuy">Buy</a></li>

					<%
						LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
						if (tok == null) {
					%>
					<li><a
						href="GestioneRicercheServlet?to=redirectToPaginaRicercaUtenteNonLoggato">Search</a></li>
					<li class="current"><a
						href="RegistrazioneServlet?to=redirectToIndex">Sign in</a></li>
					<li><a
						href="RegistrazioneServlet?to=redirectToPaginaRegistrazione">Sign
							up</a></li>
					<%
						} else {
					%>
					<li><a
						href="GestioneRicercheServlet?to=redirectToPaginaRicerca">Search</a></li>
					<li><a
						href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=tok.getIdUtente()%>">Profile</a>
						<ul>
							<li><a
								href="GestionePagineServlet?to=redirectToGestioneOrdini">Gestione
									ordini</a></li>
							<li><a
								href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback">Rating</a></li>
							<li><a
								href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaUser">Attività</a></li>
							<li><a
								href="GestioneRichiesteServlet?to=redirectToPaginaRichieste">Messaggi</a></li>
							<li><a
								href="GestionePagineServlet?to=redirectToClientiEFornitori">Clienti
									&amp; fornitori</a></li>
							<li><a
								href="GestioneAmicizieServlet?to=redirectToPaginaAmicizie">Followers</a></li>
							<li><a href="GestionePagineServlet?to=redirectToPreferiti">I
									miei preferiti</a></li>
						</ul></li>
					<li><a
						href="GestioneRichiesteServlet?to=redirectToPaginaRichieste">Mail</a></li>
					<%
						}
					%>
				</ul>
				</nav>

			</div>
			<h1>
				<!-- <a href="index.jsp">SWIMv2</a> -->
			</h1>
			</header>
			<div class="wrapper indent">
				<!-- content -->
				<section id="content"> <%
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
				%> <%
 	String successo = (String) session.getAttribute("Successo");
 	if (successo != null) {
 %>
				<div class="alert-message info">
					<%=successo.toString()%>
				</div>
				<%
					session.removeAttribute("Successo");
					}
				%> <br />
				<br />
				<label>Copertina</label>
				<div>
					<img src="images/logo.png">
				</div>
				<br />
				<br />
				<label>Top rated</label>
				<div>
					<img src="images/logo.png">
				</div>
				<br />
				<br />
				<label>link</label>
				<div>
					<img src="images/logo.png">
				</div>
				<br />
				<br />
				<label>Video</label>
				<div>
					<img src="images/logo.png">
				</div>
				<br />
				<br />
				<label>Press</label>
				<div>
					<img src="images/logo.png">
				</div>
				<br />
				</section>
				<!-- aside -->
				<aside>
				<div class="inside">
					<ul class="insurance">
						<h3>Autenticazione</h3>
						<br />
						<form action="AutenticazioneServlet?to=login" method="post">
							<div class="clearfix">
								<input class="input-medium" type="text" placeholder="Email"
									name="email">
							</div>
							<br /> <br />
							<div class="clearfix">
								<input class="input-medium" type="password"
									placeholder="Password" name="password"> <br /> <br />
							</div>
							<input type="checkbox" name="remember_me" value="Ricordami">
								Ricordami <br />
								<button class="btn small primary" type="submit">Accedi</button>
						</form>
						<br />
						<li>oppure <br /> <strong><a
								href="./RegistrazioneServlet?to=redirectToPaginaRegistrazione">Registrati!</a></strong>
						</li>
					</ul>
				</div>
				</aside>
			</div>
			<!-- footer -->
			<footer>
			<div class="inside">Sviluppato da Marco Tagliabue</div>
			</footer>
		</div>
	</div>
</body>
</html>