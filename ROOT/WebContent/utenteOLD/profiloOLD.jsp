<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en">
<head>
<title>Shareminutes - Profilo</title>
<meta name="description" content="SWIMv2" />
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
					<li><a
						href="RegistrazioneServlet?to=redirectToPaginaRegistrazione">Sign
							up</a></li>
					<%
						} else {
					%>
					<li><a
						href="GestioneRicercheServlet?to=redirectToPaginaRicerca">Search</a></li>
					<li class="current"><a href="#">Profile</a>
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
			<%
				Utente utente = (Utente) session.getAttribute("utente");
			%>
			<%
				if (utente.getIdUtente() == tok.getIdUtente()) {
			%>
			<div class="nav-box2">
				<nav>
				<ul>
					<li class="current"><a href="#">Profilo</a></li>
					<li><a
						href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaUser">Attività</a></li>
					<li><a
						href="GestioneUtentiServlet?to=redirectToPaginaPagamento">Pagamento</a></li>
					<li><a
						href="GestioneUtentiServlet?to=redirectToPaginaSicurezza">Sicurezza</a></li>
				</ul>
				</nav>
			</div>
			<%
				}
			%>

			<div class="wrapper indent">
				<!-- content -->
				<section id="content">
				<div>
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
					<br />
					<h2>Profilo Utente</h2>
					<br />
					<%
						if (utente.getIdUtente() == tok.getIdUtente()) {
					%>

					<div class="clearfix">
						<a
							href="GestioneUtentiServlet?to=redirectToPaginaModificaProfilo&idUtente=<%=tok.getIdUtente()%>"
							class="btn">Modifica Profilo</a> <br /> <br />
					</div>
					<%
						} else {
					%>
					<div class="clearfix">
						<a
							href="GestioneAmicizieServlet?to=aggiungiFollower&idUtenteFoll=<%=utente.getIdUtente()%>"
							class="btn">Follow</a> <br /> <br />
					</div>
					<%
						}
					%>
					<div class="clearfix">
						<img
							src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=tok.getIdUtente()%>"
							height="200" alt="Foto Profilo" />
					</div>
					<br /> <br />
					<div class="clearfix">
						<label>Headline:</label>
						<%
							String head = "";
							if (utente.getHeadline() != null)
								head = utente.getHeadline();
						%>
						<%=head%>
					</div>
					<br /> <br />
					<div class="clearfix">
						<label>Nome:</label>
						<%
							String nome = "";
							String cognome = "";
							if (utente.getNome() != null)
								nome = utente.getNome();
							if (utente.getCognome() != null)
								cognome = utente.getCognome();
						%>
						<%=nome + " " + cognome%>
					</div>
					<br /> <br />
					<div class="clearfix">
						<label>Location:</label>
						<%
							String citta = "";
							if (utente.getCittaAttuale() != null)
								citta = utente.getCittaAttuale();
						%>
						<%=citta%>
					</div>

					<br /> <br />
					<!-- 
					<div class="clearfix">
						<label>Attività 1:</label>
						<%--=utente.getAbilita()%>
					</div>

					<br /> <br />
					<div class="clearfix">
						<label>Attività 2:</label>
						<%=utente.getAbilita()--%></div>

					<br /> <br /> -->
					<div class="clearfix">
						<label>Biografia:</label>
						<%
							String bio = "";
							if (utente.getBiografia() != null)
								bio = utente.getBiografia();
						%>
						<%=bio%>
					</div>
				</div>
				</section>
				<!-- aside -->
				<aside>
				<div class="inside">
					<div class="well">
						<%
							if (tok != null && tok.getRequiredAccess() == TipoAccesso.Utente) { //già loggato.
						%>
						Benvenuto/a, <br />
						<%=tok.getEmail() + "!"%>
						<%
							} else {
								response.sendRedirect("../index.jsp");
							}
						%>
					</div>
					<br /> <br />
					<div class="well">
						<table class="zebra-striped">
							<tbody>
								<tr>
									<td><%=tok.getNome()%><br /><%=tok.getCognome()%></td>
								</tr>
							</tbody>
						</table>
					</div>
					<br /> <br />
					<div>
						<a href="./AutenticazioneServlet?to=logout">Logout</a>
					</div>
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