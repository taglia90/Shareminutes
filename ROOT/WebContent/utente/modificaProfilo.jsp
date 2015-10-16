<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>

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

		<div class="modificaProfiloContainer">
			<%
				utente = (Utente) session.getAttribute("utente");
			%>
			<div class="titoloModificaProfilo">Modifica Profilo</div>
			<form enctype="multipart/form-data"
				action="GestioneUtentiServlet?to=modificaProfilo&idUtente=<%=tok.getIdUtente()%>"
				method="post" name="form">

				<div class="zonaFotoModifica">
					<div class="fotoModifica">
						<img
							src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=tok.getIdUtente()%>"
							width="100%" alt="Foto Profilo" />
					</div>

					<div class="labelModifica">

						<div class="input">
							<input id="fileInput" class="input-file" type="file" name="foto" />
							<span style="text-align: center;" class="help-block"> La
								foto deve avere estensione jpg, png o gif e dimensione inferiore
								a 1Mb </span>
						</div>
					</div>
				</div>

				<div class="labelModifica">

					<%
						String nome = "";
						if (utente.getNome() != null)
							nome = utente.getNome();
					%>
					<div class="input">
						<input type="text" name="nome" value="<%=nome%>"
							placeholder="Nome" />
					</div>
				</div>

				<div class="labelModifica">

					<%
						String cognome = "";
						if (utente.getCognome() != null)
							cognome = utente.getCognome();
					%>
					<div class="input">
						<input type="text" name="cognome" value="<%=cognome%>"
							placeholder="Cognome" />
					</div>
				</div>

				<div class="labelModifica">
					<label>Sesso</label>
					<div class="input">
						<%
							String maschio = "";
							String femmina = "";
							if (utente.getSesso() != null) {
								if (utente.getSesso().equals("maschio")) {
									maschio = "checked";
								} else {
									femmina = "checked";
								}
							}
						%>
						<div>
							<input type="radio" name="sesso" value="maschio" <%=maschio%> />
							Maschio <input type="radio" name="sesso" value="femmina"
								<%=femmina%> /> Femmina
						</div>

						<!-- 
						<select name="sesso">
							<%--
								String maschio = "";
								String femmina = "";
								if (utente.getSesso() != null) {
									if (utente.getSesso().equals("maschio")) {
										maschio = "selected=\"selected\"";
									} else {
										femmina = "selected=\"selected\"";
									}
								}
							--%>
							<option value="maschio" <%=maschio%>>Maschio</option>

							<option value="femmina" <%=femmina%>>Femmina</option>
						</select>
						 -->
					</div>
				</div>
				<div class="labelModifica">

					<%
						int eta = 0;
						if (utente.getEta() != null)
							eta = Integer.parseInt(utente.getEta());
					%>
					<div class="input">
						<select name="eta">
							<%
								String codice = "";
								codice += "<option value=\"0\">Età</option>";
								for (int i = 18; i < 100; i++) {
									codice += "<option value=\"" + i + "\" ";
									if (eta == i) {
										codice += "selected=\"selected\"";
									}
									codice += ">" + i + "</option>";
								}
							%>
							<%=codice%>
							<!-- <option value="0">0</option>-->
						</select>
					</div>
				</div>

				<div class="labelModifica">

					<%
						String head = "";
						if (utente.getHeadline() != null)
							//|| !utente.getHeadline().equals(""))
							head = utente.getHeadline();
					%>
					<div class="input">
						<input type="text" name="headline" value="<%=head%>"
							placeholder="Headline" />
					</div>
				</div>

				<div class="labelModifica">

					<div class="input">
						<%
							String pos = "";
							if (utente.getPosizioneLavorativa() != null)
								pos = utente.getPosizioneLavorativa();
						%>
						<input type="text" name="posizioneLavorativa" value="<%=pos%>"
							placeholder="Posizione Lavorativa / Titolo di studio" />
					</div>
				</div>

				<div class="labelModifica">

					<%
						String paese = "";
						if (utente.getPaese() != null)
							paese = utente.getPaese();
					%>
					<div class="input">
						<input type="text" name="paese" value="<%=paese%>"
							placeholder="Paese" />
					</div>
				</div>

				<div class="labelModifica">

					<%
						String citta = "";
						if (utente.getCittaAttuale() != null)
							citta = utente.getCittaAttuale();
					%>
					<div class="input">
						<input type="text" name="citta" value="<%=citta%>"
							placeholder="Città" />
					</div>
				</div>

				<div class="labelModifica">

					<%
						String cap = "";
						if (utente.getCap() != null)
							cap = utente.getCap();
					%>
					<div class="input">
						<input type="text" name="cap" value="<%=cap%>" placeholder="CAP" />
					</div>
				</div>

				<div class="labelModifica">
					<%
						String bio = "";
						if (utente.getBiografia() != null)
							bio = utente.getBiografia();
					%>
					<div class="input">
						<textarea id="textarea2" class="xxlarge" rows="10" cols="70"
							name="biografia" placeholder="Breve biografia"><%=bio%></textarea>
					</div>
				</div>

				<div class="labelModifica">
					<input type="checkbox" name="pubblicaProfilo" value="1" /> Rendi
					pubblico il mio profilo

				</div>

				<div class="actions">
					<button class="bottone" type="submit">Salva</button>
					<a style="margin-left: 50px;"
						href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=tok.getIdUtente()%>"
						class="btn">Annulla</a>
				</div>
			</form>
		</div>
	</section>
</div>
<%@ include file="../footer.jsp"%>