<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>

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
	</section>
</div>
<%@ include file="../footer.jsp"%>