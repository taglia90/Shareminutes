package control;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.Context;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import remote.GestioneAbilitaRemote;
import remote.RegistrazioneRemote;
import util.GetBytesFromFile;
import util.Mailer;

import com.oreilly.servlet.MultipartRequest;

import entity.Abilita;
import exception.RegistrazioneException;
import exception.SicurezzaException;

public class RegistrazioneServlet extends Servlet {
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
		if (to.equals("redirectToPaginaRegistrazione"))
			this.redirectToPaginaRegistrazione(request, response);
		if (to.equals("redirectToPaginaListaAbilita"))
			this.redirectToPaginaListaAbilita(request, response);
		if (to.equals("salvaDatiUtente"))
			this.salvaDatiUtente(request, response);
		if (to.equals("annullaRegistrazioneUtente"))
			this.annullaRegistrazioneUtente(request, response);
		if (to.equals("redirectToIndex"))
			this.redirectToIndex(request, response);
		if (to.equals("confermaRegistrazione"))
			this.confermaRegistrazione(request, response);
		if (to.equals("modificaPass"))
			this.modificaPass(request, response);
		if (to.equals("reimpostaPassword"))
			this.reimpostaPassword(request, response);
		if (to.equals("salvaDatiLanding"))
			this.salvaDatiLanding(request, response);

	}

	// //////// REGISTRAZIONE UTENTE

	// da index.jsp a utente/registrazione.jsp
	private void redirectToPaginaRegistrazione(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("utente/registrazione.jsp", request, response);
	}

	// da ./. a index.jsp
	private void redirectToIndex(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("index.jsp", request, response);
	}

	// da utente/registrazione.jsp a utente/listaAbilita.jsp
	private void salvaDatiUtente(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("Registrazione/remote");
			RegistrazioneRemote registrazioneRemote = (RegistrazioneRemote) PortableRemoteObject
					.narrow(ref1, RegistrazioneRemote.class);

			request.setCharacterEncoding("UTF-8");
			MultipartRequest mrequest = new MultipartRequest(request, "./"); // dim.
																				// max
																				// di
																				// 1Mbyte

			// String username = mrequest.getParameter("username");
			String nome = mrequest.getParameter("nome");
			String cognome = mrequest.getParameter("cognome");
			String email = mrequest.getParameter("email");
			String password = mrequest.getParameter("password");
			String confermaPassword = mrequest.getParameter("confermaPassword");

			/*
			 * File foto = mrequest.getFile("foto"); byte[] fotoProfiloBytes =
			 * null; if (foto != null) { if (!(foto.getName().endsWith(".jpg")
			 * || foto.getName().endsWith(".jpeg") ||
			 * foto.getName().endsWith(".png") || foto.getName()
			 * .endsWith(".gif"))) throw new RegistrazioneException(
			 * "Estensione del file non corretta"); fotoProfiloBytes =
			 * GetBytesFromFile.getBytesFromFile(foto); }
			 */

			Random random = new Random();
			int codice = 1 + random.nextInt(1000000);

			int idUtente = registrazioneRemote.salvaDatiUtente(email, password,
					confermaPassword, nome, cognome, codice); // ,
																// fotoProfiloBytes);
			String linkConfermaRegistrazione = "http://www.shareminutes.com/RegistrazioneServlet?to=confermaRegistrazione&idUtente="
					+ idUtente + "&codice=" + codice;
			String body = "Ciao, "
					+ nome
					+ " "
					+ cognome
					+ ",\n"
					+ "clicca sul seguente link per confermare la tua registrazione:\n"
					+ linkConfermaRegistrazione;
			Mailer mailer = new Mailer();
			mailer.SendEmail(email, "Registrazione Shareminutes", body);
			session.setAttribute("Successo",
					"Registrazione avvenuta con successo, riceverai una mail di conferma!");

			redirect("index.jsp", request, response);
			return;
		} catch (RegistrazioneException e) {
			session.setAttribute("Errore", e.toString());
			redirect("RegistrazioneServlet?to=redirectToPaginaRegistrazione",
					request, response);
		} catch (IOException e) {
			session.setAttribute(
					"Errore",
					new RegistrazioneException(
							"La foto selezionata eccede la dimensione massima consentita di 1Mb.")
							.toString());
			redirect("RegistrazioneServlet?to=redirectToPaginaRegistrazione",
					request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	private void annullaRegistrazioneUtente(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("Registrazione/remote");
			RegistrazioneRemote registrazioneRemote = (RegistrazioneRemote) PortableRemoteObject
					.narrow(ref1, RegistrazioneRemote.class);

			if (registrazioneRemote.getUtenteSalvato() == null)
				throw new SicurezzaException();

			registrazioneRemote.annullaRegistrazioneUtenteCorrente();
			redirect("index.jsp", request, response);
		} catch (SicurezzaException e) {
			session.setAttribute("Errore", e.toString());
			redirect("index.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	// da utente/registrazione.jsp a utente/listaAbilita.jsp
	private void redirectToPaginaListaAbilita(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("Registrazione/remote");
			RegistrazioneRemote registrazioneRemote = (RegistrazioneRemote) PortableRemoteObject
					.narrow(ref1, RegistrazioneRemote.class);

			if (registrazioneRemote.getUtenteSalvato() == null) {
				throw new SicurezzaException();
			}
			redirect("utente/listaAbilita.jsp", request, response);
		} catch (SicurezzaException e) {
			session.setAttribute("Errore", e.toString());
			redirect("index.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private void confermaRegistrazione(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("Registrazione/remote");
			RegistrazioneRemote registrazioneRemote = (RegistrazioneRemote) PortableRemoteObject
					.narrow(ref1, RegistrazioneRemote.class);

			int codiceRegistrazione = Integer.parseInt(request
					.getParameter("codice"));
			int idUtente = Integer.parseInt(request.getParameter("idUtente"));

			boolean verificato = registrazioneRemote
					.verificaCodiceRegistrazione(idUtente, codiceRegistrazione);

			if (verificato) {
				session.setAttribute("Successo", "Account verificato!");
				redirect("utente/login.jsp", request, response);
			} else {
				session.setAttribute(
						"Errore",
						"Codice registrazione errato. Provare a effettuare nuovamente la registrazione o contattare gli amministratori del sito.");
			}

		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

	private void modificaPass(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("Registrazione/remote");
			RegistrazioneRemote registrazioneRemote = (RegistrazioneRemote) PortableRemoteObject
					.narrow(ref1, RegistrazioneRemote.class);

			request.setCharacterEncoding("UTF-8");
			MultipartRequest mrequest = new MultipartRequest(request, "./");
			String password = mrequest.getParameter("password");
			String confermaPassword = mrequest.getParameter("confermaPassword");

			int codiceRegistrazione = Integer.parseInt((String) session
					.getAttribute("codice"));
			int idUtente = Integer.parseInt((String) session
					.getAttribute("idUtente"));

			boolean verificato = registrazioneRemote.verificaCodice(idUtente,
					codiceRegistrazione);

			if (verificato) {
				registrazioneRemote.modificaPassword(idUtente, password,
						confermaPassword);
				session.setAttribute("Successo",
						"Password reimpostata con successo.");
				redirect("utente/login.jsp", request, response);
			} else {
				session.setAttribute("Errore", "Errore di sicurezza.");
				redirect("utente/login.jsp", request, response);
			}

			return;
		} catch (RegistrazioneException e) {
			session.setAttribute("Errore", e.toString());
			redirect("index.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void reimpostaPassword(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("codice", request.getParameter("codice"));
		session.setAttribute("idUtente", request.getParameter("idUtente"));
		redirect("utente/reimpostaPassword.jsp", request, response);
	}

	private void salvaDatiLanding(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("Registrazione/remote");
			RegistrazioneRemote registrazioneRemote = (RegistrazioneRemote) PortableRemoteObject
					.narrow(ref1, RegistrazioneRemote.class);

			request.setCharacterEncoding("UTF-8");

			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String nomeAbilita = request.getParameter("abilita");

			int idLanding = registrazioneRemote.salvaDatiLanding(nome, email,
					nomeAbilita);

			String body = "Ciao "
					+ nome
					+ ","
					+ "<br>Abbiamo ricevuto la tua richiesta."
					+ "<br>Stiamo lavorando per voi. Shareminutes ti aiuterà a valorizzare il tuo tempo facendo quello ti piace o a trovare il tuo Shareminuter."
					+ "<br>"
					+ "<br>Sai fare qualcosa?"
					+ "<br>Che tu sia un professionista, un appassionato o semplicemente hai del tempo libero, su Shareminutes puoi condividere il tuo tempo e vendere il tuo talento."
					+ "Diventa anche tu uno Shareminuter!"
					+ "<br>"
					+ "<br>Saremo online a breve, ti avviseremo quando potrai completare il tuo profilo."
					+ "<br>"
					+ "<br>A presto"
					+ "<br><img src=\"http://shareminutes.com/images/logo_ufficiale.png\" width=\"180\" height=\"24\"></img>"
					+ "<br>Lo staff";
			Mailer mailer = new Mailer();
			mailer.SendEmail(email, "Registrazione Shareminutes", body);

			session.setAttribute("Successo", "Dati inseriti con successo!");

			redirect("landing.jsp", request, response);
			return;
		} catch (RegistrazioneException e) {
			session.setAttribute("Errore", e.toString());
			redirect("landing.jsp", request, response);
		} catch (IOException e) {
			session.setAttribute(
					"Errore",
					new RegistrazioneException(
							"La foto selezionata eccede la dimensione massima consentita di 1Mb.")
							.toString());
			redirect("landing.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (AddressException e) {
			session.setAttribute("Errore", "Inserire una mail corretta");
			redirect("landing.jsp", request, response);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
