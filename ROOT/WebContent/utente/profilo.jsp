<%@page import="control.GestioneAbilitaServlet"%>
<%@page import="entity.Follower"%>
<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="java.util.List"%>
<%@ page import="entity.Utente"%>
<%@ page import="entity.Abilita"%>
<%@ page import="entity.Tag"%>
<%@ page import="control.GestioneUtentiServlet"%>
<%@ page import="control.GestioneAbilita"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="../headerSfondo.jsp"%>
<%
	Abilita a0 = utente.getAbilita().get(0);
%>

<div class="wrapper style1 sliderProfilo" <%if (a0 != null) {%>
	style="background:url('GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=a0.getIdAbilita()%>');"
	<%}%>></div>
<section id="features" class="container special profiloContainerSporge">
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




	<div class="ProfiloContainer">
		<div class="sfondoGrigioProfilo">
			<div class="fotoPaginaProfilo">
				<img
					src="GestioneUtentiServlet?to=getFotoProfilo&idUtente=<%=utente.getIdUtente()%>"
					style="border-radius: 200em;" alt="Foto Profilo" />
			</div>
			<div class="parteDestra">

				<div class="headlineProfilo">
					<%
						String head = "";
						if (utente.getHeadline() != null)
							head = utente.getHeadline();
					%>"
					<%=head%>"
				</div>
				<div class="nomeProfilo">
					<%
						String nome = "";
						String cognome = "";
						if (utente.getNome() != null)
							nome = utente.getNome();
						if (utente.getCognome() != null)
							cognome = utente.getCognome();
					%>
					<%=nome + " " + cognome%>
				</div>
				<div class="cittaProfilo">
					<div class="icon-map_pin iconcine cittaProfiloPin" style=""></div>
					<%
						String citta = "";
						if (utente.getCittaAttuale() != null)
							citta = utente.getCittaAttuale();
					%>
					<%=citta%>
				</div>
				<div class="separatoreContainerProfilo">
					<div class="lineaSeparatore"></div>
				</div>

				<div class="ratingAbilita ">
					<label>Rating</label>
					<div class="stelleAbilita">
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
							class="fa fa-star
