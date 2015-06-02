<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>
<%@ page import="entity.Abilita"%>
<%@ page import="entity.Follower"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<title>Shareminutes - Follower</title>
<meta name="description" content="Lista Amici" />
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
							<li class="current"><a
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

					<%--
						List<Utente> listaAmicizieDaAccettare = (List<Utente>) session
								.getAttribute("listaAmiciInSospeso");
						if (listaAmicizieDaAccettare != null
								&& listaAmicizieDaAccettare.size() != 0) {
					--%>

					<!-- 
					<br />
					<h2>Amicicizie da accettare:</h2>
					<table class="zebra-striped">
						<thead>
							<tr>
								<th>Foto</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Username</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Nome</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Cognome</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th></th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<%--
								for (Utente utente : listaAmicizieDaAccettare) {
							%>
							<tr>
								<td align="center"><img
									src="GestioneUtentiServlet?to=getFotoProfilo&username=<%=utente.getUsername()%>"
									height="80" alt="Foto Profilo" /></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><%--=utente.getUsername()%></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><%--=utente.getNome()%></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><%--=utente.getCognome()%></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

								<td><a
									href="GestioneAmicizieServlet?to=valutaRichiestaDiAmicizia&usernameUtenteAmico=<%--=utente.getUsername()%>&isApprovata=true">Accetta</a></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneAmicizieServlet?to=valutaRichiestaDiAmicizia&usernameUtenteAmico=<%--=utente.getUsername()%>&isApprovata=false">Rifiuta</a></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<%--
								}
							%>
						</tbody>
					</table>
					<br /> <br />
					
					
					<%--
						}
					--%>
-->

					<%
						if ((Boolean) session.getAttribute("soloPreferiti") == false) {
					%>

					<div class="clearfix">
						<a
							href="GestioneAmicizieServlet?to=redirectToPaginaFollowerPreferiti"
							class="btn">Visualizza solo i preferiti</a> <br /> <br />
					</div>
					<%
						} else {
					%>
					<div class="clearfix">
						<a href="GestioneAmicizieServlet?to=redirectToPaginaFollower"
							class="btn">Visualizza tutti</a> <br /> <br />
					</div>
					<%
						}
					%>

					<h2>Ecco i tuoi follower:</h2>
					<%
						List<Follower> listaFollower = (List<Follower>) session
								.getAttribute("listaFollower");
						//System.out.println("listamici"+listaAmici);
						if (listaFollower != null && listaFollower.size() != 0) {
					%>
					<table class="zebra-striped">
						<thead>
							<tr>
								<th>Foto</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Nome</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Cognome</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Feedback</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Attività 1</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Attività 2</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Preferiti</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Elimina</th>
							</tr>
						</thead>
						<tbody>
							<%
								Utente utente;
									for (Follower follower : listaFollower) {
										utente = follower.getUtenteSeguito();
							%>

							<tr>
								<td align="center"><img
									src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=utente.getIdUtente()%>"
									height="80" alt="Foto Profilo" /></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getNome()%></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getCognome()%></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=utente.getIdUtente()%>">Vedi
										feedback</a></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>
									<%
										List<Abilita> listaAbilita = utente.getAbilita();
												if (listaAbilita.size() > 0) {
									%><a
									href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=listaAbilita.get(0).getIdAbilita()%>"><%=listaAbilita.get(0).getNomeAbilita()%>
								</a> <%
 	}
 %>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>
									<%
										if (listaAbilita.size() > 1) {
									%><a
									href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=listaAbilita.get(1).getIdAbilita()%>"><%=listaAbilita.get(1).getNomeAbilita()%>
								</a> <%
 	}
 %>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>
									<%
										if (follower.isPreferito() == false) {
									%><a
									href="GestioneAmicizieServlet?to=aggiungiFollowerAPreferiti&idFollower=<%=follower.getIdFollower()%>">Aggiungi
										a preferiti</a> <%
 	} else {
 %><a
									href="GestioneAmicizieServlet?to=rimuoviFollowerDaPreferiti&idFollower=<%=follower.getIdFollower()%>">Togli
										dai preferiti</a>
									<%
										}
									%>
								</td>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th><a
									href="GestioneAmicizieServlet?to=eliminaFollower&idFollower=<%=follower.getIdFollower()%>">Elimina
										Follower</a></th>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<%
								}
							%>
						</tbody>

					</table>

					<%
						} else {
					%>
					<strong>Non hai amici.</strong>
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