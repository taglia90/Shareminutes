<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="../header.jsp"%>

<div class="wrapper style1">
	<section id="features" class="container special">
		<div class="containerRicerca">
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

				<div style="" class="titoloBlu">Ricerca</div>
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
									String orario = "<option value=\"\">Inserisci orario</option>";
									for (int i = 0; i < 24; i++) {
										orario += "<option value=\"" + i + "\" >" + i + "</option>";
									}
								%>
								<%=orario%>
								<!-- <option value="0">0</option>-->
							</select>
						</div>


					</div>
					<br />
					<div class="actions">
						<button class="btn primary bottone" type="submit">Cerca</button>

					</div>
				</form>
			</div>
		</div>
	</section>
</div>
<%@ include file="../footer.jsp"%>