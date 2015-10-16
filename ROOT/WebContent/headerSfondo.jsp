<%@page import="control.GestioneRichiesteServlet"%>
<%@page import="control.GestionePrenotazioniServlet"%>
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
<link rel="stylesheet" href="css/styleFont.css" />
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
<link href='http://fonts.googleapis.com/css?family=Montserrat'
	rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="font-awesome/css/font-awesome.min.css" />
</head>

<%
	LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
	Utente utente = (Utente) session.getAttribute("utente");

	String servletPath = request.getServletPath();
	//out.println(servletPath.substring(servletPath.lastIndexOf("/")+1, servletPath.length()));
	String pageName = servletPath.substring(
			servletPath.lastIndexOf("/") + 1, servletPath.length());
	//System.out.println("PAGENAME = ");
	//System.out.println(pageName);
	if (pageName.equals("index.jsp")) {
%>

<body class="no-sidebar">
	<%
		} else {
	%>
	<body class="no-sidebar">
		<%
			}
		%>
		<!-- Header -->
		<div id="header">



			<%
				if (tok == null || tok.getRequiredAccess() == TipoAccesso.Utente) {
			%>
			<!-- Nav -->
			<nav style="text-shadow:0 0 3px #000;" id="nav">
			<ul>
				<li style=""><a href="GestionePagineServlet?to=redirectToIndex"><div
							class="logoHeaderBianco"></div></a></li>
				<li><a class="primoMenu"
					href="GestionePagineServlet?to=redirectToPaginaCommunity">COMMUNITY</a></li>
				<li><a href="GestionePagineServlet?to=redirectToPaginaSell">SELL</a></li>
				<li><a href="GestionePagineServlet?to=redirectToPaginaBuy">BUY</a></li>

				<%
					if (tok == null) {
				%>

				<li><a class="searchHeader"
					href="GestioneRicercheServlet?to=redirectToPaginaRicercaUtenteNonLoggato"><div
							style="float: left ! important; margin-left: 10px; margin-top: -10px;"
							class="icon-search"></div>Search</a></li>
				<li><a href="GestionePagineServlet?to=redirectToLogin">Login
				</a></li>
				<li><a
					href="RegistrazioneServlet?to=redirectToPaginaRegistrazione">Sign
						up</a></li>
				<%
					} else {
				%>
				<li><div class="searchHeader">
						<a href="GestioneRicercheServlet?to=redirectToPaginaRicerca"><div
								style="float: left ! important; margin-top: -10px;"
								class="icon-search"></div>SEARCH</a>
					</div></li>
				<li><a
					href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=tok.getIdUtente()%>"><div
							style="background: transparent url(GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=tok.getIdUtente()%>) repeat scroll 0% 0% / cover;
float: left !important;
margin-top: -14px;
background-size: cover;
height: 30px;
width: 30px;
border-radius: 10em;"
							class="fotoProfilo"></div>PROFILE</a>
					<ul>
						<li><a
							href="GestionePagineServlet?to=redirectToGestioneOrdini"> <%
 	GestionePrenotazioniServlet gp = new GestionePrenotazioniServlet();
 			boolean ciSonoOrdiniNonLetti = gp.ciSonoOrdiniNonLetti(tok
 					.getIdUtente());

 			if (ciSonoOrdiniNonLetti) {
 %>
								<div class="notifica"></div> <%
 	}
 %> Gestione ordini
						</a></li>
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
					href="GestioneRichiesteServlet?to=redirectToPaginaRichieste"> <%
 	GestioneRichiesteServlet gr = new GestioneRichiesteServlet();
 			boolean ciSonoMessaggiNonLetti = gr
 					.ciSonoMessaggiNonLetti(tok.getIdUtente());

 			if (ciSonoMessaggiNonLetti) {
 %>
						<div class="notifica"></div> <%
 	}
 %>
						<div class="icon-mail iconcine busta"></div>
				</a></li>
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
			<nav class="secondoMenu">
			<ul>
				<li class="current"><a href="#">Profilo
						<div class="freccia"></div>
				</a></li>
				<li><a
					href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaUser">Attività
						<div class="freccia"></div>
				</a></li>
				<li><a
					href="GestioneUtentiServlet?to=redirectToPaginaPagamento">Pagamento
						<div class="freccia"></div>
				</a></li>
				<li><a
					href="GestioneUtentiServlet?to=redirectToPaginaSicurezza">Sicurezza
						<div class="freccia"></div>
				</a></li>
			</ul>
			</nav>
			<%
				}
			%>
			<%
				} else if (tok.getRequiredAccess() == TipoAccesso.Amministratore) {
			%>

			<!-- Nav -->
			<nav style="color:#000 !important;" id="nav">
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


			<!-- Inner -->

		</div>
	</body>