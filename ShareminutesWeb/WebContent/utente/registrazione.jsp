<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en">
<head>
<title>SWIMv2 - Registrazione</title>
<meta name="description" content="Registrazione" />
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
					<li><a href="RegistrazioneServlet?to=redirectToIndex">Sign
							in</a></li>
					<li class="current"><a
						href="RegistrazioneServlet?to=redirectToPaginaRegistrazione">Sign
							up</a></li>
					<%
						} else {
					%>
					<li><a
						href="GestioneRicercheServlet?to=redirectToPaginaRicerca">Search</a></li>
					<li><a href="#">Profile</a>
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
				<div class="inside">
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
					<h2>Registrazione</h2>
					<form enctype="multipart/form-data"
						action="RegistrazioneServlet?to=salvaDatiUtente" method="post">


						<div class="clearfix">
							<label>Nome</label>
							<div class="input">
								<input type="text" name="nome" />
							</div>
						</div>

						<br /> <br />
						<div class="clearfix">
							<label>Cognome</label>
							<div class="input">
								<input type="text" name="cognome" />
							</div>
						</div>

						<br /> <br />
						<div class="clearfix">
							<label>Email</label>
							<div class="input">
								<input type="text" name="email" />
							</div>
						</div>

						<br /> <br />

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
						<!-- <div class="clearfix">
							<label for="fileInput">Foto</label>
							<div class="input">
								<input id="fileInput" class="input-file" type="file" name="foto">
									<span class="help-block"> Deve avere estensione jpg, png
										o gif e dimensione inferiore a 1Mb </span>
							</div>
						</div>
						<br /> <br /> -->
						<div class="actions">
							<button class="btn primary" type="submit">Conferma</button>
							<a href="./RegistrazioneServlet?to=redirectToIndex" class="btn">Annulla</a>
						</div>
					</form>
				</div>
				</section>
			</div>
			<!-- footer -->
			<footer>
			<div class="inside">Sviluppato da Marco Tagliabue</div>
			</footer>
		</div>
	</div>
</body>
</html>