<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<title>Sell</title>
<meta name="description" content="Community" />
<meta charset="utf-8" />
<link rel="stylesheet" href="css/reset.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/layout.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
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
<body id="page3">
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
					<li class="current"><a href="#">Sell</a></li>
					<li><a href="GestionePagineServlet?to=redirectToPaginaBuy">Buy</a></li>

					<%
						LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
						if (tok == null) {
					%>
					<li><a
						href="GestioneRicercheServlet?to=redirectToPaginaRicercaUtenteNonLoggato">Search</a></li>
					<li><a href="RegistrazioneServlet?to=redirectToIndex">Sign
							in</a></li>
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
				<section id="content">
				<div>
					<br />
					<h2>Sell</h2>
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
										Ricerca</a><br /><br /><br /></td>
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
									EURO stimati di transazioni<br /><br /><br /></td>

							</tr>
							<tr>
								<td><img src="./images/logo.png" alt="START SHARING" /><br />
									<br />Inserire foto utente con link al profilo completo.<br /><br /><br /></td>
							</tr>
							<tr>
								<td><img src="./images/logo.png" alt="START SHARING" /><br />
									<br />Schema grafico di come funziona shareminutes<br /><br /><br /></td>
							</tr>
							<tr>
								<td><img src="./images/logo.png" alt="START SHARING" /><br />
									<br />FAQ con eventuali link.<br /><br /><br /></td>
							</tr>
						</tbody>
					</table>

					<br />
				</div>
				</section>
				<!-- aside -->
				<aside>
				<div class="inside">
					<div class="well"></div>
					<br /> <br />
					<div class="well">
						<table class="zebra-striped">
							<tbody>
								<tr>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
					<br /> <br />

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