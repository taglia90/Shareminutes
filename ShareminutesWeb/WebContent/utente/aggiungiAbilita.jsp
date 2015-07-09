<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="../header.jsp"%>
<div class="wrapper style1">
	<!-- content -->
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
			<h2>Lista Abilità</h2>
			<%
				List<Abilita> listaAbilitaUtente = (List<Abilita>) session
						.getAttribute("listaAbilitaUtente");
				List<Abilita> listaAbilitaNONDiUtente = (List<Abilita>) session
						.getAttribute("listaAbilitaNONDiUtente");

				if ((listaAbilitaUtente != null && listaAbilitaUtente.size() != 0)
						|| (listaAbilitaNONDiUtente != null && listaAbilitaNONDiUtente
								.size() != 0)) {
			%>
			<form enctype="multipart/form-data"
				action="GestioneAbilitaServlet?to=inserisciAbilitaUtente"
				method="post" name="form">
				<%
					for (Abilita abilita : listaAbilitaUtente) {
				%>

				<div class="clearfix">
					<div class="input">
						<input type="checkbox" name="idAbilita"
							value="<%=abilita.getIdAbilita()%>" checked="checked" />
					</div>
				</div>
				<div class="clearfix">
					Nome:
					<%=abilita.getNomeAbilita()%>
				</div>
				<div class="clearfix">
					Descrizione:
					<%=abilita.getDescrizioneAbilita()%>
				</div>
				<br /> <br />
				<%
					}
						for (Abilita abilita : listaAbilitaNONDiUtente) {
				%>

				<div class="clearfix">
					<div class="input">
						<input type="checkbox" name="idAbilita"
							value="<%=abilita.getIdAbilita()%>" />
					</div>
				</div>
				<div class="clearfix">
					Nome:
					<%=abilita.getNomeAbilita()%>
				</div>
				<div class="clearfix">
					Descrizione:
					<%=abilita.getDescrizioneAbilita()%>
				</div>
				<br /> <br />
				<%
					}
				%>

				<div class="actions">

					<button class="btn primary" type="submit">Conferma</button>
					<a
						href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaUser"
						class="btn">Annulla</a>
				</div>
			</form>


			<%
				} else {
			%>
			<strong>Non ci sono attività.</strong>
			<%
				}
			%>
			<br /> <a
				href="GestioneAbilitaServlet?to=redirectToPaginaCreazioneAbilita">Crea
				una nuova attività</a>
		
	</section>

</div>
<%@ include file="../footer.jsp"%>