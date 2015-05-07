<%@page import="entity.Disponibilita"%>
<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<title>SWIMv2 - Modifica Attivit�</title>
<meta name="description" content="Admin - Modifica Abilit�" />
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
							<li class="current"><a
								href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaUser">Attivit�</a></li>
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
						href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaUser">Attivit�</a></li>
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
						Abilita abilita = (Abilita) session.getAttribute("abilita");
						String tag = (String) session.getAttribute("tag");
					%>
					<br />
					<h2>
						Modifica attivit� "<%=abilita.getNomeAbilita()%>"
					</h2>
					<form enctype="multipart/form-data"
						action="GestioneAbilitaServlet?to=modificaAbilita&idAbilita=<%=abilita.getIdAbilita()%>"
						method="post" name="form">

						<div class="clearfix">
							<label>Titolo</label>
							<div class="input">
								<input type="text" name="nome"
									value="<%=abilita.getNomeAbilita()%>" />
							</div>
						</div>
						<br /> <br />
						<div class="clearfix">
							<label>Citt� dove si offre il servizio</label>
							<div class="input">
								<input type="text" name="cittaDoveOffreServizio"
									value="<%=abilita.getCittaDoveOffreServizio()%>" />
							</div>
						</div>
						<br /> <br />
						<div class="clearfix">
							<img
								src="GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=abilita.getIdAbilita()%>"
								height="200" alt="Foto Attivit�" />
						</div>

						<div class="clearfix">
							<label for="fileInput">Foto</label>
							<div class="input">
								<input id="fileInput" class="input-file" type="file" name="foto" />
								<span class="help-block"> La foto deve avere estensione
									jpg, png o gif e dimensione inferiore a 1Mb </span>
							</div>
						</div>
						<br /> <br /> <br /> <br />
						<div class="clearfix">
							<label for="textarea">Descrizione</label>
							<div class="input">
								<textarea id="textarea2" class="xxlarge" rows="10" cols="120"
									name="descrizione"><%=abilita.getDescrizioneAbilita()%></textarea>
							</div>
						</div>
						<br /> <br />
						<div class="clearfix">
							<label for="textarea">Inserire tag separati da uno
								spazio.</label>
							<div class="input">
								<textarea id="textarea2" class="xxlarge" rows="2" cols="120"
									name="tag"><%=tag%></textarea>
							</div>
						</div>
						<br /> <br />
						<div class="clearfix">
							<label>Minuti necessari per effettuare il lavoro indicato</label>
							<div class="input">
								<input type="text" name="minutiNecessari"
									value="<%=abilita.getMinutiNecessari()%>" />
							</div>
						</div>
						<br /> <br />
						<div class="clearfix">
							<label>Tariffa</label>
							<div class="input">
								<input type="text" name="tariffa"
									value="<%=abilita.getTariffa()%>" />
							</div>
						</div>
						<div class="clearfix">
							<label>per minuti</label>
							<div class="input">
								<input type="text" name="minuti"
									value="<%=abilita.getMinuti()%>" />
							</div>
						</div>
						<br /> <br />



						<div class="clearfix">
							<label>Selezionare i giorni della settimana e le fasce
								orarie in cui si � disponibili per l'attivit�.</label>

							<div class="input">

								<%
									Disponibilita disponibilita = (Disponibilita) session
											.getAttribute("disponibilita");
									String tabella = "";
									String[] giorno = { "Luned�", "Marted�", "Mercoled�", "Gioved�",
											"Venerd�", "Sabato", "Domenica" };

									for (int i = 0; i < 7; i++) {
										tabella += "<label>" + giorno[i] + " dalle"
												+ "</label>\n<select name=\"disponibilita" + giorno[i]
												+ "Dalle\">\n";
										tabella += "<option value=\"-1\"></option>\n";
										for (int j = 0; j < 24; j++) {
											tabella += "<option";
											if (disponibilita.getDisponibilita(giorno[i], "dalle") == j) {
												tabella += " selected=\"selected\"";
											}
											tabella += " value=\"" + j + "\">" + j + "</option>\n";
										}
										tabella += "</select>\n";

										tabella += "<label> alle"
												+ "</label>\n<select name=\"disponibilita" + giorno[i]
												+ "Alle\">\n";
										tabella += "<option value=\"-1\"></option>\n";
										for (int j = 0; j < 24; j++) {
											tabella += "<option";
											if (disponibilita.getDisponibilita(giorno[i], "alle") == j) {
												tabella += " selected=\"selected\"";
											}
											tabella += " value=\"" + j + "\">" + j + "</option>\n";
										}
										tabella += "</select><br /><br />\n";
									}
								%>
								<%=tabella%>

								<!-- <label>Luned�</label>
									<select name="disponibilitaLuned�">
										<option value="Luned�0">0</option>
										<option value="Luned�1">1</option>
									</select> -->
							</div>
						</div>


						<!-- <div class="clearfix">
							<label>Selezionare le fasce orarie o i giorni della
								settimana in cui non si vuole ricevere nessuna offerta.</label>
							<table>
								<tr>
									<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
									<th>Luned�</th>
									<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
									<th>Marted�</th>
									<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
									<th>Mercoled�</th>
									<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
									<th>Gioved�</th>
									<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
									<th>Venerd�</th>
									<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
									<th>Sabato</th>
									<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
									<th>Domenica</th>
								</tr>
								<%--
									List<String> disponibilita = (List<String>) session
											.getAttribute("disponibilita");
									String tabella = "";
									String posizione = "";
									String[] valore = { "LU", "MA", "ME", "GI", "VE", "SA", "DO" };//checked="checked"
									for (int i = 0; i < 24; i++) {
										tabella += "<tr>\n<th>" + i + "</th>\n";
										for (int j = 0; j < 7; j++) {
											tabella += "<td><input type=\"checkbox\" name=\"disponibilita\" value=\""
													+ valore[j] + i + "\" ";

											posizione = valore[j] + i;
											if (disponibilita.contains(posizione))
												tabella += "checked=\"checked\"";

											tabella += " /></td>\n";
											tabella += "<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>\n";

										}
										tabella += "</tr>\n";
									}
								%>
								<%=tabella--%>

							</table>
						</div>-->
						<br /> <br /> <br /> <br /> <label>Paypal connect</label>
						<div class="clearfix">
							<input type="checkbox" name="pubblicaAbilita" value="1" />
							Attiva disponibilit�.
						</div>
						<br /> <br /> <br /> <br />
						<div class="actions">
							<button class="btn primary" type="submit">Conferma</button>
							<a
								href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaUser"
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
							if (tok != null && tok.getRequiredAccess() == TipoAccesso.Utente) { //gi� loggato.
						%>
						Benvenuto/a, <br />
						<%=tok.getEmail() + "!"%>
						<%
							} else {
								response.sendRedirect("index.jsp");
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