cuori" style="color: #f8f8f8; float: left;"></a>

						<%
							}
							}
						%>
					</div>



				</div>
				<%
					int minutiCond = 0;
					if (a0 != null) {
						minutiCond = minutiCond + a0.getMinuti();
					}

					Abilita a1 = utente.getAbilita().get(1);
					if (a1 != null) {
						minutiCond = minutiCond + a1.getMinuti();
					}
				%>
				<div class="minutiAbilitaCondivisi">
					<label>Minuti condivisi</label>
					<div class="icon-clock iconcineAbilita" style="float: left;"></div>
					<div class="numeroMinutiCondivisi"><%=minutiCond%></div>
				</div>

				<div class="followerProfilo">
					<label>Followers</label>
					<%
						int idU = utente.getIdUtente();
						GestioneUtentiServlet gu = new GestioneUtentiServlet();
						Long followers = gu.getNumeroDiFollowers(idU);
					%>
					<div class="numeroFollower"><%=followers%></div>


				</div>
			</div>
		</div>
		<div class="contenitoreParti">
			<div class="parteSinistraProfilo">
				<div class="tempoRispostaProfilo">

					<%
						int tempo = utente.getTempoMedioRisposta();
					%>
					<%=tempo%><label> Tempo medio risposta</label>
				</div>
				<div class="lineaSeparatore"></div>
				<div class="listaTag">
					<%
						GestioneAbilitaServlet ga = new GestioneAbilitaServlet();
						if (a0 != null) {
							List<Tag> listaTag = ga.getListaTag(a0.getIdAbilita());
							if (listaTag != null) {
								for (int i = 0; i < listaTag.size(); i++) {
									String singoloTag = listaTag.get(i).getStringaTag();
					%>
					<div class="singoloTag"><%=singoloTag%></div>
					<%
						}
							}
						}
						if (a1 != null) {
							List<Tag> listaTag = ga.getListaTag(a1.getIdAbilita());
							if (listaTag != null) {
								for (int i = 0; i < listaTag.size(); i++) {
									String singoloTag = listaTag.get(i).getStringaTag();
					%>
					<div class="singoloTag"><%=singoloTag%></div>
					<%
						}
							}
						}
					%>

				</div>
				<div class="lineaSeparatore clearBoth"></div>
				<%
					boolean isClienteOFornitore = false;
					/*if (session.getAttribute("isClienteOFornitore") != null) {
					 isClienteOFornitore = (boolean) session
					 .getAttribute("isClienteOFornitore");
					 }*/
					if ((Boolean) session.getAttribute("isClienteOFornitore")) {
				%>
				<div class="tastoContatta">
					<a
						href="GestioneRichiesteServlet?to=redirectToPaginaInvioRichiesta&idUtenteDestinatario=<%=utente.getIdUtente()%>">Contatta
						utente </a>
				</div>

				<%
					}
				%>

				<%
					if (utente.getIdUtente() == tok.getIdUtente()) {
				%>
				<div class="modificaProfiloTasto">
					<a
						href="GestioneUtentiServlet?to=redirectToPaginaModificaProfilo&idUtente=<%=tok.getIdUtente()%>"
						class="bottone">Modifica Profilo</a> <br /> <br />
				</div>
				<%
					} else {
				%>
				<div class="scrittaFollowerBarra">Follower</div>
				<div class="numeroFollowerBarra"><%=followers%></div>
				<div class="icon-ribbon iconcine cittaProfiloPin ribbon"></div>
				<div class=" followTasto ">
					<a
						href="GestioneAmicizieServlet?to=aggiungiFollower&idUtenteFoll=<%=utente.getIdUtente()%>"
						class="btn">Follow</a> <br /> <br />
				</div>
				<%
					}
				%>




				<div class="lineaSeparatore clearBoth"></div>
				<div class="connect">Connect</div>
				<div class="socialAbilita">
					<div class="social icon-facebook3"></div>
					<div class="social icon-twitter3"></div>
					<div class="social icon-google-plus3"></div>
				</div>
			</div>
			<div class="parteDestraProfilo">
				<div class="attivitaProfilo">Attivita</div>

				<div class="separatoreContainerProfilo2">
					<div class="lineaSeparatore clearBoth"></div>
				</div>
				<%
					if (a0 != null) {
				%>
				<article class="4u special">

					<div class="risultatoRicercaCentro">

						<div class="risultatoRicercaFoto">
							<a
								href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a0.getIdAbilita()%>"
								class="image featured"> <img class="fotoAttivita"
								src="GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=a0.getIdAbilita()%>"
								height="200" width="200" alt="Foto Attività" /></a>
						</div>
						<div class="risultatoRicercaFeedback">
							<%
								int media2 = utente.getMediaFeedback();
									for (int i = 1; i < 6; i++) {
										if (i <= media2) {
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
					</div>
					<div class="risultatoRicercaFooter">
						<div class="risultatoRicercaNomeAttivita">
							<a
								href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a0.getIdAbilita()%>">
								<%=a0.getNomeAbilita()%>
							</a>
						</div>
						<div class="risultatoRicercaMinuti">
							<div class="icon-clock iconcine" style="float: left;"></div>
							<a
								href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a0.getIdAbilita()%>">
								<%=a0.getMinuti() + "min"%>
							</a>
						</div>
						<div class="risultatoRicercaPrezzo">
							<div class=" fa fa-eur iconcine" style="float: left;"></div>
							<a
								href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a0.getIdAbilita()%>">
								<%=a0.getTariffa()%></a>

						</div>
					</div>
				</article>

				<%
					}

					if (a1 != null) {
				%>
				<article class="4u special">

					<div class="risultatoRicercaCentro">

						<div class="risultatoRicercaFoto">
							<a
								href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a1.getIdAbilita()%>"
								class="image featured"> <img class="fotoAttivita"
								src="GestioneAbilitaServlet?to=getFotoAbilita&idAbilita=<%=a1.getIdAbilita()%>"
								height="200" width="200" alt="Foto Attività" /></a>
						</div>
						<div class="risultatoRicercaFeedback">
							<%
								int media2 = utente.getMediaFeedback();
									for (int i = 1; i < 6; i++) {
										if (i <= media2) {
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
					</div>
					<div class="risultatoRicercaFooter">
						<div class="risultatoRicercaNomeAttivita">
							<a
								href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a1.getIdAbilita()%>">
								<%=a1.getNomeAbilita()%>
							</a>
						</div>
						<div class="risultatoRicercaMinuti">
							<div class="icon-clock iconcine" style="float: left;"></div>
							<a
								href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a1.getIdAbilita()%>">
								<%=a1.getMinuti() + "min"%>
							</a>
						</div>
						<div class="risultatoRicercaPrezzo">
							<div class=" fa fa-eur iconcine" style="float: left;"></div>
							<a
								href="GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita=<%=a1.getIdAbilita()%>">
								<%=a1.getTariffa()%></a>

						</div>
					</div>
				</article>
				<%
					}
				%>
				<div class="separatoreContainerProfilo2 clearBoth">
					<div class="lineaSeparatore clearBoth"></div>
				</div>

				<div class="labelChiSono">
					<label>Chi sono:</label>
				</div>
				<div class="chiSono">
					<br>
					<%
						String bio = "";
						if (utente.getBiografia() != null)
							bio = utente.getBiografia();
					%>
					<%=bio%>
				</div>

			</div>
		</div>


	</div>
</section>
<div class="wrapper style1 sfondoGrigio">
	<section id="features" class="container special ">

		<div class="homeWaiting">
			<div class="waiting">What are you waiting?</div>
			<div class="startWaiting">
				<a href="GestionePagineServlet?to=redirectToPaginaBuy"
					class="bottoneHome">SEARCH TO BUY</a>
			</div>
			<div class="searchWaiting">
				<a href="GestionePagineServlet?to=redirectToPaginaSell"
					class="bottoneHome">START SELLING NOW</a>
			</div>
		</div>
	</section>
</div>


<%@ include file="../footer.jsp"%>