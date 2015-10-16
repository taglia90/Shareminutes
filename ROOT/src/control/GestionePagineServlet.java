package control;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import remote.GestioneAbilitaRemote;
import remote.GestionePrenotazioniRemote;
import remote.GestioneRichiesteRemote;
import remote.GestioneUtentiRemote;
import util.LoginToken;
import entity.Abilita;
import entity.Messaggio;
import entity.Prenotazione;
import entity.Richiesta;
import entity.Utente;

public class GestionePagineServlet extends Servlet {

	private static final long serialVersionUID = 6145985715897698499L;

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String to = (String) request.getParameter("to");
		if (to.equals("redirectToPaginaCommunity"))
			this.redirectToPaginaCommunity(request, response);
		if (to.equals("redirectToPaginaSell"))
			this.redirectToPaginaSell(request, response);
		if (to.equals("redirectToPaginaBuy"))
			this.redirectToPaginaBuy(request, response);
		if (to.equals("redirectToIndex"))
			this.redirectToIndex(request, response);
		if (to.equals("redirectToGestioneOrdini"))
			this.redirectToGestioneOrdini(request, response);
		if (to.equals("redirectToDettaglioOrdine"))
			this.redirectToDettaglioOrdine(request, response);
		if (to.equals("redirectToClientiEFornitori"))
			this.redirectToClientiEFornitori(request, response);
		if (to.equals("redirectToPreferiti"))
			this.redirectToPreferiti(request, response);
		if (to.equals("redirectToLogin"))
			this.redirectToLogin(request, response);
	}

	private void redirectToIndex(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("index.jsp", request, response);

	}

	private void redirectToPaginaCommunity(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("pubbliche/community.jsp", request, response);

	}

	private void redirectToPaginaBuy(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1;

			ref1 = jndiContext.lookup("GestioneAbilita/remote");
			GestioneAbilitaRemote gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
					.narrow(ref1, GestioneAbilitaRemote.class);
			List<Abilita> listaAbilita = gestioneAbilitaRemote
					.getListaAbilita();
			session.setAttribute("listaAbilita", listaAbilita);

		} catch (NamingException e) {
			e.printStackTrace();
		}

		redirect("pubbliche/buy.jsp", request, response);

	}

	private void redirectToPaginaSell(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("pubbliche/sell.jsp", request, response);

	}

	private void redirectToGestioneOrdini(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestionePrenotazioni/remote");

			GestionePrenotazioniRemote gestionePrenotazioniRemote = (GestionePrenotazioniRemote) PortableRemoteObject
					.narrow(ref1, GestionePrenotazioniRemote.class);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();
			int idAltroUtente;
			List<Prenotazione> listaOrdiniAsABuyer = new ArrayList<Prenotazione>();
			List<Prenotazione> listaOrdiniAsASeller = new ArrayList<Prenotazione>();

			if (request.getParameter("idUtente") == null) {
				listaOrdiniAsABuyer = gestionePrenotazioniRemote
						.getListaOrdiniAsABuyer(idUtente);
				listaOrdiniAsASeller = gestionePrenotazioniRemote
						.getListaOrdiniAsASeller(idUtente);
			} else {
				idAltroUtente = Integer.parseInt(request
						.getParameter("idUtente"));
				listaOrdiniAsABuyer = gestionePrenotazioniRemote
						.getListaOrdiniAsABuyerDiUtenteSeller(idUtente,
								idAltroUtente);
				listaOrdiniAsASeller = gestionePrenotazioniRemote
						.getListaOrdiniAsASellerDiUtenteBuyer(idUtente,
								idAltroUtente);

			}

			session.setAttribute("listaOrdiniAsABuyer", listaOrdiniAsABuyer);
			session.setAttribute("listaOrdiniAsASeller", listaOrdiniAsASeller);

			redirect("utente/gestioneOrdini.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private void redirectToDettaglioOrdine(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestionePrenotazioni/remote");
			GestionePrenotazioniRemote gestionePrenotazioniRemote = (GestionePrenotazioniRemote) PortableRemoteObject
					.narrow(ref1, GestionePrenotazioniRemote.class);

			if (request.getParameter("idPrenotazione") != null) {
				int idPrenotazione = Integer.parseInt(request
						.getParameter("idPrenotazione"));

				Prenotazione prenotazione = gestionePrenotazioniRemote
						.getPrenotazione(idPrenotazione);

				session.setAttribute("prenotazione", prenotazione);
				
				redirect("utente/dettaglioOrdine.jsp", request, response);
			} else {
				System.out.println("Errore Prenotazione non presente");
			}
		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

	// È identica a GestionePagineServlet?to=redirectToPaginaAmicizie
	private void redirectToClientiEFornitori(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtenteRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);
			Object ref2 = jndiContext.lookup("GestionePrenotazioni/remote");
			GestionePrenotazioniRemote gestionePrenotazioniRemote = (GestionePrenotazioniRemote) PortableRemoteObject
					.narrow(ref2, GestionePrenotazioniRemote.class);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();

			List<Prenotazione> listaClienti = gestionePrenotazioniRemote
					.getListaClienti(idUtente);
			List<Prenotazione> listaFornitori = gestionePrenotazioniRemote
					.getListaFornitori(idUtente);
			List<Utente> listaAmiciInSospeso = gestioneUtenteRemote
					.getListaAmiciInSospeso(idUtente);

			session.setAttribute("listaClienti", listaClienti);
			session.setAttribute("listaFornitori", listaFornitori);
			session.setAttribute("listaAmiciInSospeso", listaAmiciInSospeso);
			redirect("utente/listaAmici.jsp", request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private void redirectToPreferiti(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("utente/preferiti.jsp", request, response);
	}

	private void redirectToLogin(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("utente/login.jsp", request, response);
	}

	

}
