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

import remote.GestioneFeedbackRemote;
import remote.GestionePrenotazioniRemote;
import remote.GestioneRichiesteRemote;
import remote.GestioneUtentiRemote;
import util.LoginToken;

import com.oreilly.servlet.MultipartRequest;

import entity.Feedback;
import entity.Utente;
import exception.FeedbackException;
import exception.PrenotazioneException;
import exception.RichiestaException;

public class GestioneFeedbackServlet extends Servlet {
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
		if (to.equals("nuovoFeedback"))
			this.nuovoFeedback(request, response);
		if (to.equals("redirectToPaginaListaFeedback"))
			this.redirectToPaginaListaFeedback(request, response);
		if (to.equals("redirectToPaginaNuovoFeedback"))
			this.redirectToPaginaNuovoFeedback(request, response);
	}

	private void redirectToPaginaListaFeedback(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneFeedback/remote");
			GestioneFeedbackRemote gestioneFeedbackRemote = (GestioneFeedbackRemote) PortableRemoteObject
					.narrow(ref1, GestioneFeedbackRemote.class);
			Object ref2 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref2, GestioneUtentiRemote.class);

			List<Feedback> listaFeedbackRicevuti;
			List<Feedback> listaFeedbackCreati;

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");

			int idUtente;

			if (request.getParameter("idUtente") != null
					&& Integer.parseInt(request.getParameter("idUtente")) != tok
							.getIdUtente()) {
				idUtente = Integer.parseInt(request.getParameter("idUtente"));

			} else {

				idUtente = tok.getIdUtente();
			}

			listaFeedbackCreati = gestioneFeedbackRemote
					.getListaFeedbackCreatiDiUnUtente(idUtente);
			listaFeedbackRicevuti = gestioneFeedbackRemote
					.getListaFeedbackRicevutiDiUnUtente(idUtente);

			Utente u = gestioneUtentiRemote.getUtente(idUtente);
			String nome = u.getNome();
			String cognome = u.getCognome();

			session.setAttribute("nomeCognome", nome + " " + cognome);
			session.setAttribute("listaFeedbackCreati", listaFeedbackCreati);
			session.setAttribute("listaFeedbackRicevuti", listaFeedbackRicevuti);

			redirect("utente/listaFeedback.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private void redirectToPaginaNuovoFeedback(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		// session.setAttribute("idRichiesta",
		// request.getParameter("idRichiesta"));
		session.setAttribute("idPrenotazione",
				request.getParameter("idPrenotazione"));

		session.setAttribute("idUtenteDestinatario",
				request.getParameter("idUtenteDestinatario"));

		redirect("utente/nuovoFeedback.jsp", request, response);
	}

	private void nuovoFeedback(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneFeedback/remote");
			GestioneFeedbackRemote gestioneFeedbackRemote = (GestioneFeedbackRemote) PortableRemoteObject
					.narrow(ref1, GestioneFeedbackRemote.class);

			Object ref3 = jndiContext.lookup("GestionePrenotazioni/remote");
			GestionePrenotazioniRemote gestionePrenotazioniRemote = (GestionePrenotazioniRemote) PortableRemoteObject
					.narrow(ref3, GestionePrenotazioniRemote.class);

			MultipartRequest multi = new MultipartRequest(request, "./");

			int idUtenteDestinatario = Integer.parseInt(request
					.getParameter("idUtenteDestinatario"));

			String votoEsteso = multi.getParameter("votoEsteso");
			String[] votoSint = multi.getParameterValues("votoSintetico");

			if (votoSint[0] == null) {
				votoSint[0] = "1";
			}

			int votoSintetico = Integer.parseInt(votoSint[0]);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");

			if (multi.getParameter("idPrenotazione") == null) {
				throw new FeedbackException(
						"L'id della della prenotazione non può essere null");
			}
			int idPrenotazione = Integer.parseInt(request
					.getParameter("idPrenotazione"));

			gestioneFeedbackRemote.creaFeedback(votoSintetico, votoEsteso,
					idUtenteDestinatario, tok.getIdUtente());
			gestionePrenotazioniRemote.valutaPrenotazione(idPrenotazione,
					tok.getIdUtente());
			gestioneFeedbackRemote
					.aggiornaMediaFeedbackUtente(idUtenteDestinatario);

			session.setAttribute("idUtente", tok.getIdUtente());

			this.redirectToPaginaListaFeedback(request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (FeedbackException e) {
			session.setAttribute("Errore", e.toString());
			this.redirectToPaginaNuovoFeedback(request, response);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PrenotazioneException e) {
			session.setAttribute("Errore", e.toString());
		}

	}
}