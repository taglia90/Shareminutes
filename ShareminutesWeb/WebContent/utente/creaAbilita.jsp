<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<title>Crea Attività</title>
<meta name="description" content="Admin - Crea Abilità" />
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
					<li class="current"><a
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
				<div class="content">
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
						<br />
						<h2>Nuova attività</h2>
						<form enctype="multipart/form-data"
							action="GestioneAbilitaServlet?to=creaAbilita" method="post">

							<div class="clearfix">
								<label>Titolo</label>
								<div class="input">
									<input type="text" name="nome" />
								</div>
							</div>
							<br /> <br />

							<div class="clearfix">
								<label>Città dove si offre il servizio</label>
								<div class="input">
									<input type="text" name="cittaDoveOffreServizio" />
								</div>
							</div>
							<br /> <br />

							<div class="clearfix">
								<label for="fileInput">Foto</label>
								<div class="input">
									<input id="fileInput" class="input-file" type="file"
										name="foto"> <span class="help-block"> Deve
											avere estensione jpg, png o gif e dimensione inferiore a 1Mb
									</span>
								</div>
							</div>
							<br /> <br />
							<div class="clearfix">
								<label for="textarea">Descrizione</label>
								<div class="input">
									<textarea id="textarea2" class="xxlarge" rows="10" cols="120"
										name="descrizione"></textarea>
								</div>
							</div>
							<br /> <br />
							<div class="clearfix">
								<label for="textarea">Inserire tag separati da uno
									spazio.</label>
								<div class="input">
									<textarea id="textarea2" class="xxlarge" rows="2" cols="120"
										name="tag"></textarea>
								</div>
							</div>
							<br /> <br />
							<div class="clearfix">
								<label>Minuti necessari per effettuare il lavoro
									indicato</label>
								<div class="input">
									<input type="text" name="minutiNecessari" />
								</div>
							</div>
							<br /> <br />
							<div class="clearfix">
								<label>Tariffa</label>
								<div class="input">
									<input type="text" name="tariffa" />
								</div>
							</div>
							<div class="clearfix">
								<label>per minuti</label>
								<div class="input">
									<input type="text" name="minuti" />
								</div>
							</div>
							<br /> <br />

<!-- 
							<div class="clearfix">
								<label>Selezionare i giorni della settimana e le fasce
									orarie in cui si è disponibili per l'attività.</label>

								<div class="input">
 -->
									<%--
										String tabella = "";
										String[] giorno = { "Lunedì", "Martedì", "Mercoledì", "Giovedì",
												"Venerdì", "Sabato", "Domenica" };

										for (int i = 0; i < 7; i++) {
											tabella += "<label>" + giorno[i] + " dalle"
													+ "</label>\n<select name=\"disponibilita" + giorno[i]
													+ "Dalle\">\n";
											tabella += "<option value=\"-1\"></option>\n";
											for (int j = 0; j < 24; j++) {
												tabella += "<option value=\"" + j + "\">" + j
														+ "</option>\n";
											}
											tabella += "</select>\n";

											tabella += "<label> alle"
													+ "</label>\n<select name=\"disponibilita" + giorno[i]
													+ "Alle\">\n";
											tabella += "<option value=\"-1\"></option>\n";
											for (int j = 0; j < 24; j++) {
												tabella += "<option value=\"" + j + "\">" + j
														+ "</option>\n";
											}
											tabella += "</select><br /><br />\n";
										}
									%>
									<%=tabella--%>

									<!-- <label>Lunedì</label>
									<select name="disponibilitaLunedì">
										<option value="Lunedì0">0</option>
										<option value="Lunedì1">1</option>
									</select> 
								</div>
							</div>
 -->

							<div class="clearfix">
								<label>Selezionare i giorni della settimana e le fasce
									orarie in cui si è disponibili per l'attività.</label>
								<table>
									<tr>
										<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
										<th>Lunedì</th>
										<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
										<th>Martedì</th>
										<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
										<th>Mercoledì</th>
										<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
										<th>Giovedì</th>
										<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
										<th>Venerdì</th>
										<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
										<th>Sabato</th>
										<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
										<th>Domenica</th>
									</tr>
									<%
										String tabella = "";
										String[] valore = { "LU", "MA", "ME", "GI", "VE", "SA", "DO" };
										for (int i = 0; i < 24; i++) {
											tabella += "<tr>\n<th>" + i + "</th>\n";
											for (int j = 0; j < 7; j++) {
												tabella += "<td><input type=\"checkbox\" name=\"disponibilita\" value=\""
														+ valore[j] + i + "\" /></td>\n";
												tabella += "<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>\n";

											}
											tabella += "</tr>\n";
										}
									%>
									<%=tabella%>

								</table>
							</div>
							<br /> <br />

							<div class="clearfix">
								<input type="checkbox" name="pubblicaAbilita" value="1" />
								Attiva disponibilità.
							</div>
							<br /> <br /> <label>Paypal connect</label>

							<div class="actions">
								<button class="btn primary" type="submit">Conferma</button>
								<a
									href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaUser"
									class="btn">Annulla</a>
							</div>
						</form>
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