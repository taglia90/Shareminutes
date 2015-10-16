<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Richiesta"%>
<%@ page import="entity.Messaggio"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<title>Shareminutes - Dettaglio richiesta</title>
<meta name="description" content="Dettaglio richiesta" />
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

			<div class="nav-box2">
				<nav>
				<ul>
					<li><a
						href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=tok.getIdUtente()%>">Profilo</a></li>
					<li><a
						href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaUser">Attività</a></li>
					<li><a
						href="GestioneUtentiServlet?to=redirectToPaginaPagamento">Pagamento</a></li>
					<li><a
						href="GestioneUtentiServlet?to=redirectToPaginaSicurezza">Sicurezza</a></li>
				</ul>
				</nav>
			</div>

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

						Richiesta richiesta = (Richiesta) session.getAttribute("richiesta");
						if (richiesta != null) {
					%>
					<br />
					<%
						if (richiesta.getUtenteMittente().getUsername()
									.equals(tok.getEmail())) {
					%>
					<h2>
						Richiesta inviata a:&nbsp; <span><%=richiesta.getUtenteDestinatario().getUsername()%></span>
					</h2>
					<%
						} else {
					%>
					<h2>
						Richiesta ricevuta da:&nbsp; <span><%=richiesta.getUtenteMittente().getUsername()%>
						</span>
					</h2>
					<%
						}
					%>
					<h2>
						Oggetto:&nbsp;<span><%=richiesta.getOggettoRichiesta()%></span>
					</h2>
					<table class="zebra-striped">
						<tbody>
							<%
								List<Messaggio> listaMessaggi = (List<Messaggio>) session
											.getAttribute("listaMessaggi");
									int i;
									for (i = 0; i < listaMessaggi.size(); i++) {
										Messaggio messaggio = listaMessaggi.get(i);
							%>
							<div class="clearfix">
								Utente:&nbsp;&nbsp;
								<%
									if (messaggio.getUtente().getUsername()
													.equals(tok.getEmail())) {
								%>
								Io
								<%
									} else {
								%>
								<%=messaggio.getUtente().getUsername()%>
								<%
									}
								%>
								<br /> <br />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Messaggio:
								<%=messaggio.getCorpoMessaggio()%>
								<br /> <br /> <br />
							</div>
							<%
								}%>
							<%--		if (!richiesta.getHaRicevutoFeedback()) {
							--%>
							<!-- 
							<form
								action="GestioneRichiesteServlet?to=creaNuovoMessaggio&idRichiesta=<%=richiesta.getIdRichiesta()%>"
								method="post" name="form">
								<div class="clearfix">
									<label for="textarea">Inserisci la risposta:</label>
									<div class="input">
										<textarea id="textarea2" class="xxlarge" rows="10" cols="120"
											name="corpoMessaggio"></textarea>
									</div>
								</div>
								<br /> <br /> <br />
								<div class="actions">
									<button class="btn primary" type="submit">Conferma</button>
								</div>
							</form>
							<%--
								if (richiesta.getUtenteMittente().getUsername()
												.equals(tok.getEmail())) {
							--%>
							<a
								href="GestioneFeedbackServlet?to=redirectToPaginaNuovoFeedback&usernameDestinatario=<%=richiesta.getUtenteDestinatario().getIdUtente()%>&idRichiesta=<%=richiesta.getIdRichiesta()%>">Rilascia
								Feedback</a> -->
							<%--
								}
									}
							--%>
						</tbody>
					</table>
					<%
						} else {
					%>
					<strong>Errore nel recupero della richiesta.</strong>
					<%
						}
					%>
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