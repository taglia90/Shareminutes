package control;

import java.io.IOException;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.Context;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import remote.AutenticazioneRemote;
import remote.GestioneAbilitaRemote;
import remote.GestioneUtentiRemote;
import util.LoginToken;
import util.Mailer;
import util.LoginToken.TipoAccesso;
import entity.Abilita;
import entity.Utente;
import exception.LoginException;
import exception.SicurezzaException;

public class AutenticazioneServlet extends Servlet {
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
		if (to.equals("logout"))
			this.logout(request, response);
		if (to.equals("login"))
			this.login(request, response);
		if (to.equals("passwordDimenticata"))
			this.passwordDimenticata(request, response);
		if (to.equals("redirectToPasswordDimenticata"))
			this.redirectToPasswordDimenticata(request, response);
	}

	// per questioni di sicurezza introduciamo 2 controlli per le 2 categorie di
	// utenti
	public static boolean checkLoggatoComeUtente(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
		if (tok == null || tok.getRequiredAccess() != TipoAccesso.Utente) { // se
																			// non
																			// sei
																			// loggato
																			// come
																			// utente
			session.setAttribute("Errore", (new SicurezzaException(
					"VIOLAZIONE DELLA SICUREZZA! Non sei loggato come utente"))
					.toString());
			redirect("index.jsp", request, response);
			return false;
		}
		return true;
	}

	public static boolean checkLoggatoComeAmministratore(
			HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
		if (tok == null
				|| tok.getRequiredAccess() != TipoAccesso.Amministratore) { // se
																			// non
																			// sei
																			// loggato
																			// come
																			// amministratore
			session.setAttribute(
					"Errore",
					(new SicurezzaException(
							"VIOLAZIONE DELLA SICUREZZA! Non sei loggato come amministratore"))
							.toString());
			redirect("index.jsp", request, response);
			return false;
		}
		return true;
	}

	private void login(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {
			/*
			 * Cookie[] cookies = request.getCookies(); // request is an
			 * instance // of type // HttpServletRequest boolean foundCookie =
			 * false;
			 * 
			 * for (int i = 0; i < cookies.length; i++) { Cookie c = cookies[i];
			 * if (c.getName().equals("username")) { String usernameCookie =
			 * c.getValue(); foundCookie = true; } }
			 */
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("Autenticazione/remote");
			AutenticazioneRemote autenticazioneRemote = (AutenticazioneRemote) PortableRemoteObject
					.narrow(ref1, AutenticazioneRemote.class);

			Object ref2 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref2, GestioneUtentiRemote.class);

			String email = request.getParameter("email");
			String password = request.getParameter("password");

			LoginToken tok = autenticazioneRemote.autenticazione(email,
					password);
			session.removeAttribute("LoginToken");
			session.setAttribute("LoginToken", tok);

			Utente utente = gestioneUtentiRemote.getUtente(tok.getIdUtente());
			session.setAttribute("utente", utente);

			if (!utente.isEmailConfermata()) {
				session.setAttribute(
						"Errore",
						"Prima di accedere devi verificare il tuo account tramite il codice inviato via mail.");
				redirect("utente/login.jsp", request, response);
				return;
			}

			if (tok.getRequiredAccess() == TipoAccesso.Amministratore)
				this.accessoAmministratore(request, response);
			if (tok.getRequiredAccess() == TipoAccesso.Utente)
				this.accessoUtente(request, response);

			/*
			 * Boolean isChecked = false;
			 * if(request.getParameter("remember_me").toString()=="1"){
			 * isChecked = true; } if (isChecked) { Cookie c = new
			 * Cookie("username", username.toString()); c.setMaxAge(365 * 24 *
			 * 60 * 60); response.addCookie(c); // response is an instance of
			 * type // HttpServletReponse }
			 */
		} catch (LoginException e) {
			session.setAttribute("Errore", e.toString());
			redirect("index.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

	private void logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.removeAttribute("LoginToken");
		redirect("index.jsp", request, response);
	}

	private void accessoUtente(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();

			Object ref1 = jndiContext.lookup("GestioneAbilita/remote");
			GestioneAbilitaRemote gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
					.narrow(ref1, GestioneAbilitaRemote.class);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();

			session.removeAttribute("LoginToken");
			session.setAttribute("LoginToken", tok);

			List<Abilita> listaAbilita = gestioneAbilitaRemote
					.getListaAbilitaDiUtente(idUtente);
			session.setAttribute("listaAbilita", listaAbilita);

			if (listaAbilita == null) {
				redirect("utente/listaAbilita.jsp", request, response);
			} else {
				redirect("utente/profilo.jsp", request, response);
			}
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private void accessoAmministratore(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneAbilita/remote");
			GestioneAbilitaRemote gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
					.narrow(ref1, GestioneAbilitaRemote.class);

			List<Abilita> listaAbilita = gestioneAbilitaRemote
					.getListaAbilita();
			session.setAttribute("listaAbilita", listaAbilita);

			redirect("admin/listaAbilitaAdmin.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private void redirectToPasswordDimenticata(HttpServletRequest request,
			HttpServletResponse response) {

		redirect("utente/passwordDimenticata.jsp", request, response);
	}

	private void passwordDimenticata(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("Autenticazione/remote");
			AutenticazioneRemote autenticazioneRemote = (AutenticazioneRemote) PortableRemoteObject
					.narrow(ref1, AutenticazioneRemote.class);

			String email = request.getParameter("email");
			Utente utente = autenticazioneRemote.getUtente(email);

			if (utente != null) {
				Random random = new Random();
				int codice = 1 + random.nextInt(1000000);
				autenticazioneRemote.inserisciCodiceConferma(
						utente.getIdUtente(), codice);
				String linkReimpostaPassword = "http://www.shareminutes.com/ShareminutesWeb/RegistrazioneServlet?to=reimpostaPassword&idUtente="
						+ utente.getIdUtente() + "&codice=" + codice;
				String body = "Ciao,\n"
						+ "è stato richiesto di reimpostare la password del tuo account.\nSe non hai fatto tu qeusta richiesta ignora questa mail, altrimenti clicca sul seguente link per reimpostare la password:\n"
						+ linkReimpostaPassword;
				Mailer mailer = new Mailer();
				mailer.SendEmail(email, "Reimposta password", body);

				session.setAttribute("Successo",
						"Email inviata all'accunt indicato.");
			} else {
				session.setAttribute("Errore",
						"L'indirizzo mail non è registrato.");
			}

			redirect("index.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}

}
