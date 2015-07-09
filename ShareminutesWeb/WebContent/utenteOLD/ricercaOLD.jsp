<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<title>Shareminutes - Ricerca</title>
<meta name="description" content="Ricerca" />
<link rel="stylesheet" href="css/reset.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/layout.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
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
					<!-- 
					<h2>Ricerca tra le attività</h2>
					<%--
						List<Abilita> listaAbilita = (List<Abilita>) session
								.getAttribute("listaAbilita");
						if (listaAbilita != null && listaAbilita.size() != 0) {
					%>

					<form enctype="multipart/form-data"
						action="GestioneRicercheServlet?to=ricerca" method="post"
						name="form">
						<select name="abilitaScelta">
							<%
								for (Abilita abilita : listaAbilita) {
							%>
							<option value="<%=abilita.getIdAbilita()%>"><%=abilita.getNomeAbilita()%></option>
							<%
								}
							%>
						</select> <br /> <br /> <br /> <br /> <input type="checkbox"
							name="cercaTraAmici" value="true" title="Cerca tra gli amici." />Cerca
						tra gli amici. <br /> <br /> <br /> <br />
						<div class="actions">
							<button class="btn primary" type="submit">Conferma</button>
							<a href="GestioneUtentiServlet?to=redirectToPaginaProfilo"
								class="btn">Annulla</a>
						</div>
					</form>
					<%
						} else {
					%>
					<strong>Non ci sono abilità tra cui fare la ricerca.</strong>
					<%
						}
					--%>
					<br /> <br /> oppure <br /> <br /> -->
					<h2>Ricerca</h2>
					<form enctype="multipart/form-data"
						action="GestioneRicercheServlet?to=ricercaTag" method="post">
						<div class="clearfix">
							<label>Inserisci un'attività, un tag (o parte di essi).</label>
							<div class="input">
								<input type="text" name="stringa" />
							</div>
							<br /> <label>Inserisci una città (o parte di essa) </label>
							<div class="input">
								<input type="text" name="citta" />
							</div>
							<br /> <label>Seleziona una data:</label>
							<div class="input">
								<input type="text" id="datepicker" name="data" />
							</div>
							<br /> <label>Seleziona un orario:</label>
							<div class="input">
								<select name="disponibilita">
									<%
										String orario = "";
										for (int i = 0; i < 24; i++) {
											orario += "<option value=\"" + i + "\" >" + i + "</option>";
										}
									%>
									<%=orario%>
									<!-- <option value="0">0</option>-->
								</select>
							</div>


						</div>
						<br /> <br /> <br /> <br />
						<div class="actions">
							<button class="btn primary" type="submit">Cerca</button>
							<a href="GestioneUtentiServlet?to=redirectToPaginaProfilo"
								class="btn">Annulla</a>
						</div>
					</form>
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