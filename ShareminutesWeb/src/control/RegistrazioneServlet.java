package control;

import java.io.File;
import java.io.IOException;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import remote.RegistrazioneRemote;
import util.GetBytesFromFile;

import com.oreilly.servlet.MultipartRequest;

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

			registrazioneRemote.salvaDatiUtente(email, password,
					confermaPassword, nome, cognome); // , fotoProfiloBytes);
			session.setAttribute("Successo",
					"Registrazione avvenuta con successo!");

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

}
