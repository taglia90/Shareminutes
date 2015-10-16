package control;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import remote.GestionePrenotazioniRemote;
import remote.GestioneUtentiRemote;
import util.LoginToken;
import entity.Follower;
import entity.Utente;
import exception.AmiciziaException;

public class GestioneAmicizieServlet extends Servlet {
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
		if (to.equals("creaAmicizia"))
			this.creaAmicizia(request, response);
		if (to.equals("valutaRichiestaDiAmicizia"))
			this.valutaRichiestaDiAmicizia(request, response);
		if (to.equals("eliminaAmicizia"))
			this.eliminaAmicizia(request, response);
		if (to.equals("redirectToPaginaAmicizie"))
			this.redirectToPaginaAmicizie(request, response);
		if (to.equals("redirectToPaginaFollower"))
			this.redirectToPaginaFollower(request, response);
		if (to.equals("redirectToPaginaFollowerPreferiti"))
			this.redirectToPaginaFollowerPreferiti(request, response);
		if (to.equals("aggiungiFollower"))
			this.aggiungiFollower(request, response);
		if (to.equals("aggiungiFollowerAPreferiti"))
			this.aggiungiFollowerAPreferiti(request, response);
		if (to.equals("rimuoviFollowerDaPreferiti"))
			this.rimuoviFollowerDaPreferiti(request, response);
		if (to.equals("eliminaFollower"))
			this.eliminaFollower(request, response);

	}

	private void redirectToPaginaAmicizie(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtenteRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();

			List<Utente> listaAmici = gestioneUtenteRemote
					.getListaAmici(idUtente);
			List<Utente> listaAmiciInSospeso = gestioneUtenteRemote
					.getListaAmiciInSospeso(idUtente);

			session.setAttribute("listaAmici", listaAmici);
			session.setAttribute("listaAmiciInSospeso", listaAmiciInSospeso);
			redirect("utente/listaAmici.jsp", request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

	private void creaAmicizia(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			int idUtenteAmico = Integer.parseInt(request
					.getParameter("usernameUtenteAmico"));

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");

			int idUtente = tok.getIdUtente();

			gestioneUtentiRemote.creaRichiestaAmicizia(idUtente, idUtenteAmico);

			session.setAttribute("Successo",
					"Richiesta di amicizia inviata correttamente.");

			redirect("GestioneUtentiServlet?to=redirectToPaginaProfilo",
					request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (AmiciziaException e) {
			session.setAttribute("Errore", e.toString());
			this.redirectToPaginaAmicizie(request, response);
		}
	}

	private void valutaRichiestaDiAmicizia(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtenteRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			String stringIsApprovata = request.getParameter("isApprovata");

			int idUtenteAmico = Integer.parseInt(request
					.getParameter("usernameUtenteAmico"));

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();

			if (stringIsApprovata.equals("true")) {
				gestioneUtenteRemote.accettaAmicizia(idUtente, idUtenteAmico);

				session.setAttribute("Successo",
						"Amicizia approvata correttamente");
			} else {
				gestioneUtenteRemote.eliminaAmicizia(idUtente, idUtenteAmico);
				session.setAttribute("Successo",
						"Amicizia rifiutata correttamente");

			}
			this.redirectToPaginaAmicizie(request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (AmiciziaException e) {
			session.setAttribute("Errore", e.toString());
			this.redirectToPaginaAmicizie(request, response);
		}
	}

	private void eliminaAmicizia(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtenteRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			int idUtenteAmico = Integer.parseInt(request
					.getParameter("usernameUtenteAmico"));

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();

			gestioneUtenteRemote.eliminaAmicizia(idUtente, idUtenteAmico);

			session.setAttribute("Successo", "Amicizia rifiutata correttamente");

			redirect("utente/listaAmici.jsp", request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (AmiciziaException e) {
			session.setAttribute("Errore", e.toString());
			this.redirectToPaginaAmicizie(request, response);
		}
	}

	private void redirectToPaginaFollower(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtenteRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();

			List<Follower> listaFollower = gestioneUtenteRemote
					.getListaFollower(idUtente);

			session.setAttribute("soloPreferiti", false);
			session.setAttribute("listaFollower", listaFollower);
			redirect("utente/listaFollower.jsp", request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

	private void redirectToPaginaFollowerPreferiti(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtenteRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();

			List<Follower> listaFollower = gestioneUtenteRemote
					.getListaFollowerPreferiti(idUtente);

			session.setAttribute("soloPreferiti", true);
			session.setAttribute("listaFollower", listaFollower);
			redirect("utente/listaFollower.jsp", request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

	private void aggiungiFollower(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			int idUtenteFollower = Integer.parseInt(request
					.getParameter("idUtenteFoll"));

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");

			int idUtente = tok.getIdUtente();

			gestioneUtentiRemote.aggiungiFollower(idUtente, idUtenteFollower);

			session.setAttribute("Successo", "Follower aggiunto correttamente.");

			redirect("GestioneAmicizieServlet?to=redirectToPaginaFollower",
					request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (AmiciziaException e) {
			session.setAttribute("Errore", e.toString());
			this.redirectToPaginaAmicizie(request, response);
		}
	}

	private void aggiungiFollowerAPreferiti(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			request.setCharacterEncoding("UTF-8");

			int idFollower = Integer.parseInt(request
					.getParameter("idFollower"));

			gestioneUtentiRemote.setPreferito(idFollower);
			session.setAttribute("Successo", "Aggiunta avvenuta con successo!");

			redirect("GestioneAmicizieServlet?to=redirectToPaginaFollower",
					request, response);
			return;

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	
	private void rimuoviFollowerDaPreferiti(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			request.setCharacterEncoding("UTF-8");

			int idFollower = Integer.parseInt(request
					.getParameter("idFollower"));

			gestioneUtentiRemote.rimuoviPreferito(idFollower);
			session.setAttribute("Successo", "Rimozione dai preferiti avvenuta con successo!");

			redirect("GestioneAmicizieServlet?to=redirectToPaginaFollower",
					request, response);
			return;

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	private void eliminaFollower(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			request.setCharacterEncoding("UTF-8");

			int idFollower = Integer.parseInt(request
					.getParameter("idFollower"));

			gestioneUtentiRemote.eliminaFollower(idFollower);
			session.setAttribute("Successo", "Follower eliminato con successo!");

			redirect("GestioneAmicizieServlet?to=redirectToPaginaFollower",
					request, response);
			return;

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}


}


