<%@page import="entity.Prenotazione"%>
<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Richiesta"%>
<%@ page import="entity.Messaggio"%>
<%@ page import="entity.Abilita"%>
<%@ page import="entity.Utente"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<title>Sharminutes - Dettaglio ordine</title>
<meta name="description" content="Dettaglio ordine" />
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

						Prenotazione prenotazione = (Prenotazione) session
								.getAttribute("prenotazione");
						if (prenotazione != null) {
					%>
					<h2>Dettaglio ordine</h2>
					<br />
					<%
						//AS A BUYER
							if (prenotazione.getUtenteBuyer().getIdUtente() == tok
									.getIdUtente()) {
								Utente u = prenotazione.getUtenteSeller();
								Abilita a = prenotazione.getAbilita();
					%>


					<table class="zebra-striped">
						<tbody>
							<tr>
								<td>Utente seller:&nbsp; <a
									href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.getIdUtente()%>"><%=u.getNome()%>
										<%=u.getCognome()%></a> <br /></td>
								<td><img
									src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=u.getIdUtente()%>"
									height="200" alt="Foto Profilo" /></td>
								<td><label>Attività:</label> <a
									href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a.getIdAbilita()%>"><%=a.getNomeAbilita()%>
								</a></td>
								<td>Rating seller: <a
									href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&usernameUtente=<%=u.getIdUtente()%>">Vedi
										feedback utente</a><br />
								</td>
								<td><label>Stato:</label> <%
 	if (prenotazione.isPagata()) {
 %> <label>Pagamento confermato</label><a
									href="GestioneFeedbackServlet?to=redirectToPaginaNuovoFeedback&usernameDestinatario=<%=u.getIdUtente()%>&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">Rilascia
										Feedback</a> <%
										
 	}else if (prenotazione.isConfermataBuyer()
								 					&& prenotazione.isAccettataSeller()) {
								 %><label>PULSANTE PAGAMENTO</label>
		<%							
 	} else if (!prenotazione.isConfermataBuyer()
 					&& prenotazione.isAccettataSeller()) {
 %> <a
									href="GestionePrenotazioniServlet?to=SetConfermataBuyer&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">
										CONCLUDI PRENOTAZIONE</a><br /> <a
									href="GestionePrenotazioniServlet?to=SetRifiutata&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">
										ANNULLA PRENOTAZIONE</a> <%
 	} else {
 %><label>In attesa di una risposta del seller.</label> <%
 	}
 %></td>
							</tr>
						</tbody>
					</table>

					<br /> <br /> <br /> <br />

					<%
						//AS A SELLER
							} else {
								Utente u = prenotazione.getUtenteBuyer();
								Abilita a = prenotazione.getAbilita();
					%>
					<table class="zebra-striped">
						<tbody>
							<tr>
								<td>Utente buyer:&nbsp; <a
									href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.getIdUtente()%>"><%=u.getNome()%>
										<%=u.getCognome()%></a> <br /></td>
								<td><img
									src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=u.getIdUtente()%>"
									height="200" alt="Foto Profilo" /></td>
								<td><label>Attività:</label> <a
									href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a.getIdAbilita()%>"><%=a.getNomeAbilita()%>
								</a></td>
								<td>Rating seller: <a
									href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&usernameUtente=<%=u.getIdUtente()%>">Vedi
										feedback utente</a><br />
								</td>
								<td><label>Stato:</label> <%
 	if (prenotazione.isPagata()) {
 %><label>Pagamento confermato</label> <a
									href="GestioneFeedbackServlet?to=redirectToPaginaNuovoFeedback&usernameDestinatario=<%=u.getIdUtente()%>&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">Rilascia
										Feedback</a> <%
 	} else if (prenotazione.isConfermataBuyer()
 					&& prenotazione.isAccettataSeller()) {
 %><label>In attesa del pagamento</label>
									<%
										} else if (!prenotazione.isConfermataBuyer()
														&& prenotazione.isAccettataSeller()) {
									%> <label> In attesa della conferma del cliente</label> <%
 	} else {
 %> <a
									href="GestionePrenotazioniServlet?to=SetAccettataSeller&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">
										ACCETTA OFFERTA</a><br /> <a
									href="GestionePrenotazioniServlet?to=SetRifiutata&idPrenotazione=<%=prenotazione.getIdPrenotazione()%>">
										RIFIUTA OFFERTA</a> <%
 	}
 %></td>
							</tr>
						</tbody>
					</table>
					<%
						}
					%>
					<%
						} else {
					%>
					<strong>Errore nel recupero dell'ordine.</strong>
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