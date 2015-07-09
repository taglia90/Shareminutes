<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="../header.jsp"%>
<div class="wrapper style1">
	<section id="features" class="container special">
		
			
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
							<input id="fileInput" class="input-file" type="file" name="foto">
								<span class="help-block"> Deve avere estensione jpg, png
									o gif e dimensione inferiore a 1Mb </span>
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
						<label for="textarea">Inserire tag separati da uno spazio.</label>
						<div class="input">
							<textarea id="textarea2" class="xxlarge" rows="2" cols="120"
								name="tag"></textarea>
						</div>
					</div>
					<br /> <br />
					<div class="clearfix">
						<label>Minuti necessari per effettuare il lavoro indicato</label>
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
						<input type="checkbox" name="pubblicaAbilita" value="1" /> Attiva
						disponibilità.
					</div>
					<br /> <br /> <label>Paypal connect</label>

					<div class="actions">
						<button class="btn primary" type="submit">Conferma</button>
						<a
							href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaUser"
							class="btn">Annulla</a>
					</div>
				</form>
			

		


	</section>
</div>
<%@ include file="../footer.jsp"%>