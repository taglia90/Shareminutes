<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>
<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en">
<head>
<title>Shareminutes - Attività</title>
<meta name="description" content="SWIMv2" />
<link rel="stylesheet" href="css/reset.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/layout.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<script type="text/javascript" src="js/maxheight.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
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
					<li><a href="#">Profile</a>
						<ul>
							<li><a
								href="GestionePagineServlet?to=redirectToGestioneOrdini">Gestione
									ordini</a></li>
							<li><a
								href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback">Rating</a></li>
							<li class="current"><a
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
					<h2>Profilo Attività</h2>
					<br />

					<%
						Abilita abilita = (Abilita) session.getAttribute("abilita");
						String stringaData = (String) session.getAttribute("data");
						session.setAttribute("data", stringaData);
						if (stringaData == null || stringaData == "") {
					%>

					<form
						action="GestioneAbilitaServlet?to=memorizzaDataProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>#ancora"
						method="post">
						<%
							} else {
						%>
						<form
							action="GestionePrenotazioniServlet?to=nuovaPrenotazione&idAbilita=
						<%=abilita.getIdAbilita()%>&data=<%=stringaData%>"
							method="post">
							<%
								}
							%>

							<%--
						
						int idUtenteProfilo;
						if (session.getAttribute("idUtenteProfilo") == null) {
							idUtenteProfilo = 0;
						} else {
							idUtenteProfilo = (int) session.getAttribute("idUtenteProfilo");
						}
						if (idUtenteProfilo == tok.getIdUtente()) {
					--%>

							<%--
						}
					--%>
							<div class="clearfix">
								<img
									src="GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=abilita.getIdAbilita()%>"
									height="200" alt="Foto Attività" />
							</div>
							<br /> <br />
							<div class="clearfix">
								<label>Titolo Attività:</label>
								<%=abilita.getNomeAbilita()%>
							</div>
							<br /> <br />
							<div class="clearfix">
								<label>Città:</label>
								<%=abilita.getCittaDoveOffreServizio()%>
							</div>
							<br /> <br />
							<div class="clearfix">
								<label>Minuti già condivisi:</label>
								<%=abilita.getMinutiCondivisi()%>
							</div>

							<br /> <br />
							<div class="clearfix">
								<label>Tariffa:</label>
								<%=abilita.getTariffa() + " euro/" + abilita.getMinuti()
					+ " minuti"%>
							</div>

							<br /> <br />
							<div class="clearfix">
								<label>Minuti necessari per svolgere il lavoro:</label>
								<%=abilita.getMinutiNecessari()%></div>

							<br /> <br />

							<div class="clearfix">
								<label>Descrizione:</label>
								<%=abilita.getDescrizioneAbilita()%></div>

							<br /> <br />
							<div class="clearfix">
								<a name="ancora"></a>
								<h2>Prenota:</h2>
							</div>

							<p>
								<%
									//String stringaData = (String) session.getAttribute("data");
									if (stringaData == null || stringaData == "") {
								%>

								<label>Seleziona una data:</label> <input type="text"
									id="datepicker" name="data" value="<%=stringaData%>" />
								<%
									} else {
								%>

								<label>Data selezionata: </label>
								<%=stringaData%>
								<a
									href="GestioneAbilitaServlet?to=cambiaDataProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>#ancora">Modifica
									data</a>
								<%
									}
								%>
							</p>

							<div class="clearfix">

								<div class="input" id="orario">

									<%
										if (stringaData != "" && stringaData != null) {
											SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
											Date data = formatter.parse(stringaData);
											Calendar cal = Calendar.getInstance();
											cal.setTime(data);
											int giorno = cal.get(Calendar.DAY_OF_WEEK);
											giorno--;
											String tabella = "";
											tabella += "<label>Seleziona un orario:</label>\n";
											tabella += "<table>\n";
											tabella += "<tr>\n";
											tabella += "<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>\n";
											if (giorno == 0) {
												tabella += "<th>Domenica</th>\n";
											} else if (giorno == 1) {
												tabella += "<th>Lunedì</th>\n";
											} else if (giorno == 2) {
												tabella += "<th>Martedì</th>\n";
											} else if (giorno == 3) {
												tabella += "<th>Mercoledì</th>\n";
											} else if (giorno == 4) {
												tabella += "<th>Giovedì</th>\n";
											} else if (giorno == 5) {
												tabella += "<th>Venerdì</th>\n";
											} else if (giorno == 6) {
												tabella += "<th>Sabato</th>\n";
											}
											tabella += "</tr>";

											List<String> disponibilita = (List<String>) session
													.getAttribute("disponibilita");
											String posizione = "";
											String[] valore = { "DO", "LU", "MA", "ME", "GI", "VE", "SA" };//checked="checked"
											for (int i = 0; i < 24; i++) {
												tabella += "<tr>\n<th>" + i + "</th>\n";
												//for (int j = 0; j < 7; j++) {
												tabella += "<td><input type=\"checkbox\" name=\"disponibilita\" value=\""
														+ valore[giorno] + i + "\" ";

												posizione = valore[giorno] + i;
												if (!disponibilita.contains(posizione))
													/*tabella += "checked=\"checked\"";
													else*/
													tabella += "disabled=\"disabled\"";
												tabella += " /></td>\n";
												tabella += "<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>\n";

												//}
												tabella += "</tr>\n";
											}
											tabella += "</table>\n";
									%>
									<%=tabella%>


									<%
										}
									%>
									<%--
									String tabella = "";

									tabella += "<label> dalle"
											+ "</label>\n<select name=\"disponibilitaDalle\">\n";
									tabella += "<option value=\"-1\"></option>\n";
									for (int j = 0; j < 24; j++) {
										tabella += "<option value=\"" + j + "\">" + j + "</option>\n";
									}
									tabella += "</select>\n";

									tabella += "<label> alle"
											+ "</label>\n<select name=\"disponibilitaAlle\">\n";
									tabella += "<option value=\"-1\"></option>\n";
									for (int j = 0; j < 24; j++) {
										tabella += "<option value=\"" + j + "\">" + j + "</option>\n";
									}
									tabella += "</select><br /><br />\n";
								%>
								<%=tabella--%>

									<!-- <label>Lunedì</label>
									<select name="disponibilitaLunedì">
										<option value="Lunedì0">0</option>
										<option value="Lunedì1">1</option>
									</select> -->

									<%
										if (stringaData != null && stringaData != "") {
									%>
									<div class="actions">
										<button class="btn primary" type="submit">Prenota</button>

									</div>

									<%
										} else {
									%>
									<div class="actions">
										<button class="btn primary" type="submit">Verifica
											disponibilità</button>

									</div>
									<%
										}
									%>
								</div>
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