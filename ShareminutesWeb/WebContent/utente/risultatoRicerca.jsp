<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>
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
		<h2>Risultato ricerca</h2>

		<%
			List<Abilita> listaAbilita = (List<Abilita>) session
					.getAttribute("listaAbilita");
			if (listaAbilita != null && listaAbilita.size() != 0) {
		%>
		<table class="zebra-striped">
			<thead>
				<tr>
					<th>Foto</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Titolo</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Utente</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Città</th>

				</tr>
			</thead>
			<tbody>
				<%
					for (Abilita abilita : listaAbilita) {
							List<Utente> u = (List<Utente>) abilita.getUtente();
				%>
				<tr>
					<td><img
						src="GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=abilita.getIdAbilita()%>"
						height="200" width="200" alt="Foto Attività" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><a
						href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>"><%=abilita.getNomeAbilita()%>
					</a><br /> <a
						href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>">Minuti
							condivisi: <%=abilita.getMinutiCondivisi()%>
					</a><br /> <a
						href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=abilita.getIdAbilita()%>">Prezzo:
							<%=abilita.getTariffa() + "/" + abilita.getMinuti()
							+ "min"%></a></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><a
						href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.get(0).getIdUtente()%>"><%=u.get(0).getNome() + " " + u.get(0).getCognome()%> </a> <br /> <img
						src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=u.get(0).getIdUtente()%>"
						height="100" width="100" alt="Foto Attività" /> <br /> <a
						href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&usernameUtente=<%=u.get(0).getIdUtente()%>">Vedi
							feedback utente</a><br /> Stelle: 5</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><%=u.get(0).getCittaAttuale()%></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a
						href="GestioneRichiesteServlet?to=redirectToPaginaInvioRichiesta&usernameDestinatario=<%=u.get(0).getIdUtente()%>">Invia
							richiesta</a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			} else {
		%>
		<strong>Nessun risultato trovato.</strong>
		<%
			}
		%>
		<br /> <br />



		<!--  
					<%--List<Utente> listaUtentiAmici = (List<Utente>) session
					.getAttribute("listaUtentiAmici");

			List<Utente> listaUtentiNONAmici = (List<Utente>) session
					.getAttribute("listaUtentiNONAmici");
			if ((listaUtentiAmici != null && listaUtentiAmici.size() != 0)
					|| (listaUtentiNONAmici != null && listaUtentiNONAmici
							.size() != 0)) {%>

					<table class="zebra-striped">
						<thead>
							<tr>
								<th>Foto</th>
								<th>&nbsp;&nbsp;&nbsp;</th>
								<th>Username</th>
								<th>&nbsp;&nbsp;&nbsp;</th>
								<th>Nome</th>
								<th>&nbsp;&nbsp;&nbsp;</th>
								<th>Cognome</th>
								<th>&nbsp;&nbsp;&nbsp;</th>
								<th></th>
								<th>&nbsp;&nbsp;&nbsp;</th>
								<th></th>
								<th>&nbsp;&nbsp;&nbsp;</th>
								<th></th>
								<th>&nbsp;&nbsp;&nbsp;</th>
							</tr>
						</thead>
						<tbody>
							<%for (Utente utente : listaUtentiAmici) {%>

							<tr>

								<td align="center"><img
									src="GestioneUtentiServlet?to=getFotoProfilo&username=<%=utente.getUsername()%>"
									height="80" alt="Foto Profilo" /></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getUsername()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getNome()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getCognome()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&usernameUtente=<%=utente.getUsername()%>">Vedi
										feedback</a></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneRichiesteServlet?to=redirectToPaginaInvioRichiesta&usernameDestinatario=<%=utente.getUsername()%>">Invia
										richiesta</a></td>
								<td></td>
							</tr>
							<%}%>
							<%for (Utente utente : listaUtentiNONAmici) {%>

							<tr>
								<td align="center"><img
									src="GestioneUtentiServlet?to=getFotoProfilo&username=<%=utente.getUsername()%>"
									height="80" alt="Foto Profilo" /></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getUsername()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getNome()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><%=utente.getCognome()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&usernameUtente=<%=utente.getUsername()%>">Vedi
										feedback</a></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneAmicizieServlet?to=creaAmicizia&usernameUtenteAmico=<%=utente.getUsername()%>">Aggiungi
										agli amici</a></td>

							</tr>
							<%}%>
						</tbody>
					</table>
					<%} else {%>
					<strong>La ricerca non ha prodotto risultati.</strong>
					<%}--%>
-->
	</section>

</div>
<%@ include file="../footer.jsp"%>