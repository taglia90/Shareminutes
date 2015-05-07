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

import remote.GestioneRichiesteRemote;
import util.LoginToken;
import entity.Messaggio;
import entity.Richiesta;
import exception.RichiestaException;

public class GestioneRichiesteServlet extends Servlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String to = (String) request.getParameter("to");
		if (to.equals("redirectToPaginaInvioRichiesta"))
			this.redirectToPaginaInvioRichiesta(request, response);
		if (to.equals("creaNuovaRichiesta"))
			this.creaNuovaRichiesta(request, response);
		if (to.equals("rispondiAMessaggio"))
			this.rispondiAMessaggio(request, response);
		if (to.equals("creaNuovoMessaggio"))
			this.creaNuovoMessaggio(request, response);
		if (to.equals("redirectToPaginaRichieste"))
			this.redirectToPaginaRichieste(request, response);
		if (to.equals("redirectToPaginaDettaglioRichiesta"))
			this.redirectToPaginaDettaglioRichiesta(request, response);

	}

	private void redirectToPaginaInvioRichiesta(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("usernameDestinatario",
				request.getParameter("usernameDestinatario"));

		redirect("utente/invioRichiesta.jsp", request, response);

	}

	private void creaNuovaRichiesta(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneRichieste/remote");
			GestioneRichiesteRemote gestioneRichiesteRemote = (GestioneRichiesteRemote) PortableRemoteObject
					.narrow(ref1, GestioneRichiesteRemote.class);
			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");

			int idUtente = tok.getIdUtente();
			int idUtenteDestinatario = Integer.parseInt(request
					.getParameter("usernameDestinatario"));
			String oggettoRichiesta = request.getParameter("oggettoRichiesta");
			String corpoMessaggio = request.getParameter("corpoMessaggio");

			int idRichiesta = gestioneRichiesteRemote.creaRichiesta(
					oggettoRichiesta, idUtente, idUtenteDestinatario);

			gestioneRichiesteRemote.rispondiARichiesta(idRichiesta, idUtente,
					corpoMessaggio);

			this.redirectToPaginaRichieste(request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (RichiestaException e) {

			session.setAttribute("Errore", e.toString());
			session.setAttribute("usernameDestinatario",
					request.getParameter("usernameDestinatario"));

			redirect("utente/invioRichiesta.jsp", request, response);

		}
	}

	private void rispondiAMessaggio(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();

		session.setAttribute("idRichiesta", request.getParameter("idRichiesta"));

		redirect("utente/invioRichiesta.jsp", request, response);

	}

	private void creaNuovoMessaggio(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneRichieste/remote");
			GestioneRichiesteRemote gestioneRichiesteRemote = (GestioneRichiesteRemote) PortableRemoteObject
					.narrow(ref1, GestioneRichiesteRemote.class);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");

			int idUtente = tok.getIdUtente();
			String corpoMessaggio = request.getParameter("corpoMessaggio");

			int idRichiesta = Integer.parseInt(request
					.getParameter("idRichiesta"));

			if (corpoMessaggio != null)
				gestioneRichiesteRemote.rispondiARichiesta(idRichiesta,
						idUtente, corpoMessaggio);

			session.setAttribute("idRichiesta",
					request.getParameter("idRichiesta"));

			this.redirectToPaginaDettaglioRichiesta(request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (RichiestaException e) {
			session.setAttribute("Errore", e.toString());
			redirect("utente/dettaglioRichiesta.jsp", request, response);

		}
	}

	private void redirectToPaginaRichieste(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneRichieste/remote");

			GestioneRichiesteRemote gestioneRichiesteRemote = (GestioneRichiesteRemote) PortableRemoteObject
					.narrow(ref1, GestioneRichiesteRemote.class);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");

			int idUtente = tok.getIdUtente();

			List<Richiesta> listaRichiesteRicevute = new ArrayList<Richiesta>();
			List<Richiesta> listaRichiesteMandate = new ArrayList<Richiesta>();

			listaRichiesteRicevute = gestioneRichiesteRemote
					.getListaRichiestaRicevuteDaUtente(idUtente);
			listaRichiesteMandate = gestioneRichiesteRemote
					.getListaRichiestaInviateDaUtente(idUtente);

			session.setAttribute("listaRichiesteRicevute",
					listaRichiesteRicevute);
			session.setAttribute("listaRichiesteMandate", listaRichiesteMandate);

			redirect("utente/listaRichieste.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

	private void redirectToPaginaDettaglioRichiesta(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneRichieste/remote");
			GestioneRichiesteRemote gestioneRichiesteRemote = (GestioneRichiesteRemote) PortableRemoteObject
					.narrow(ref1, GestioneRichiesteRemote.class);

			if (request.getParameter("idRichiesta") != null) {
				int idRichiesta = Integer.parseInt(request
						.getParameter("idRichiesta"));

				Richiesta richiesta = gestioneRichiesteRemote
						.getRichiesta(idRichiesta);

				List<Messaggio> listaMessaggi = gestioneRichiesteRemote
						.getListaMessaggiDiRichiesta(idRichiesta);
				session.setAttribute("listaMessaggi", listaMessaggi);

				session.setAttribute("richiesta", richiesta);

				redirect("utente/dettaglioRichiesta.jsp", request, response);
			} else {
				System.out
						.println("Errore entro nell'else di redirectToPaginaDettaglioRichiesta");
			}
		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

}
