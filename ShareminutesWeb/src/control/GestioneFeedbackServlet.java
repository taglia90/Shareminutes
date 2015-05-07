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
import remote.GestioneRichiesteRemote;
import remote.GestioneUtentiRemote;
import util.LoginToken;

import com.oreilly.servlet.MultipartRequest;

import entity.Feedback;
import entity.Utente;
import exception.FeedbackException;
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
				listaFeedbackCreati = new ArrayList<Feedback>();

			} else {

				idUtente = tok.getIdUtente();

				listaFeedbackCreati = gestioneFeedbackRemote
						.getListaFeedbackCreatiDiUnUtente(idUtente);

			}
			listaFeedbackRicevuti = gestioneFeedbackRemote
					.getListaFeedbackRicevutiDiUnUtente(idUtente);

			Utente u = gestioneUtentiRemote.getUtente(idUtente);
			String nome = u.getNome();
			String cognome = u.getCognome();

			session.setAttribute("idUtente", nome + " " + cognome);
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

		session.setAttribute("idRichiesta", request.getParameter("idRichiesta"));

		session.setAttribute("usernameDestinatario",
				request.getParameter("usernameDestinatario"));

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
			Context jndiContext2 = new javax.naming.InitialContext();
			Object ref2 = jndiContext2.lookup("GestioneRichieste/remote");
			GestioneRichiesteRemote gestioneRichiesteRemote = (GestioneRichiesteRemote) PortableRemoteObject
					.narrow(ref2, GestioneRichiesteRemote.class);

			MultipartRequest multi = new MultipartRequest(request, "./");

			int idUtenteDestinatario = Integer.parseInt(request
					.getParameter("usernameDestinatario"));
			

			String votoEsteso = multi.getParameter("votoEsteso");
			String[] votoSint = multi.getParameterValues("votoSintetico");

			if (votoSint[0] == null) {
				votoSint[0] = "1";
			}

			int votoSintetico = Integer.parseInt(votoSint[0]);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");

			if (request.getParameter("idRichiesta") == null) {
				throw new FeedbackException(
						"L'id della richiesta non può essere null");
			}
			int idRichiesta = Integer.parseInt(request
					.getParameter("idRichiesta"));

			gestioneFeedbackRemote.creaFeedback(votoSintetico, votoEsteso,
					idUtenteDestinatario, tok.getIdUtente());
			gestioneRichiesteRemote.valutaRichiesta(idRichiesta);

			session.setAttribute("usernameUtente", tok.getIdUtente());

			this.redirectToPaginaListaFeedback(request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (FeedbackException e) {
			session.setAttribute("Errore", e.toString());
			this.redirectToPaginaNuovoFeedback(request, response);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (RichiestaException e) {
			session.setAttribute("Errore", e.toString());
		}

	}
}