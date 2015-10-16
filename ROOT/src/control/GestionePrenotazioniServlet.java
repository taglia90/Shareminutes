package control;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.persistence.EntityManager;
import javax.rmi.PortableRemoteObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.Prenotazione;
import entity.Utente;
import exception.AbilitaException;
import exception.AmiciziaException;
import exception.PrenotazioneException;
import remote.GestioneAbilitaRemote;
import remote.GestionePrenotazioniRemote;
import remote.GestioneRichiesteRemote;
import remote.GestioneUtentiRemote;
import util.LoginToken;

public class GestionePrenotazioniServlet extends Servlet {
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
		if (to.equals("nuovaPrenotazione"))
			this.nuovaPrenotazione(request, response);
		if (to.equals("SetAccettataSeller"))
			this.SetAccettataSeller(request, response);
		if (to.equals("SetConfermataBuyer"))
			this.SetConfermataBuyer(request, response);
		if (to.equals("SetRifiutata"))
			this.SetRifiutata(request, response);
		if (to.equals("SetPagata"))
			this.SetPagata(request, response);

	}

	private void nuovaPrenotazione(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestionePrenotazioni/remote");
			GestionePrenotazioniRemote gestionePrenotazioniRemote = (GestionePrenotazioniRemote) PortableRemoteObject
					.narrow(ref1, GestionePrenotazioniRemote.class);
			Object ref2 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref2, GestioneUtentiRemote.class);
			request.setCharacterEncoding("UTF-8");

			int idAbilita = Integer.parseInt(request.getParameter("idAbilita"));
			if (request.getParameter("data") == null) {
				session.setAttribute("Errore", "Inserire una data!");

				redirect(
						"GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita="
								+ idAbilita, request, response);
				return;
			}

			String stringaData = request.getParameter("data");

			SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			Date data = formatter.parse(stringaData);
			// System.out.println(data);
			// System.out.println(formatter.format(data));

			// int disponibilitaDalle =
			// Integer.parseInt(request.getParameter("disponibilitaDalle"));
			// int disponibilitaAlle =
			// Integer.parseInt(request.getParameter("disponibilitaAlle"));
			if (request.getParameter("disponibilita") == null
					|| request.getParameter("disponibilita").equals("")) {
				session.setAttribute("Errore", "Inserire un orario!");

				redirect(
						"GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita="
								+ idAbilita, request, response);
				return;
			}
			String[] orarioPrenotato = request
					.getParameterValues("disponibilita");
			String stringaOrarioPrenotato = convertArrayToString(orarioPrenotato);

			/*
			 * if (disponibilitaDalle > disponibilitaAlle) {
			 * session.setAttribute("Errore",
			 * "L'ora di fine di un lavoro non può essere minore di quella di inizio."
			 * ); redirect("utente/profiloAbilita.jsp", request, response);
			 * return;
			 * 
			 * }
			 */

			Utente utenteSeller = gestioneUtentiRemote
					.getListaUtentiConAbilita(idAbilita).get(0);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idPrenotazione = gestionePrenotazioniRemote.nuovaPrenotazione(
					data, stringaOrarioPrenotato, tok.getIdUtente(),
					utenteSeller.getIdUtente(), idAbilita);
			session.setAttribute("Successo",
					"Prenotazione avvenuta con successo!");

			redirect(
					"GestionePagineServlet?to=redirectToDettaglioOrdine&idPrenotazione="
							+ idPrenotazione, request, response);
			return;

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			// Errore nel parsing della data
			e.printStackTrace();
		}
	}

	private void SetAccettataSeller(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestionePrenotazioni/remote");
			GestionePrenotazioniRemote gestionePrenotazioniRemote = (GestionePrenotazioniRemote) PortableRemoteObject
					.narrow(ref1, GestionePrenotazioniRemote.class);

			request.setCharacterEncoding("UTF-8");

			int idPrenotazione = Integer.parseInt(request
					.getParameter("idPrenotazione"));

			gestionePrenotazioniRemote.setAccettataSeller(idPrenotazione);
			session.setAttribute("Successo", "Conferma avvenuta con successo!");

			redirect(
					"GestionePagineServlet?to=redirectToDettaglioOrdine&idPrenotazione="
							+ idPrenotazione, request, response);
			return;

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	private void SetConfermataBuyer(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestionePrenotazioni/remote");
			GestionePrenotazioniRemote gestionePrenotazioniRemote = (GestionePrenotazioniRemote) PortableRemoteObject
					.narrow(ref1, GestionePrenotazioniRemote.class);

			request.setCharacterEncoding("UTF-8");

			int idPrenotazione = Integer.parseInt(request
					.getParameter("idPrenotazione"));

			gestionePrenotazioniRemote.setConfermataBuyer(idPrenotazione);
			session.setAttribute("Successo", "Conferma avvenuta con successo!");

			redirect(
					"GestionePagineServlet?to=redirectToDettaglioOrdine&idPrenotazione="
							+ idPrenotazione, request, response);
			return;

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	private void SetPagata(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestionePrenotazioni/remote");
			GestionePrenotazioniRemote gestionePrenotazioniRemote = (GestionePrenotazioniRemote) PortableRemoteObject
					.narrow(ref1, GestionePrenotazioniRemote.class);
			Object ref2 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref2, GestioneUtentiRemote.class);

			request.setCharacterEncoding("UTF-8");

			int idPrenotazione = Integer.parseInt(request
					.getParameter("idPrenotazione"));
			Prenotazione prenotazione = gestionePrenotazioniRemote
					.getPrenotazione(idPrenotazione);

			gestionePrenotazioniRemote.setPagata(idPrenotazione);
			gestioneUtentiRemote.creaRichiestaAmicizia(prenotazione
					.getUtenteBuyer().getIdUtente(), prenotazione
					.getUtenteSeller().getIdUtente());
			gestioneUtentiRemote.accettaAmicizia(prenotazione.getUtenteBuyer()
					.getIdUtente(), prenotazione.getUtenteSeller()
					.getIdUtente());
			session.setAttribute("Successo", "Conferma avvenuta con successo!");

			redirect(
					"GestionePagineServlet?to=redirectToDettaglioOrdine&idPrenotazione="
							+ idPrenotazione, request, response);
			return;

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (AmiciziaException e) {
			e.printStackTrace();
		}
	}

	private void SetRifiutata(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestionePrenotazioni/remote");
			GestionePrenotazioniRemote gestionePrenotazioniRemote = (GestionePrenotazioniRemote) PortableRemoteObject
					.narrow(ref1, GestionePrenotazioniRemote.class);

			request.setCharacterEncoding("UTF-8");

			int idPrenotazione = Integer.parseInt(request
					.getParameter("idPrenotazione"));

			gestionePrenotazioniRemote.setRifiutata(idPrenotazione);
			session.setAttribute("Successo", "Rifiuto avvenuto con successo!");

			redirect(
					"GestionePagineServlet?to=redirectToDettaglioOrdine&idPrenotazione="
							+ idPrenotazione, request, response);
			return;

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public static String strSeparator = " ";

	public static String convertArrayToString(String[] array) {
		String str = "";
		if (array != null) {
			for (int i = 0; i < array.length; i++) {
				str = str + array[i];
				// Do not append comma at the end of last element
				if (i < array.length - 1) {
					str = str + strSeparator;
				}
			}
		}
		return str;
	}

	public static String[] convertStringToArray(String str) {
		String[] arr = str.split(strSeparator);
		return arr;
	}

	public boolean ciSonoOrdiniNonLetti(int idUtente) {
		boolean isLetto = false;
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestionePrenotazioni/remote");
			GestionePrenotazioniRemote gestionePrenotazioniRemote = (GestionePrenotazioniRemote) PortableRemoteObject
					.narrow(ref1, GestionePrenotazioniRemote.class);
			isLetto = gestionePrenotazioniRemote
					.ciSonoOrdiniNonLettiDiUtente(idUtente);

		} catch (NamingException e) {
			e.printStackTrace();
		}
		return isLetto;
	}
}
