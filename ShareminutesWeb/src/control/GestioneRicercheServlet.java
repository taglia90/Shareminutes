package control;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import remote.GestioneAbilitaRemote;
import remote.GestioneTagRemote;
import remote.GestioneUtentiRemote;
import util.LoginToken;

import com.oreilly.servlet.MultipartRequest;
import org.hibernate.SQLQuery;

import entity.Abilita;
import entity.Tag;
import entity.Utente;
import exception.TagException;
import exception.UtentiException;

public class GestioneRicercheServlet extends Servlet {
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
		if (to.equals("ricerca"))
			this.ricerca(request, response);
		if (to.equals("ricercaUtente"))
			this.ricercaUtente(request, response);
		if (to.equals("ricercaTag"))
			this.ricercaTag(request, response);
		if (to.equals("redirectToPaginaRicerca"))
			this.redirectToPaginaRicerca(request, response);
		if (to.equals("ricercaUtenteNonLoggato"))
			this.ricercaUtenteNonLoggato(request, response);
		if (to.equals("redirectToIndex"))
			this.redirectToIndex(request, response);
		if (to.equals("redirectToPaginaRegistrazione"))
			this.redirectToPaginaRegistrazione(request, response);
		if (to.equals("redirectToPaginaRicercaUtenteNonLoggato"))
			this.redirectToPaginaRicercaUtenteNonLoggato(request, response);

	}

	private void redirectToIndex(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("index.jsp", request, response);

	}

	private void redirectToPaginaRegistrazione(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("utente/registrazione.jsp", request, response);

	}

	// redirige alla pagina di invio richiesta inviando anche il nome
	// dell'utente a cui si manda la richiesta.
	private void redirectToPaginaRicerca(HttpServletRequest request,
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
		redirect("utente/ricerca.jsp", request, response);
	}

	private void redirectToPaginaRicercaUtenteNonLoggato(
			HttpServletRequest request, HttpServletResponse response) {
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

		// redirigealla pagina di invio richiesta inviando anche il nome
		// dell'utente a cui si manda la richiesta.

		// request.getParameter("usernameDestinatario");

		redirect("pubbliche/ricercaUtentiNonLoggati.jsp", request, response);
	}

	private void ricerca(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			MultipartRequest mrequest = new MultipartRequest(request, "./");
			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");

			int idUtente = tok.getIdUtente();

			int idAbilita = Integer.parseInt(mrequest
					.getParameter("abilitaScelta"));

			List<Utente> listaUtentiAmiciConAbilita = new ArrayList<Utente>();
			List<Utente> listaUtentiNONAmiciConAbilita = new ArrayList<Utente>();
			List<Utente> listaUtentiAmici = gestioneUtentiRemote
					.getListaAmici(idUtente);
			List<Utente> listaUtentiConAbilita = gestioneUtentiRemote
					.getListaUtentiConAbilita(idAbilita);

			for (Utente utenteAb : listaUtentiConAbilita) {
				boolean isUtenteAmico = false;

				for (Utente utenteAmico : listaUtentiAmici) {
					if (utenteAb.getUsername()
							.equals(utenteAmico.getUsername())) {
						isUtenteAmico = true;
					}
				}

				if (!utenteAb.getUsername().equals(idUtente)) {
					if (isUtenteAmico) {
						listaUtentiAmiciConAbilita.add(utenteAb);
					} else {
						listaUtentiNONAmiciConAbilita.add(utenteAb);
					}
				}
				if (mrequest.getParameter("cercaTraAmici") != null) {
					listaUtentiNONAmiciConAbilita = new ArrayList<Utente>();

				}
				session.setAttribute("listaUtentiAmici",
						listaUtentiAmiciConAbilita);
				session.setAttribute("listaUtentiNONAmici",
						listaUtentiNONAmiciConAbilita);

			}
			redirect("utente/risultatoRicerca.jsp", request, response);
		} catch (IOException e) {
			redirect("../index.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private void ricercaUtente(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			MultipartRequest mrequest = new MultipartRequest(request, "./");
			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");

			int idUtente = tok.getIdUtente();

			String stringa = mrequest.getParameter("stringa");

			List<Utente> listaUtentiAmiciCercati = new ArrayList<Utente>();
			List<Utente> listaUtentiNONAmiciCercati = new ArrayList<Utente>();

			List<Utente> listaUtentiAmici = gestioneUtentiRemote
					.getListaAmici(idUtente);

			List<Utente> listaUtentiRicercati = gestioneUtentiRemote
					.getListaUtenti(stringa);

			for (Utente utente : listaUtentiRicercati) {
				boolean isUtenteAmico = false;

				for (Utente utenteAmico : listaUtentiAmici) {
					if (utente.getUsername().equals(utenteAmico.getUsername())) {
						isUtenteAmico = true;
					}
				}

				if (!utente.getUsername().equals(idUtente)) {
					if (isUtenteAmico) {
						listaUtentiAmiciCercati.add(utente);
					} else {
						listaUtentiNONAmiciCercati.add(utente);
					}
				}
			}
			session.setAttribute("listaUtentiAmici", listaUtentiAmiciCercati);
			session.setAttribute("listaUtentiNONAmici",
					listaUtentiNONAmiciCercati);

			redirect("utente/risultatoRicerca.jsp", request, response);

		} catch (UtentiException e) {
			session.setAttribute("Errore", e.toString());
			redirect("utente/ricerca.jsp", request, response);

		} catch (IOException e) {
			redirect("../index.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private void ricercaUtenteNonLoggato(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			MultipartRequest mrequest = new MultipartRequest(request, "./");

			int idAbilita = Integer.parseInt(mrequest
					.getParameter("abilitaScelta"));

			List<Utente> listaUtentiConAbilita = gestioneUtentiRemote
					.getListaUtentiConAbilita(idAbilita);

			session.setAttribute("listaUtentiConAbilita", listaUtentiConAbilita);

			redirect("pubbliche/risultatoRicercaUtentiNonLoggati.jsp", request,
					response);
		} catch (IOException e) {
			redirect("index.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private void ricercaTag(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneTag/remote");
			GestioneTagRemote gestioneTagRemote = (GestioneTagRemote) PortableRemoteObject
					.narrow(ref1, GestioneTagRemote.class);
			/*
			 * Object ref2 = jndiContext.lookup("GestioneAbilita/remote");
			 * GestioneAbilitaRemote gestioneAbilitaRemote =
			 * (GestioneAbilitaRemote) PortableRemoteObject .narrow(ref2,
			 * GestioneAbilitaRemote.class);
			 */
			MultipartRequest mrequest = new MultipartRequest(request, "./");
			/*
			 * LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			 * int idUtente = tok.getIdUtente();
			 */

			String stringa = mrequest.getParameter("stringa");
			String citta = mrequest.getParameter("citta");
			String disponibilita = mrequest.getParameter("disponibilita");

			Date data;
			if (mrequest.getParameter("data") != null) {
				String stringaData = mrequest.getParameter("data");
				SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
				data = formatter.parse(stringaData);
				Calendar cal = Calendar.getInstance();
				cal.setTime(data);
				int giorno = cal.get(Calendar.DAY_OF_WEEK);
				String[] valore = { "DO", "LU", "MA", "ME", "GI", "VE", "SA" };
				disponibilita = valore[giorno] + disponibilita;

			} else {
				data = null;
				disponibilita = "";
			}

			// session.createSqlQuery("");
			List<Abilita> listaAbilita = gestioneTagRemote.ricercaTag(stringa,
					citta, disponibilita, data);
			session.setAttribute("listaAbilita", listaAbilita);

			redirect("utente/risultatoRicerca.jsp", request, response);

		} catch (IOException e) {
			redirect("../index.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (TagException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

}