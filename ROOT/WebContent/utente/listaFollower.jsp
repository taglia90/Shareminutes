<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Utente"%>
<%@ page import="entity.Abilita"%>
<%@ page import="entity.Follower"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="../header.jsp"%>
<div class="wrapper style1 conSecondoMenu">
	<section id="features" class="container special">
		<div class="modificaProfiloContainer">
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

			<%--
						List<Utente> listaAmicizieDaAccettare = (List<Utente>) session
								.getAttribute("listaAmiciInSospeso");
						if (listaAmicizieDaAccettare != null
								&& listaAmicizieDaAccettare.size() != 0) {
					--%>

			<!-- 
					<br />
					<h2>Amicicizie da accettare:</h2>
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
							<%--
								for (Utente utente : listaAmicizieDaAccettare) {
							%>
							<tr>
								<td align="center"><img
									src="GestioneUtentiServlet?to=getFotoProfilo&username=<%=utente.getUsername()%>"
									height="80" alt="Foto Profilo" /></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><%--=utente.getUsername()%></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><%--=utente.getNome()%></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><%--=utente.getCognome()%></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

								<td><a
									href="GestioneAmicizieServlet?to=valutaRichiestaDiAmicizia&usernameUtenteAmico=<%--=utente.getUsername()%>&isApprovata=true">Accetta</a></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneAmicizieServlet?to=valutaRichiestaDiAmicizia&usernameUtenteAmico=<%--=utente.getUsername()%>&isApprovata=false">Rifiuta</a></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<%--
								}
							%>
						</tbody>
					</table>
					<br /> <br />
					
					
					<%--
						}
					--%>
-->
			<%
				if ((Boolean) session.getAttribute("soloPreferiti") == false) {
			%>

			<div class="clearfix">
				<a
					href="GestioneAmicizieServlet?to=redirectToPaginaFollowerPreferiti"
					class="btn">Visualizza solo i preferiti</a>
			</div>
			<%
				} else {
			%>
			<div class="clearfix">
				<a href="GestioneAmicizieServlet?to=redirectToPaginaFollower"
					class="btn">Visualizza tutti</a>

			</div>
			<%
				}
			%>



			<div style="" class="titoloBlu">Ecco i tuoi follower:</div>
			<%
				List<Follower> listaFollower = (List<Follower>) session
						.getAttribute("listaFollower");
				//System.out.println("listamici"+listaAmici);
				if (listaFollower != null && listaFollower.size() != 0) {
			%>
			<div class="tabellaFollower">


				<%
					//Utente utente;
						for (Follower follower : listaFollower) {
							utente = follower.getUtenteSeguito();
				%>

				<div class="singoloFollower">
					<div class="fotoProfiloFeedback">
						<img
							src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=utente.getIdUtente()%>"
							alt="Foto Profilo" />
					</div>
					<div class="nomeUtenteFeedback">
						<a
							href="GestioneUtentiServlet?to=redirectToPaginaProfilo&idUtente=<%=utente.getIdUtente()%>"><%=utente.getNome()%>
							<%=utente.getCognome()%></a>
					</div>
					<div class="vediFeedback">
						<%
							int media = utente.getMediaFeedback();
									for (int i = 1; i < 6; i++) {
										if (i <= media) {
						%>
						<a
							href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=utente.getIdUtente()%>"
							class="fa fa-star" style="color: #2594c2; float: left;"> </a>

						<%
							} else {
						%>
						<a
							href="GestioneFeedbackServlet?to=redirectToPaginaListaFeedback&idUtente=<%=utente.getIdUtente()%>"
							class="fa fa-star cuori" style="color: #f8f8f8; float: left;"></a>

						<%
							}
									}
						%>
					</div>
					<div class="abilitaFollower">
						<%
							List<Abilita> listaAbilita = utente.getAbilita();
									if (listaAbilita.size() > 0) {
						%><a
							href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=listaAbilita.get(0).getIdAbilita()%>"><%=listaAbilita.get(0).getNomeAbilita()%>
						</a>
						<%
							}
						%>
					</div>

					<div class="abilitaFollower2">
						<%
							if (listaAbilita.size() > 1) {
						%><a
							href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=listaAbilita.get(1).getIdAbilita()%>"><%=listaAbilita.get(1).getNomeAbilita()%>
						</a>
						<%
							}
						%>
					</div>

					<div class="aggiungiRimuoviPreferito">
						<%
							if (follower.isPreferito() == false) {
						%><a
							href="GestioneAmicizieServlet?to=aggiungiFollowerAPreferiti&idFollower=<%=follower.getIdFollower()%>">Aggiungi
							a preferiti</a>
						<%
							} else {
						%><a
							href="GestioneAmicizieServlet?to=rimuoviFollowerDaPreferiti&idFollower=<%=follower.getIdFollower()%>">Togli
							dai preferiti</a>
						<%
							}
						%>
					</div>

					<div class="rimuoviFollower">
						<a
							href="GestioneAmicizieServlet?to=eliminaFollower&idFollower=<%=follower.getIdFollower()%>">Elimina
							Follower</a>
					</div>
				</div>

				<%
					}
				%>


			</div>

			<%
				} else {
			%>
			<strong>Non hai follower.</strong>
			<%
				}
			%>
		</div>
	</section>

</div>
<%@ include file="../footer.jsp"%>