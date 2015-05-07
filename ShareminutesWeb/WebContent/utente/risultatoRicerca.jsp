<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>
<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<title>SWIMv2 - Risultato ricerca</title>
<meta name="description" content="Risultato ricerca" />
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
					<li class="current"><a
						href="GestioneRicercheServlet?to=redirectToPaginaRicercaUtenteNonLoggato">Search</a></li>
					<li><a href="RegistrazioneServlet?to=redirectToIndex">Sign
							in</a></li>
					<li><a
						href="RegistrazioneServlet?to=redirectToPaginaRegistrazione">Sign
							up</a></li>
					<%
						} else {
					%>
					<li class="current"><a
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
					%>
					<br />
					<h2>Risultato ricerca</h2>

					<%
						List<Abilita> listaAbilita = (List<Abilita>) session
								.getAttribute("listaAbilita");
						if (listaAbilita != null && listaAbilita.size() != 0) {
					%>
					<table class="zebra-striped">
						<thead>
							<tr>
								<th>Foto</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Titolo</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Utente</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Città</th>

							</tr>
						</thead>
						<tbody>
							<%
								for (Abilita abilita : listaAbilita) {
										List<Utente> utente = (List<Utente>) abilita.getUtente();
							%>
							<tr>
								<td><img
									src="GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=abilita.getIdAbilita()%>"
									height="200" width="200" alt="Foto Attività" /></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>"><%=abilita.getNomeAbilita()%>
								</a><br />
								<a
									href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>">Minuti
										condivisi: <%=abilita.getMinutiCondivisi()%>
								</a><br /> <a
									href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>">Prezzo:
										<%=abilita.getTariffa() + "/" + abilita.getMinuti()
							+ "min"%></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=utente.get(0).getIdUtente()%>"><%=utente.get(0).getNome() + " "
							+ utente.get(0).getCognome()%> </a> <br /> <img
									src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=utente.get(0).getIdUtente()%>"
									height="100" width="100" alt="Foto Attività" /> <br /> <a
									href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&usernameUtente=<%=utente.get(0).getIdUtente()%>">Vedi
										feedback utente</a><br />
										Stelle: 5</td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.get(0).getCittaAttuale()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneRichiesteServlet?to=redirectToPaginaInvioRichiesta&usernameDestinatario=<%=utente.get(0).getIdUtente()%>">Invia
										richiesta</a></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
					<%
						} else {
					%>
					<strong>Nessun risultato trovato.</strong>
					<%
						}
					%>
					<br /> <br />










					<!--  
					<%--List<Utente> listaUtentiAmici = (List<Utente>) session
					.getAttribute("listaUtentiAmici");

			List<Utente> listaUtentiNONAmici = (List<Utente>) session
					.getAttribute("listaUtentiNONAmici");
			if ((listaUtentiAmici != null && listaUtentiAmici.size() != 0)
					|| (listaUtentiNONAmici != null && listaUtentiNONAmici
							.size() != 0)) {%>

					<table class="zebra-striped">
						<thead>
							<tr>
								<th>Foto</th>
								<th>&nbsp;&nbsp;&nbsp;</th>
								<th>Username</th>
								<th>&nbsp;&nbsp;&nbsp;</th>
								<th>Nome</th>
								<th>&nbsp;&nbsp;&nbsp;</th>
								<th>Cognome</th>
								<th>&nbsp;&nbsp;&nbsp;</th>
								<th></th>
								<th>&nbsp;&nbsp;&nbsp;</th>
								<th></th>
								<th>&nbsp;&nbsp;&nbsp;</th>
								<th></th>
								<th>&nbsp;&nbsp;&nbsp;</th>
							</tr>
						</thead>
						<tbody>
							<%for (Utente utente : listaUtentiAmici) {%>

							<tr>

								<td align="center"><img
									src="GestioneUtentiServlet?to=getFotoProfilo&username=<%=utente.getUsername()%>"
									height="80" alt="Foto Profilo" /></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getUsername()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getNome()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getCognome()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&usernameUtente=<%=utente.getUsername()%>">Vedi
										feedback</a></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneRichiesteServlet?to=redirectToPaginaInvioRichiesta&usernameDestinatario=<%=utente.getUsername()%>">Invia
										richiesta</a></td>
								<td></td>
							</tr>
							<%}%>
							<%for (Utente utente : listaUtentiNONAmici) {%>

							<tr>
								<td align="center"><img
									src="GestioneUtentiServlet?to=getFotoProfilo&username=<%=utente.getUsername()%>"
									height="80" alt="Foto Profilo" /></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getUsername()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getNome()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getCognome()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&usernameUtente=<%=utente.getUsername()%>">Vedi
										feedback</a></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneAmicizieServlet?to=creaAmicizia&usernameUtenteAmico=<%=utente.getUsername()%>">Aggiungi
										agli amici</a></td>

							</tr>
							<%}%>
						</tbody>
					</table>
					<%} else {%>
					<strong>La ricerca non ha prodotto risultati.</strong>
					<%}--%>
-->
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