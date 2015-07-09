<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<title>Shareminutes</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="description" content="Shareminutes" />
<meta name="keywords" content="" />
<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
<script src="js/jquery.min.js"></script>
<script src="js/jquery.dropotron.min.js"></script>
<script src="js/jquery.scrolly.min.js"></script>
<script src="js/jquery.onvisible.min.js"></script>
<script src="js/skel.min.js"></script>
<script src="js/skel-layers.min.js"></script>
<script src="js/init.js"></script>

<link rel="stylesheet" href="css/skel.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/style-desktop.css" />
<link rel="stylesheet" href="css/style-noscript.css" />

<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
		$("#datepicker").datepicker();
		//window.location.reload();
		//document.getElementById("orario").style.display = "none";
	});
</script>

</head>

<%
	LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
	Utente utente = (Utente) session.getAttribute("utente");
	//if (tok == null) {
%>
<body class="homepage">
	<%
		//	} else {
	%>
	<!-- <body class="no-sidebar"> -->
	<%
		//	}
	%>
	<!-- Header -->
	<div id="header">

		<!-- Inner -->
		<div class="inner">
			<header>
			<h1>
				<a href="index.html" id="logo">Più valore al tuo tempo</a>
			</h1>
			<hr />
			<p>Sottotitolo shareminutes</p>
			</header>
			<footer> <input type="text" /> <a href="#banner"
				class="button circled scrolly">Search</a> </footer>
		</div>

		<%
			if (tok == null || tok.getRequiredAccess() == TipoAccesso.Utente) {
		%>
		<!-- Nav -->
		<nav id="nav">
		<ul>
			<li><a href="#">Logo</a></li>
			<li><a href="GestionePagineServlet?to=redirectToPaginaCommunity">Community</a></li>
			<li><a href="GestionePagineServlet?to=redirectToPaginaSell">Sell</a></li>
			<li><a href="GestionePagineServlet?to=redirectToPaginaBuy">Buy</a></li>

			<%
				if (tok == null) {
			%>
			<li><a
				href="GestioneRicercheServlet?to=redirectToPaginaRicercaUtenteNonLoggato">Search</a></li>
			<li><a href="GestionePagineServlet?to=redirectToLogin">Sign
					in</a></li>
			<li><a
				href="RegistrazioneServlet?to=redirectToPaginaRegistrazione">Sign
					up</a></li>
			<%
				} else {
			%>
			<li><a href="GestioneRicercheServlet?to=redirectToPaginaRicerca">Search</a></li>
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
						href="GestionePagineServlet?to=redirectToClientiEFornitori">Clienti
							&amp; fornitori</a></li>
					<li><a
						href="GestioneAmicizieServlet?to=redirectToPaginaFollower">Followers</a></li>
					<li><a
						href="GestioneRichiesteServlet?to=redirectToPaginaRichieste">Messaggi</a></li>
					<li><a
						href="GestioneAmicizieServlet?to=redirectToPaginaFollowerPreferiti">I
							miei preferiti</a></li>
				</ul></li>
			<li><a
				href="GestioneRichiesteServlet?to=redirectToPaginaRichieste">Mail</a></li>
			<%
				}
					if (tok != null) {
			%>
			<li><a href="AutenticazioneServlet?to=logout">Logout</a></li>
			<%
				}
			%>
		</ul>
		</nav>
		<%
			if (tok != null && utente.getIdUtente() == tok.getIdUtente()) {
		%>
		<nav>
		<ul>
			<li class="current"><a href="#">Profilo</a></li>
			<li><a
				href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaUser">Attività</a></li>
			<li><a href="GestioneUtentiServlet?to=redirectToPaginaPagamento">Pagamento</a></li>
			<li><a href="GestioneUtentiServlet?to=redirectToPaginaSicurezza">Sicurezza</a></li>
		</ul>
		</nav>
		<%
			}
		%>
		<%
			} else if (tok.getRequiredAccess() == TipoAccesso.Amministratore) {
		%>

		<!-- Nav -->
		<nav id="nav">
		<ul>
			<li><a
				href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaAdmin">Lista
					Abilità</a></li>
			<li class="current"><a
				href="GestioneAbilitaServlet?to=redirectToPaginaAbilitaDaValutare">Abilità
					da valutare</a></li>
			<li><a href="AutenticazioneServlet?to=logout">Logout</a></li>
		</ul>

		</nav>

		<%
			}
		%>

	</div>