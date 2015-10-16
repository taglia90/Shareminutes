<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>
<%@ page import="entity.Abilita"%>
<%@ page import="entity.Feedback"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="../headerSfondo.jsp"%>


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

<%
	Abilita abilita = (Abilita) session.getAttribute("abilita");
	String stringaData = (String) session.getAttribute("data");
	List<Feedback> listaFeedbackRicevuti = (List<Feedback>) session
			.getAttribute("listaFeedback");
	Utente u = abilita.getUtente().get(0);
	session.setAttribute("data", stringaData);
%>
<div
	style="background:url('GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=abilita.getIdAbilita()%>');"
	class="wrapper style1 sliderAttivita">
	<div class="icon-map_pin iconcine cittaAttivitaHeader" style="">
		<div class="fontMio"><%=u.getCittaAttuale()%></div>
	</div>

	<div class="titoloAttivitaHeader containerSlider">

		<h1>
			<a style="color: #fff;"
				href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>"><%=abilita.getNomeAbilita()%></a>
		</h1>
	</div>

</div>
<div style="background-color: #fff;" class="wrapper style1">
	<section id="features"
		class="container special attivitaContainerSporge">
		<%
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



				<%-- PARTE NUOVA --%>
				<div class="containerProfiloAbilita">

					<div class="minutiAbilita">
						<label>COSTO IN MINUTI</label>
						<div class="icon-clock iconcineAbilita" style="float: left;"></div><%=abilita.getMinuti()%>
					</div>

					<div class="prezzoAbilita">
						<label>COSTO IN DENARO</label>
						<div class="fa fa-eur iconcineAbilita" style="float: left;"></div>
						<%=abilita.getTariffa()%>
					</div>
					<div class=" centroAbilitaHeader">
						<div class="abilitaFotoProfiloContainer">
							<a
								href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.getIdUtente()%>">
								<img class="abilitaFotoProfilo"
								src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=u.getIdUtente()%>"
								alt="Foto Attività" />
							</a>
						</div>
						<div class="abilitaNome">
							<a
								href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.getIdUtente()%>"><%=u.getNome() + " " + u.getCognome()%>
							</a>
						</div>
					</div>
					<div class="minutiAbilitaCondivisi">
						<label>condivisi</label>
						<%=abilita.getMinutiCondivisi()%>
					</div>
					<div class="ratingAbilita">
						<label>Rating</label>
						<div class="stelleAbilita">
							<%
								int media = u.getMediaFeedback();
								for (int i = 1; i < 6; i++) {
									if (i <= media) {
							%>
							<a
								href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=u.getIdUtente()%>"
								class="fa fa-star" style="color: #2594c2; float: left;"> </a>

							<%
								} else {
							%>
							<a
								href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=u.getIdUtente()%>"
								class="fa fa-star
									 cuori"
								style="color: #f8f8f8; float: left;"></a>

							<%
								}
								}
							%>
						</div>



					</div>
					<div class="barraLaterale">
						<div class="dataPrenotazioneAbilita">
							<div class="clearfix">
								<a name="ancora"></a>

							</div>

							<p>
								<%
									//String stringaData = (String) session.getAttribute("data");
									if (stringaData == null || stringaData == "") {
								%>



								<input type="text" id="datepicker" name="data"
									value="Seleziona una data" />
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
						</div>


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
											tabella += "<div class=\"nomeGiorno\">Domenica</div>\n";
										} else if (giorno == 1) {
											tabella += "<div class=\"nomeGiorno\">Lunedì</div>\n";
										} else if (giorno == 2) {
											tabella += "<div class=\"nomeGiorno\">Martedì</div>\n";
										} else if (giorno == 3) {
											tabella += "<div class=\"nomeGiorno\">Mercoledì</div>\n";
										} else if (giorno == 4) {
											tabella += "<div class=\"nomeGiorno\">Giovedì</div>\n";
										} else if (giorno == 5) {
											tabella += "<div class=\"nomeGiorno\">Venerdì</div>\n";
										} else if (giorno == 6) {
											tabella += "<div class=\"nomeGiorno\">Sabato</div>\n";
										}
										tabella += "</tr>";

										List<String> disponibilita = (List<String>) session
												.getAttribute("disponibilita");
										String posizione = "";
										String[] valore = { "DO", "LU", "MA", "ME", "GI", "VE", "SA" };//checked="checked"
										for (int i = 0; i < 24; i++) {
											if (i == 0 || i == 8 || i == 16)
												tabella += "<div class=\"rigaOra\">\n";
											//for (int j = 0; j < 7; j++) {
											//tabella += "<td><input type=\"checkbox\" name=\"disponibilita\" value=\""+ valore[giorno] + i + "\" ";
											tabella += "<div class=\"casellaOra\"><input style='display:none;' type=\"checkbox\" name=\"disponibilita\" value=\""
													+ valore[giorno]
													+ i
													+ "\" id=\""
													+ valore[giorno]
													+ i + "\" ";

											posizione = valore[giorno] + i;
											if (!disponibilita.contains(posizione))
												/*tabella += "checked=\"checked\"";
												else*/
												tabella += "disabled=\"disabled\"";
											//}
											tabella += " />";
											tabella += "<label onclick='check(\"" + valore[giorno] + i
													+ "\")' for='" + valore[giorno] + i + "'><h2>" + i
													+ "</h2></label>";

											tabella += "</div>\n";

											tabella += "\n";
											if (i == 7 || i == 15 || i == 23)
												tabella += "</div>\n";

										}
										tabella += "</table>\n";
								%>
								<%=tabella%>


								<%
									}
								%>


								<%
									if (stringaData != null && stringaData != "") {
								%>
								<div class="actions">
									<button class="btn primary bottone" type="submit">Prenota</button>

								</div>

								<%
									} else {
										if (tok.getIdUtente() != u.getIdUtente()) {
								%>
								<div class="actions">
									<button class="btn primary bottone" type="submit">Verifica
										disponibilità</button>
								</div>
								<%
									} else {
								%>

								<a
									href="GestioneAbilitaServlet?to=redirectToPaginaModificaAbilita&idAbilita=<%=abilita.getIdAbilita()%>"
									class="btn ">Modifica Attività</a>
								<%
									}
									}
								%>
							</div>
						</div>
						<div class="minutiNecessariAbilita">
							<div style="font-size: 14px; clear: left; float: left;"><%=abilita.getMinutiNecessari()%></div>
							Minuti necessari per svolgere il lavoro
						</div>
						<div class="socialAbilita">
							<div class="social icon-facebook3"></div>
							<div class="social icon-twitter3"></div>
							<div class="social icon-google-plus3"></div>
						</div>
					</div>
					<div class="barraCentrale">
						<div class="descrizioneAbilita">

							<%=abilita.getDescrizioneAbilita()%></div>
						<div class="listaFotoAbilita">

							<img class="singolaFotoAbilita"
								src="GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=abilita.getIdAbilita()%>" />
						</div>
						<div class="lineaSeparatore"></div>

						<div class="listaFeedback">

							<%
								if (listaFeedbackRicevuti != null
										&& listaFeedbackRicevuti.size() != 0) {

									for (int i = 0; i < 3 && i < listaFeedbackRicevuti.size(); i++) {
							%>

							<div class="singoloFeedback">
								<div class="fotoProfiloFeedback">
									<img class="abilitaFotoProfilo"
										src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=listaFeedbackRicevuti.get(i)
							.getUtenteGiudicante().getIdUtente()%>"
										alt="Foto Attività" />
								</div>
								<div class="ratingFeedback">
									<%
										int mediaF = listaFeedbackRicevuti.get(i)
														.getVotoSintetico();
												for (int j = 1; j < 6; j++) {
													if (j <= mediaF) {
									%>
									<a
										href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=listaFeedbackRicevuti.get(i)
									.getUtenteGiudicante().getIdUtente()%>"
										class="fa fa-star" style="color: #2594c2; float: left;"> </a>
									<%
										} else {
									%>
									<a
										href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=listaFeedbackRicevuti.get(i)
									.getUtenteGiudicante().getIdUtente()%>"
										class="fa fa-star cuori" style="color: #f8f8f8; float: left;"></a>
									<%
										}
												}
									%>
								</div>


								<div class="sfondoFeedback">
									<div class="votoEsteso"><%=listaFeedbackRicevuti.get(i).getVotoEsteso()%></div>
								</div>


							</div>


							<%
								}
								}
							%>


						</div>

					</div>


					<br /> <br />
			</form>
	</section>
</div>
<%@ include file="../footer.jsp"%>