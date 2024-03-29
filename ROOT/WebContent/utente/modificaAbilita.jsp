<%@page import="entity.Disponibilita"%>
<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="../header.jsp"%>
<div class="wrapper style1 conSecondoMenu">
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
		<%
			Abilita abilita = (Abilita) session.getAttribute("abilita");
			String tag = (String) session.getAttribute("tag");
		%>
		<div style="" class="modificaProfiloContainer">

			<div style="" class="titoloBlu">
				Modifica attivit� "<%=abilita.getNomeAbilita()%>"
			</div>
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
					<img class="imgAttivita"
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
						<textarea id="textarea2" class="xxlarge" rows="10" cols="70"
							name="descrizione"><%=abilita.getDescrizioneAbilita()%></textarea>
					</div>
				</div>
				<br /> <br />
				<div class="clearfix">
					<label for="textarea">Inserire tag separati da uno spazio.</label>
					<div class="input">
						<textarea id="textarea2" class="xxlarge" rows="2" cols="70"
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
						<input type="text" name="minuti" value="<%=abilita.getMinuti()%>" />
					</div>
				</div>
				<br /> <br />


				<!-- 
						<div class="clearfix">
							<label>Selezionare i giorni della settimana e le fasce
								orarie in cui si � disponibili per l'attivit�.</label>

							<div class="input">

								<%--
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
								<%=tabella--%>
 -->
				<!-- <label>Luned�</label>
									<select name="disponibilitaLuned�">
										<option value="Luned�0">0</option>
										<option value="Luned�1">1</option>
									</select> -->
				<!--					</div>
						</div>
-->

				<div class="clearfix">
					<label>Selezionare le fasce orarie o i giorni della
						settimana in cui non si vuole ricevere nessuna offerta.</label>
					<table>
						<tr>

							<th class="colonnaModificaOra">Lun</th>

							<th class="colonnaModificaOra">Mar</th>

							<th class="colonnaModificaOra">Mer</th>

							<th class="colonnaModificaOra">Gio</th>

							<th class="colonnaModificaOra">Ven</th>

							<th class="colonnaModificaOra">Sab</th>

							<th class="colonnaModificaOra">Dom</th>
						</tr>
						<%
							List<String> disponibilita = (List<String>) session
									.getAttribute("disponibilita");
							String tabella = "";
							String posizione = "";
							String[] valore = { "LU", "MA", "ME", "GI", "VE", "SA", "DO" };//checked="checked"
							for (int i = 0; i < 24; i++) {
								//tabella += "<tr>\n<th>" + i + "</th>\n";
								for (int j = 0; j < 7; j++) {
									tabella += "<td><div class=\"casellaOraModifica\"><input style='display:none;' type=\"checkbox\" name=\"disponibilita\" value=\""
											+ valore[j]
											+ i
											+ "\" id=\""
											+ valore[j]
											+ i
											+ "\" ";
									//input style='display:none;' class='check_task' type='checkbox' id='task_"+ stanza[i].task_id +"' value='"+ stanza[i].task_id +"' />
									//<label onclick='check(\""+ stanza[i].task_id +"\")' for='task_"+ stanza[i].task_id +"'><h2>" + stanza[i].nome_task + "</h2></label>

									posizione = valore[j] + i;
									if (disponibilita.contains(posizione))
										tabella += "checked=\"checked\"";

									tabella += " />";
									tabella += "<label onclick='check(\"" + valore[j] + i
											+ "\")' for='" + valore[j] + i + "'><h2>" + i
											+ "</h2></label>";

									tabella += "</div></td>\n";
									tabella += "\n";

								}
								tabella += "</tr>\n";
							}
						%>
						<%=tabella%>

					</table>
				</div>
				<br /> <br /> <br /> <br /> <label>Paypal connect</label>
				<div class="clearfix">
					<input type="checkbox" name="pubblicaAbilita" value="1" /> Attiva
					disponibilit�.
				</div>
				<br /> <br /> <br /> <br />
				<div class="actions">
					<button class="btn primary bottoneMedium" type="submit">Conferma</button>
					<a
						href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaUser"
						class="btn ">Annulla</a>
				</div>
			</form>
		</div>
	</section>

</div>
<%@ include file="../footer.jsp"%>