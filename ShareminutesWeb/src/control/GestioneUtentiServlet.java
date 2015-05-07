package control;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.rmi.PortableRemoteObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import entity.Utente;
import exception.LoginException;
import exception.UtentiException;
import remote.AutenticazioneRemote;
import remote.GestioneUtentiRemote;
import util.ControlloreStringhe;
import util.GetBytesFromFile;
import util.LoginToken;

public class GestioneUtentiServlet extends Servlet {
	private static final long serialVersionUID = 1L;
	private EntityManager entityManager;

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String to = (String) request.getParameter("to");
		if (to.equals("redirectToPaginaProfilo"))
			this.redirectToPaginaProfilo(request, response);
		if (to.equals("getFotoProfilo"))
			this.getFotoProfilo(request, response);
		if (to.equals("modificaProfilo"))
			try {
				this.modificaProfilo(request, response);
			} catch (UtentiException e) {
				e.printStackTrace();
			}
		if (to.equals("redirectToPaginaModificaProfilo"))
			this.redirectToPaginaModificaProfilo(request, response);
		if (to.equals("redirectToPaginaPagamento"))
			this.redirectToPaginaPagamento(request, response);
		if (to.equals("redirectToPaginaSicurezza"))
			this.redirectToPaginaSicurezza(request, response);
		if (to.equals("salvaMetodoPagamento"))
			this.salvaMetodoPagamento(request, response);
		if (to.equals("modificaPassword"))
			this.modificaPassword(request, response);

	}

	// da utente/. a utente/profilo.jsp
	private void redirectToPaginaProfilo(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			if (request.getParameter("idUtente") == null)
				throw new UtentiException("Errore! Nessun utente specificato");

			int idUtente = Integer.parseInt(request.getParameter("idUtente"));
			Utente utente = gestioneUtentiRemote.getUtente(idUtente);
			session.setAttribute("utente", utente);

			redirect("utente/profilo.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UtentiException e) {
			redirect("utente/profilo.jsp", request, response);
			e.printStackTrace();
		}
	}

	private void redirectToPaginaModificaProfilo(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			if (request.getParameter("idUtente") == null)
				throw new UtentiException("Errore! Nessun utente specificato");

			int idUtente = Integer.parseInt(request.getParameter("idUtente"));
			if (request.getParameter("idUtente") == null) {
				LoginToken tok = (LoginToken) session
						.getAttribute("LoginToken");
				idUtente = tok.getIdUtente();
			}
			Utente utente = gestioneUtentiRemote.getUtente(idUtente);
			session.setAttribute("utente", utente);

			redirect("utente/modificaProfilo.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UtentiException e) {
			redirect("utente/profilo.jsp", request, response);
			e.printStackTrace();
		}

	}

	private void getFotoProfilo(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref2 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref2, GestioneUtentiRemote.class);

			// HttpSession session = request.getSession();
			// LoginToken tok = (LoginToken) session.getAttribute("LoginToken");

			int idUtente = Integer.parseInt(request.getParameter("idUtente"));
			/*
			 * Query query= entityManager.createQuery(
			 * "SELECT idUtente FROM Utente WHERE username=':username'");
			 * query.setParameter("username", username.toLowerCase()); int
			 * idUtente =
			 */

			byte[] fotoProfilo = gestioneUtentiRemote.getFotoProfilo(idUtente);
			if (fotoProfilo != null) {
				response.setContentType("image/png");
				response.setContentLength(fotoProfilo.length);
				response.getOutputStream().write(fotoProfilo);
			}
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void modificaProfilo(HttpServletRequest request,
			HttpServletResponse response) throws UtentiException {
		HttpSession session = request.getSession();

		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);
			request.setCharacterEncoding("UTF-8");
			MultipartRequest mrequest;
			mrequest = new MultipartRequest(request, "./");
			// dim.
			// max
			// di
			// 1Mbyte

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();

			// Utente utente=gestioneUtentiRemote.getUtente(idUtente);
			// request.setAttribute("utente", utente);

			String nome = mrequest.getParameter("nome");
			String cognome = mrequest.getParameter("cognome");
			String sesso = mrequest.getParameter("sesso");
			String eta = mrequest.getParameter("eta");
			String headline = mrequest.getParameter("headline");
			String posizioneLavorativa = mrequest
					.getParameter("posizioneLavorativa");
			String paese = mrequest.getParameter("paese");
			String citta = mrequest.getParameter("citta");
			String cap = mrequest.getParameter("cap");
			String biografia = mrequest.getParameter("biografia");

			File foto = mrequest.getFile("foto");
			byte[] fotoProfiloBytes = null;
			if (foto != null) {
				if (!(foto.getName().endsWith(".jpg")
						|| foto.getName().endsWith(".jpeg")
						|| foto.getName().endsWith(".png") || foto.getName()
						.endsWith(".gif")))
					throw new UtentiException(
							"Estensione del file non corretta");
				fotoProfiloBytes = GetBytesFromFile.getBytesFromFile(foto);
			}

			if (mrequest.getParameter("pubblicaProfilo") != null) {
				if (nome.length() == 0)
					throw new UtentiException("Non hai inserito il nome.");
				if (cognome.length() == 0)
					throw new UtentiException("Non hai inserito il cognome");

				if (fotoProfiloBytes == null) {
					fotoProfiloBytes = gestioneUtentiRemote
							.getFotoProfilo(idUtente);
				}
				gestioneUtentiRemote.modificaProfilo(idUtente, nome, cognome,
						paese, citta, cap, sesso, eta, posizioneLavorativa,
						headline, biografia, fotoProfiloBytes);

				session.setAttribute("Successo",
						"Profilo modificato correttamente.");

				this.redirectToPaginaProfilo(request, response);

			} else {
				session.setAttribute("Errore",
						"Devi accettare di pubblicare il profilo.");
				this.redirectToPaginaModificaProfilo(request, response);
			}

		} catch (UtentiException e) {
			session.setAttribute("Errore", e.toString());
			redirect("utente/modificaProfilo.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void redirectToPaginaPagamento(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			Utente utente = gestioneUtentiRemote.getUtente(tok.getIdUtente());
			session.setAttribute("utente", utente);

			redirect("utente/pagamento.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private void redirectToPaginaSicurezza(HttpServletRequest request,
			HttpServletResponse response) {

		redirect("utente/sicurezza.jsp", request, response);
	}

	private void salvaMetodoPagamento(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);
			request.setCharacterEncoding("UTF-8");

			String emailPayPal = request.getParameter("emailPayPal");

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			gestioneUtentiRemote.salvaEmailPayPal(tok.getIdUtente(),
					emailPayPal); // ,
			// fotoProfiloBytes);
			session.setAttribute("Successo",
					"Metodo di pagamento registrato con successo!");

			redirect("utente/profilo.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (UtentiException e) {
			e.printStackTrace();
		}
	}

	private void modificaPassword(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			Object ref2 = jndiContext.lookup("Autenticazione/remote");
			AutenticazioneRemote autenticazioneRemote = (AutenticazioneRemote) PortableRemoteObject
					.narrow(ref2, AutenticazioneRemote.class);

			request.setCharacterEncoding("UTF-8");

			String vecchiaPassword = request.getParameter("vecchiaPassword");
			String nuovaPassword = request.getParameter("password1");
			String confermaPassword = request.getParameter("password2");

			if (vecchiaPassword.equals("") || nuovaPassword.equals("")
					|| confermaPassword.equals("")) {
				session.setAttribute("Errore",
						"Non sono stati compilati tutti i campi!");
				redirect("utente/sicurezza.jsp", request, response);
				return;
			}
			if (vecchiaPassword.length() > 255 || nuovaPassword.length() > 255
					|| confermaPassword.length() > 255) {
				session.setAttribute("Errore",
						"La password non può essere più lunga di 255 caratteri.");
				redirect("utente/sicurezza.jsp", request, response);
				return;
			}
			if (!(ControlloreStringhe.userOPassUtenteOk(nuovaPassword))) {
				session.setAttribute(
						"Errore",
						"La password non e' compresa tra 6 e 24 caratteri o contiene carattare speciali non accettati.");
				redirect("utente/sicurezza.jsp", request, response);
				return;
			}
			if (!nuovaPassword.equals(confermaPassword)) {
				session.setAttribute("Errore",
						"Hai inserito due password diverse");
				redirect("utente/sicurezza.jsp", request, response);
				return;
			}

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			tok = autenticazioneRemote.autenticazione(tok.getEmail(),
					vecchiaPassword);
			session.removeAttribute("LoginToken");
			session.setAttribute("LoginToken", tok);

			gestioneUtentiRemote.modificaPassword(tok.getIdUtente(),
					vecchiaPassword, nuovaPassword, confermaPassword);
			tok = autenticazioneRemote.autenticazione(tok.getEmail(),
					nuovaPassword);
			session.removeAttribute("LoginToken");
			session.setAttribute("LoginToken", tok);

			session.setAttribute("Successo", "Modifica avvenuta con successo!");

			Utente utente = gestioneUtentiRemote.getUtente(tok.getIdUtente());
			session.setAttribute("utente", utente);

			redirect("utente/profilo.jsp", request, response);
			return;
		} catch (NamingException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (LoginException e) {
			session.setAttribute("Errore", e.toString());
			redirect("utente/profilo.jsp", request, response);
		} catch (UtentiException e) {
			e.printStackTrace();
		}
	}
	
}
