<%@page import="control.GestionePrenotazioni"%>
<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>
<%@ page import="entity.Prenotazione"%>
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
			List<Utente> listaAmicizieDaAccettare = (List<Utente>) session
					.getAttribute("listaAmiciInSospeso");
			if (listaAmicizieDaAccettare != null
					&& listaAmicizieDaAccettare.size() != 0) {
		%>
		<br />
		<h2>Follower da accettare:</h2>
		<table class="zebra-striped">
			<thead>
				<tr>
					<th>Foto</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Username</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Nome</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Cognome</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th></th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
					for (Utente u : listaAmicizieDaAccettare) {
				%>
				<tr>
					<td align="center"><img
						src="GestioneUtentiServlet?to=getFotoProfilo&username=<%=u.getUsername()%>"
						height="80" alt="Foto Profilo" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><%=u.getUsername()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><%=u.getNome()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><%=u.getCognome()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

					<td><a
						href="GestioneAmicizieServlet?to=valutaRichiestaDiAmicizia&usernameUtenteAmico=<%=u.getUsername()%>&isApprovata=true">Accetta</a></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><a
						href="GestioneAmicizieServlet?to=valutaRichiestaDiAmicizia&usernameUtenteAmico=<%=u.getUsername()%>&isApprovata=false">Rifiuta</a></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<br />
		<%
			}
		%>

		<div class="modificaProfiloContainer">

			<div style="" class="titoloBlu">Ecco i tuoi clienti:</div>
			<%
				List<Prenotazione> listaClienti = (List<Prenotazione>) session
						.getAttribute("listaClienti");
				//System.out.println("listamici"+listaAmici);
				if (listaClienti != null && listaClienti.size() != 0) {
			%>
			<div class="tabellaClienti">
				
				
					<%
						Utente u;
							//GestionePrenotazioni gp = new GestionePrenotazioni();
							Long numeroVendite;
							for (Prenotazione prenotazione : listaClienti) {
								u = prenotazione.getUtenteBuyer();
								numeroVendite = prenotazione.getNumeroVendite();//gp.getNumeroVendite(u.getIdUtente(),prenotazione.getUtenteSeller().getIdUtente());
					%>

					<div class="singoloCliente">
						<div class="fotoProfiloFeedback"><img
							src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=u.getIdUtente()%>"
							 alt="Foto Profilo" /></div>
						<div class="nomeUtenteFeedback">
					    <a href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.getIdUtente()%>"><%=u.getNome()%> <%=u.getCognome()%></a></div>
						
						
					
								<div class="vediFeedback">
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
										class="fa fa-star cuori" style="color: #f8f8f8; float: left;"></a>
									<%
										}
												}
									%>
								</div>
								<div class="numeroVendite"><a
							href="GestionePagineServlet?to=redirectToGestioneOrdini&idUtente=<%=u.getIdUtente()%>">Vendite: <%=numeroVendite%>
						</a></div>
						<div class="inviaMessaggio"><a
							href="GestioneRichiesteServlet?to=redirectToPaginaInvioRichiesta&idUtenteDestinatario=<%=u.getIdUtente()%>">Contatta
						</a></div>
					</div>
					
					<%
						}
					%>
			

			</div>

			<%
				} else {
			%>
			<strong>Non hai clienti.</strong>
			<%
				}
			%>
		</div>
		<div style="margin-top: 50px !important;"
			class="modificaProfiloContainer">

			<div style="" class="titoloBlu">Ecco i tuoi fornitori:</div>
			<%
				List<Prenotazione> listaFornitori = (List<Prenotazione>) session
						.getAttribute("listaFornitori");
				//System.out.println("listamici"+listaAmici);
				if (listaFornitori != null && listaFornitori.size() != 0) {
			%>
			<div class="tabellaClienti">
				
				
					<%
						//GestionePrenotazioni gp = new GestionePrenotazioni();
							Long numeroAcquisti;
							Utente u;
							for (Prenotazione prenotazione : listaFornitori) {
								u = prenotazione.getUtenteSeller();
								numeroAcquisti = prenotazione.getNumeroAcquisti();//gp.getNumeroAcquisti(u.getIdUtente(),prenotazione.getUtenteBuyer().getIdUtente());
					%>

					<div class="singoloCliente">
						<div class="fotoProfiloFeedback" ><img
							src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=u.getIdUtente()%>"
							 alt="Foto Profilo" /></div>
					
						<div class="nomeUtenteFeedback">
					    <a href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=u.getIdUtente()%>"><%=u.getNome()%> <%=u.getCognome()%></a></div>
						
						
					
								<div class="vediFeedback">
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
										class="fa fa-star cuori" style="color: #f8f8f8; float: left;"></a>
									<%
										}
												}
									%>
								</div>
						<div class="numeroVendite"><a
							href="GestionePagineServlet?to=redirectToGestioneOrdini&idUtente=<%=u.getIdUtente()%>"> Acquisti: <%=numeroAcquisti%>
						</a></div>
						
						<div class="inviaMessaggio"><a
							href="GestioneRichiesteServlet?to=redirectToPaginaInvioRichiesta&idUtenteDestinatario=<%=u.getIdUtente()%>">Contatta
						</a></div>
					</div>
					
					<%
						}
					%>
			

			</div>

			<%
				} else {
			%>
			<strong>Non hai fornitori.</strong>
			<%
				}
			%>
		</div>
	</section>

</div>
<%@ include file="../footer.jsp"%>