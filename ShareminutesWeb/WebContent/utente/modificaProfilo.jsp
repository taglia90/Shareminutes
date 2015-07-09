<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>

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
		<h2>Modifica Profilo</h2>
		<br />
		<%
			utente = (Utente) session.getAttribute("utente");
		%>
		<form enctype="multipart/form-data"
			action="GestioneUtentiServlet?to=modificaProfilo&idUtente=<%=tok.getIdUtente()%>"
			method="post">
			<div class="clearfix">
				<img
					src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=tok.getIdUtente()%>"
					height="200" alt="Foto Profilo" />
			</div>

			<div class="clearfix">
				<label for="fileInput">Foto</label>
				<div class="input">
					<input id="fileInput" class="input-file" type="file" name="foto" />
					<span class="help-block"> La foto deve avere estensione jpg,
						png o gif e dimensione inferiore a 1Mb </span>
				</div>
			</div>
			<br /> <br /> <br /> <br />
			<div class="clearfix">
				<label>Nome</label>
				<%
					String nome = "";
					if (utente.getNome() != null)
						nome = utente.getNome();
				%>
				<div class="input">
					<input type="text" name="nome" value="<%=nome%>" />
				</div>
			</div>

			<br /> <br />
			<div class="clearfix">
				<label>Cognome</label>
				<%
					String cognome = "";
					if (utente.getCognome() != null)
						cognome = utente.getCognome();
				%>
				<div class="input">
					<input type="text" name="cognome" value="<%=cognome%>" />
				</div>
			</div>

			<br /> <br />
			<div class="clearfix">
				<label>Sesso</label>
				<%--
								String sesso = "";
								if (utente.getSesso() != null)
									sesso = utente.getSesso();
							--%>
				<div class="input">
					<select name="sesso">
						<%
							String maschio = "";
							String femmina = "";
							if (utente.getSesso() != null) {
								if (utente.getSesso().equals("maschio")) {
									maschio = "selected=\"selected\"";
								} else {
									femmina = "selected=\"selected\"";
								}
							}
						%>
						<option value="maschio" <%=maschio%>>Maschio</option>

						<option value="femmina" <%=femmina%>>Femmina</option>
					</select>
				</div>
			</div>

			<br /> <br />
			<div class="clearfix">
				<label>Età</label>
				<%
					int eta = 0;
					if (utente.getEta() != null)
						eta = Integer.parseInt(utente.getEta());
				%>
				<div class="input">
					<select name="eta">
						<%
							String codice = "";
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

			<br /> <br />
			<div class="clearfix">
				<label>Headline</label>
				<%
					String head = "";
					if (utente.getHeadline() != null)
						head = utente.getHeadline();
				%>
				<div class="input">
					<input type="text" name="headline" value="<%=head%>" />
				</div>
			</div>

			<br /> <br />
			<div class="clearfix">
				<label>Posizione Lavorativa / Titolo di studio</label>
				<div class="input">
					<%
						String pos = "";
						if (utente.getPosizioneLavorativa() != null)
							pos = utente.getPosizioneLavorativa();
					%>
					<input type="text" name="posizioneLavorativa" value="<%=pos%>" />
				</div>
			</div>

			<br /> <br />
			<div class="clearfix">
				<label>Paese</label>
				<%
					String paese = "";
					if (utente.getPaese() != null)
						paese = utente.getPaese();
				%>
				<div class="input">
					<input type="text" name="paese" value="<%=paese%>" />
				</div>
			</div>

			<br /> <br />
			<div class="clearfix">
				<label>Città</label>
				<%
					String citta = "";
					if (utente.getCittaAttuale() != null)
						citta = utente.getCittaAttuale();
				%>
				<div class="input">
					<input type="text" name="citta" value="<%=citta%>" />
				</div>
			</div>

			<br /> <br />
			<div class="clearfix">
				<label>CAP</label>
				<%
					String cap = "";
					if (utente.getCap() != null)
						cap = utente.getCap();
				%>
				<div class="input">
					<input type="text" name="cap" value="<%=cap%>" />
				</div>
			</div>

			<br /> <br />
			<div class="clearfix">
				<label for="textarea">Breve biografia</label>
				<%
					String bio = "";
					if (utente.getBiografia() != null)
						bio = utente.getBiografia();
				%>
				<div class="input">
					<textarea id="textarea2" class="xxlarge" rows="10" cols="120"
						name="biografia"><%=bio%></textarea>
				</div>
			</div>
			<br /> <br /> <br /> <br />
			<div class="clearfix">
				<input type="checkbox" name="pubblicaProfilo" value="1" /> Rendi
				pubblico il mio profilo
			</div>
			<br />
			<div class="actions">
				<button class="btn primary" type="submit">Salva</button>
				<a href="GestioneUtentiServlet?to=redirectToPaginaProfilo"
					class="btn">Annulla</a>
			</div>
		</form>
	</section>
</div>
<%@ include file="../footer.jsp"%>