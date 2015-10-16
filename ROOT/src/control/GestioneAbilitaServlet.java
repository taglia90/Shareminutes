package control;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.persistence.EntityManager;
import javax.rmi.PortableRemoteObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import remote.GestioneAbilitaRemote;
import remote.GestioneDisponibilitaRemote;
import remote.GestioneFeedbackRemote;
import remote.GestionePrenotazioniRemote;
import remote.GestioneTagRemote;
import remote.GestioneUtentiRemote;
import util.GetBytesFromFile;
import util.LoginToken;

import com.oreilly.servlet.MultipartRequest;

import entity.Abilita;
import entity.Disponibilita;
import entity.Feedback;
import entity.Prenotazione;
import entity.Tag;
import entity.Utente;
import exception.AbilitaException;
import exception.TagException;

public class GestioneAbilitaServlet extends Servlet {
	private static final long serialVersionUID = 1L;
	private EntityManager entityManager;
	private static final int MAX_NUM_ABILITA = 2;
	private static final int MAX_NUM_TAG = 10;

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String to = (String) request.getParameter("to");
		if (to.equals("redirectToPaginaCreazioneAbilita"))
			this.redirectToPaginaCreazioneAbilita(request, response);
		if (to.equals("creaAbilita"))
			try {
				this.creaAbilita(request, response);
			} catch (TagException e) {
				e.printStackTrace();
			}
		if (to.equals("redirectToPaginaModificaAbilita"))
			this.redirectToPaginaModificaAbilita(request, response);
		if (to.equals("redirectToPaginaProfiloAbilita"))
			this.redirectToPaginaProfiloAbilita(request, response);
		if (to.equals("modificaAbilita"))
			this.modificaAbilita(request, response);
		if (to.equals("eliminaAbilita"))
			this.eliminaAbilita(request, response);
		if (to.equals("redirectToPaginaListaAbilitaAdmin"))
			this.redirectToPaginaListaAbilitaAdmin(request, response);
		if (to.equals("redirectToPaginaAbilitaDaValutare"))
			this.redirectToPaginaAbilitaDaValutare(request, response);
		if (to.equals("approvaAbilita"))
			this.approvaAbilita(request, response);
		if (to.equals("redirectToPaginaListaAbilitaUser"))
			this.redirectToPaginaListaAbilitaUser(request, response);
		if (to.equals("inserisciAbilitaUtente"))
			this.inserisciAbilitaUtente(request, response);
		if (to.equals("redirectToPaginaAggiungiAbilitaUtente"))
			this.redirectToPaginaAggiungiAbilitaUtente(request, response);
		if (to.equals("getFotoAbilita"))
			this.getFotoAbilita(request, response);
		if (to.equals("memorizzaDataProfiloAbilita"))
			this.memorizzaDataProfiloAbilita(request, response);
		if (to.equals("cambiaDataProfiloAbilita"))
			this.cambiaDataProfiloAbilita(request, response);
	}

	private void redirectToPaginaAbilitaDaValutare(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneAbilita/remote");
			GestioneAbilitaRemote gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
					.narrow(ref1, GestioneAbilitaRemote.class);

			List<Abilita> listaAbilitaDaApprovare = gestioneAbilitaRemote
					.getListaAbilitaDaApprovare();
			session.setAttribute("listaAbilitaDaApprovare",
					listaAbilitaDaApprovare);
			redirect("admin/abilitaDaValutare.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

	private void redirectToPaginaListaAbilitaUser(HttpServletRequest request,
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

			redirect("utente/listaAbilita.jsp", request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

	private void redirectToPaginaListaAbilitaAdmin(HttpServletRequest request,
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

	private void redirectToPaginaCreazioneAbilita(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		Context jndiContext;
		try {
			jndiContext = new javax.naming.InitialContext();

			Object ref1 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref1, GestioneUtentiRemote.class);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();
			Utente utente = gestioneUtentiRemote.getUtente(idUtente);
			if (utente.isAdmin()) {
				redirect("admin/creaAbilitaAdmin.jsp", request, response);
			} else {
				redirect("utente/creaAbilita.jsp", request, response);

			}

		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

	private void modificaAbilita(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneAbilita/remote");
			GestioneAbilitaRemote gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
					.narrow(ref1, GestioneAbilitaRemote.class);
			Object ref2 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref2, GestioneUtentiRemote.class);
			Object ref3 = jndiContext.lookup("GestioneTag/remote");
			GestioneTagRemote gestioneTagRemote = (GestioneTagRemote) PortableRemoteObject
					.narrow(ref3, GestioneTagRemote.class);

			request.setCharacterEncoding("UTF-8");
			MultipartRequest mrequest;
			mrequest = new MultipartRequest(request, "./");
			// dim. max di 1Mbyte

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();
			Utente utente = gestioneUtentiRemote.getUtente(idUtente);

			File foto = mrequest.getFile("foto");
			byte[] fotoProfiloBytes = null;
			if (foto != null) {
				if (!(foto.getName().endsWith(".jpg")
						|| foto.getName().endsWith(".jpeg")
						|| foto.getName().endsWith(".png") || foto.getName()
						.endsWith(".gif")))
					throw new AbilitaException(
							"Estensione del file non corretta");
				fotoProfiloBytes = GetBytesFromFile.getBytesFromFile(foto);
			}

			if (mrequest.getParameter("idAbilita") == null)
				throw new AbilitaException(
						"Errore! Nessun'abilita' specificata");

			int idAbilita = Integer
					.parseInt(mrequest.getParameter("idAbilita"));

			String nome = mrequest.getParameter("nome");
			String descrizione = mrequest.getParameter("descrizione");

			String cittaDoveOffreServizio = mrequest
					.getParameter("cittaDoveOffreServizio");
			String tag = mrequest.getParameter("tag");
			String[] tagArray = { "" };
			if (tag != null) {
				tagArray = convertStringToArray(tag);
			}

			int minutiNecessari = 0;
			if (mrequest.getParameter("minutiNecessari") != null)
				minutiNecessari = Integer.parseInt(mrequest
						.getParameter("minutiNecessari"));

			int tariffa = 0;
			if (mrequest.getParameter("tariffa") != null)
				tariffa = Integer.parseInt(mrequest.getParameter("tariffa"));

			int minuti = 0;
			if (mrequest.getParameter("minuti") != null)
				minuti = Integer.parseInt(mrequest.getParameter("minuti"));

			/*
			 * int disponibilitaLunedìDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaLunedìDalle")); int
			 * disponibilitaLunedìAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaLunedìAlle")); int
			 * disponibilitaMartedìDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaMartedìDalle")); int
			 * disponibilitaMartedìAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaMartedìAlle")); int
			 * disponibilitaMercoledìDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaMercoledìDalle")); int
			 * disponibilitaMercoledìAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaMercoledìAlle")); int
			 * disponibilitaGiovedìDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaGiovedìDalle")); int
			 * disponibilitaGiovedìAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaGiovedìAlle")); int
			 * disponibilitaVenerdìDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaVenerdìDalle")); int
			 * disponibilitaVenerdìAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaVenerdìAlle")); int
			 * disponibilitaSabatoDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaSabatoDalle")); int
			 * disponibilitaSabatoAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaSabatoAlle")); int
			 * disponibilitaDomenicaDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaDomenicaDalle")); int
			 * disponibilitaDomenicaAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaDomenicaAlle"));
			 */

			String[] disponibilita = mrequest
					.getParameterValues("disponibilita");

			// this will get array of values of all checked checkboxes
			/*
			 * for (String id : disponibilita) { // do something with id, this
			 * is checkbox value }
			 */

			String stringaDisponibilita = convertArrayToString(disponibilita);

			if (utente.isAdmin()
					|| mrequest.getParameter("pubblicaAbilita") != null) {
				if (nome.length() == 0)
					throw new AbilitaException(
							"Non hai inserito il nome dell' attivita'");
				if (descrizione.length() == 0)
					throw new AbilitaException(
							"Non hai inserito la descrizione dell' attivita'");
				if (tagArray.length > 10)
					throw new AbilitaException(
							"Non puoi inserire più di 10 tag");

				/*
				 * if (disponibilitaLunedìDalle > disponibilitaLunedìAlle ||
				 * disponibilitaMartedìDalle > disponibilitaMartedìAlle ||
				 * disponibilitaMercoledìDalle > disponibilitaMercoledìAlle ||
				 * disponibilitaGiovedìDalle > disponibilitaGiovedìAlle ||
				 * disponibilitaVenerdìDalle > disponibilitaVenerdìAlle ||
				 * disponibilitaSabatoDalle > disponibilitaSabatoAlle ||
				 * disponibilitaDomenicaDalle > disponibilitaDomenicaAlle) {
				 * session.setAttribute("Errore",
				 * "L'ora di fine di un lavoro non può essere minore di quella di inizio."
				 * ); redirect("utente/modificaAbilita.jsp", request, response);
				 * return; }
				 */

				if (fotoProfiloBytes == null) {
					fotoProfiloBytes = gestioneAbilitaRemote
							.getFotoAbilita(idAbilita);
				}

				if (!utente.isAdmin()) {
					gestioneAbilitaRemote.modificaAbilita(idAbilita, nome,
							descrizione, fotoProfiloBytes, minutiNecessari,
							tariffa, minuti, cittaDoveOffreServizio,
							stringaDisponibilita);
					gestioneTagRemote.eliminaTuttiTagDiAbilita(idAbilita);
					for (int i = 0; i < tagArray.length; i++) {

						try {
							gestioneTagRemote.creaTag(tagArray[i], idAbilita);
						} catch (TagException e) {
							e.printStackTrace();
						}
					}
				} else {
					gestioneAbilitaRemote.modificaAbilita(idAbilita, nome,
							descrizione);

				}
				/*
				 * gestioneDisponibilitaRemote.modificaDisponibilita(idAbilita,
				 * disponibilitaLunedìDalle, disponibilitaLunedìAlle,
				 * disponibilitaMartedìDalle, disponibilitaMartedìAlle,
				 * disponibilitaMercoledìDalle, disponibilitaMercoledìAlle,
				 * disponibilitaGiovedìDalle, disponibilitaGiovedìAlle,
				 * disponibilitaVenerdìDalle, disponibilitaVenerdìAlle,
				 * disponibilitaSabatoDalle, disponibilitaSabatoAlle,
				 * disponibilitaDomenicaDalle, disponibilitaDomenicaAlle);
				 */

				// gestioneDisponibilitaRemote.modificaDisponibilita(idAbilita,
				// stringaDisponibilita);

				session.setAttribute("Successo",
						"Attivita' modificata correttamente");
				if (utente.isAdmin()) {
					this.redirectToPaginaListaAbilitaAdmin(request, response);
				} else {
					this.redirectToPaginaListaAbilitaUser(request, response);
				}
			} else {
				session.setAttribute("Errore",
						"Devi accettare di attivare la disponibilità.");
				this.redirectToPaginaModificaAbilita(request, response);
			}
		} catch (AbilitaException e) {
			session.setAttribute("Errore", e.toString());
			redirect("utente/modificaAbilita.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void approvaAbilita(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneAbilita/remote");
			GestioneAbilitaRemote gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
					.narrow(ref1, GestioneAbilitaRemote.class);
			Object ref2 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref2, GestioneUtentiRemote.class);

			if (request.getParameter("idAbilita") == null)
				throw new AbilitaException(
						"Errore! Nessun'abilita' specificata");

			int idAbilita = Integer.parseInt(request.getParameter("idAbilita"));

			String stringIsApprovata = request.getParameter("isApprovata");

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();
			Utente utente = gestioneUtentiRemote.getUtente(idUtente);

			if (utente.isAdmin()) {
				if (stringIsApprovata.equals("true")) {
					gestioneAbilitaRemote.approvaAbilita(idAbilita);
					session.setAttribute("Successo",
							"Abilita approvata correttamente");
				} else {

					gestioneAbilitaRemote.eliminaAbilita(idAbilita);

					session.setAttribute("Successo",
							"Abilita rimossa correttamente");
				}

				this.redirectToPaginaAbilitaDaValutare(request, response);

			}

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (AbilitaException e) {
			session.setAttribute("Errore", e.toString());
			redirect("admin/abilitaDaValutare.jsp", request, response);

		}
	}

	private void eliminaAbilita(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneAbilita/remote");
			GestioneAbilitaRemote gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
					.narrow(ref1, GestioneAbilitaRemote.class);
			Object ref2 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref2, GestioneUtentiRemote.class);

			if (request.getParameter("idAbilita") == null)
				throw new AbilitaException(
						"Errore! Nessun'abilita' specificata");

			int idAbilita = Integer.parseInt(request.getParameter("idAbilita"));

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();
			Utente utente = gestioneUtentiRemote.getUtente(idUtente);
			gestioneAbilitaRemote.eliminaAbilita(idAbilita);
			session.setAttribute("Successo", "Abilita eliminata correttamente");
			if (utente.isAdmin()) {
				this.redirectToPaginaListaAbilitaAdmin(request, response);
			} else {
				this.redirectToPaginaListaAbilitaUser(request, response);
				// redirect("utente/listaAbilita.jsp", request, response);
			}

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (AbilitaException e) {
			session.setAttribute("Errore", e.toString());
			this.redirectToPaginaListaAbilitaAdmin(request, response);

		}
	}

	private void creaAbilita(HttpServletRequest request,
			HttpServletResponse response) throws TagException {
		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneAbilita/remote");
			GestioneAbilitaRemote gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
					.narrow(ref1, GestioneAbilitaRemote.class);

			Object ref2 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref2, GestioneUtentiRemote.class);

			Object ref3 = jndiContext.lookup("GestioneTag/remote");
			GestioneTagRemote gestioneTagRemote = (GestioneTagRemote) PortableRemoteObject
					.narrow(ref3, GestioneTagRemote.class);

			/*
			 * Object ref4 = jndiContext.lookup("GestioneDisponibilita/remote");
			 * GestioneDisponibilitaRemote gestioneDisponibilitaRemote =
			 * (GestioneDisponibilitaRemote) PortableRemoteObject .narrow(ref4,
			 * GestioneDisponibilitaRemote.class);
			 */

			request.setCharacterEncoding("UTF-8");

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			List<Abilita> listaAbilitaDiUtente = gestioneAbilitaRemote
					.getListaAbilitaDiUtente(tok.getIdUtente());
			List<Abilita> listaAbilitaDaApprovareDiUtente = gestioneAbilitaRemote
					.getListaAbilitaDaApprovareDiUtente(tok.getIdUtente());

			int numeroAbilitaDiUtente = listaAbilitaDiUtente.size()
					+ listaAbilitaDaApprovareDiUtente.size();

			if (numeroAbilitaDiUtente > MAX_NUM_ABILITA) {
				session.setAttribute("Errore",
						"Non puoi creare piu' di due abilita'.");
				redirect("utente/creaAbilita.jsp", request, response);
			}
			MultipartRequest mrequest;
			mrequest = new MultipartRequest(request, "./");
			// dim.
			// max
			// di
			// 1Mbyte

			String nome = mrequest.getParameter("nome");
			String descrizione = mrequest.getParameter("descrizione");
			String cittaDoveOffreServizio = mrequest
					.getParameter("cittaDoveOffreServizio");
			String tag = mrequest.getParameter("tag");
			String[] tagArray = { "" };
			if (tag != null) {
				tagArray = convertStringToArray(tag);
			}

			int minutiNecessari = Integer.parseInt(mrequest
					.getParameter("minutiNecessari"));
			if (mrequest.getParameter("minutiNecessari") == null)
				minutiNecessari = 0;
			int tariffa = Integer.parseInt(mrequest.getParameter("tariffa"));
			int minuti = Integer.parseInt(mrequest.getParameter("minuti"));

			String[] disponibilita = mrequest
					.getParameterValues("disponibilita");

			/*
			 * String[] giorno = { "Lunedì", "Martedì", "Mercoledì", "Giovedì",
			 * "Venerdì", "Sabato", "Domenica" };
			 */
			/*
			 * int disponibilitaLunedìDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaLunedìDalle")); int
			 * disponibilitaLunedìAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaLunedìAlle")); int
			 * disponibilitaMartedìDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaMartedìDalle")); int
			 * disponibilitaMartedìAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaMartedìAlle")); int
			 * disponibilitaMercoledìDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaMercoledìDalle")); int
			 * disponibilitaMercoledìAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaMercoledìAlle")); int
			 * disponibilitaGiovedìDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaGiovedìDalle")); int
			 * disponibilitaGiovedìAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaGiovedìAlle")); int
			 * disponibilitaVenerdìDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaVenerdìDalle")); int
			 * disponibilitaVenerdìAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaVenerdìAlle")); int
			 * disponibilitaSabatoDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaSabatoDalle")); int
			 * disponibilitaSabatoAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaSabatoAlle")); int
			 * disponibilitaDomenicaDalle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaDomenicaDalle")); int
			 * disponibilitaDomenicaAlle = Integer.parseInt(mrequest
			 * .getParameter("disponibilitaDomenicaAlle"));
			 */
			String stringaDisponibilita = convertArrayToString(disponibilita);

			File foto = mrequest.getFile("foto");
			byte[] fotoProfiloBytes = null;
			if (foto != null) {
				if (!(foto.getName().endsWith(".jpg")
						|| foto.getName().endsWith(".jpeg")
						|| foto.getName().endsWith(".png") || foto.getName()
						.endsWith(".gif")))
					throw new AbilitaException(
							"Estensione del file non corretta");

				fotoProfiloBytes = GetBytesFromFile.getBytesFromFile(foto);
			}
			if (mrequest.getParameter("pubblicaAbilita") != null) {

				if (nome == null || nome.length() == 0) {
					session.setAttribute("Errore",
							"Non hai inserito il nome dell' attivita'");
					redirect("utente/creaAbilita.jsp", request, response);
					return;
				}
				if (descrizione == null || descrizione.length() == 0) {
					session.setAttribute("Errore",
							"Non hai inserito la descrizione dell' attivita'");
					redirect("utente/creaAbilita.jsp", request, response);
					return;
				}

				if (mrequest.getParameter("tariffa") == null
						|| mrequest.getParameter("minuti") == null) {
					session.setAttribute("Errore",
							"Non hai inserito la tariffa oraria");
					redirect("utente/creaAbilita.jsp", request, response);
					return;
				}
				if (tagArray.length > MAX_NUM_TAG) {
					session.setAttribute("Errore",
							"Non puoi inserire più di 10 tag");
					redirect("utente/creaAbilita.jsp", request, response);
					return;
				}

				/*
				 * if (disponibilitaLunedìDalle > disponibilitaLunedìAlle ||
				 * disponibilitaMartedìDalle > disponibilitaMartedìAlle ||
				 * disponibilitaMercoledìDalle > disponibilitaMercoledìAlle ||
				 * disponibilitaGiovedìDalle > disponibilitaGiovedìAlle ||
				 * disponibilitaVenerdìDalle > disponibilitaVenerdìAlle ||
				 * disponibilitaSabatoDalle > disponibilitaSabatoAlle ||
				 * disponibilitaDomenicaDalle > disponibilitaDomenicaAlle) {
				 * session.setAttribute("Errore",
				 * "L'ora di fine di un lavoro non può essere minore di quella di inizio."
				 * ); redirect("utente/creaAbilita.jsp", request, response);
				 * return; }
				 */
				int idUtente = tok.getIdUtente();
				Utente utente = gestioneUtentiRemote.getUtente(idUtente);
				if (utente.isAdmin()) {
					int idAbilita = gestioneAbilitaRemote.creaAbilita(nome,
							descrizione, true, fotoProfiloBytes,
							minutiNecessari, tariffa, minuti,
							cittaDoveOffreServizio, stringaDisponibilita);
					for (int i = 0; i < tagArray.length; i++) {
						gestioneTagRemote.creaTag(tagArray[i], idAbilita);
					}

					gestioneTagRemote
							.creaTag(cittaDoveOffreServizio, idAbilita);
					gestioneTagRemote.creaTag(nome, idAbilita);
					/*
					 * gestioneDisponibilitaRemote.creaDisponibilita(idAbilita,
					 * disponibilitaLunedìDalle, disponibilitaLunedìAlle,
					 * disponibilitaMartedìDalle, disponibilitaMartedìAlle,
					 * disponibilitaMercoledìDalle, disponibilitaMercoledìAlle,
					 * disponibilitaGiovedìDalle, disponibilitaGiovedìAlle,
					 * disponibilitaVenerdìDalle, disponibilitaVenerdìAlle,
					 * disponibilitaSabatoDalle, disponibilitaSabatoAlle,
					 * disponibilitaDomenicaDalle, disponibilitaDomenicaAlle);
					 */
					// gestioneDisponibilitaRemote.creaDisponibilita(idAbilita,
					// disponibilita);
					session.setAttribute("Successo",
							"Attivita' creata correttamente");

					this.redirectToPaginaListaAbilitaAdmin(request, response);

				} else {

					int idAbilita = gestioneAbilitaRemote.creaAbilita(nome,
							descrizione, false, fotoProfiloBytes,
							minutiNecessari, tariffa, minuti,
							cittaDoveOffreServizio, stringaDisponibilita);

					gestioneAbilitaRemote.inserisciAbilitaInUtente(idUtente,
							idAbilita);
					for (int i = 0; i < tagArray.length; i++) {
						gestioneTagRemote.creaTag(tagArray[i], idAbilita);
					}
					gestioneTagRemote
							.creaTag(cittaDoveOffreServizio, idAbilita);
					gestioneTagRemote.creaTag(nome, idAbilita);
					/*
					 * gestioneDisponibilitaRemote.creaDisponibilita(idAbilita,
					 * disponibilitaLunedìDalle, disponibilitaLunedìAlle,
					 * disponibilitaMartedìDalle, disponibilitaMartedìAlle,
					 * disponibilitaMercoledìDalle, disponibilitaMercoledìAlle,
					 * disponibilitaGiovedìDalle, disponibilitaGiovedìAlle,
					 * disponibilitaVenerdìDalle, disponibilitaVenerdìAlle,
					 * disponibilitaSabatoDalle, disponibilitaSabatoAlle,
					 * disponibilitaDomenicaDalle, disponibilitaDomenicaAlle);
					 */

					// gestioneDisponibilitaRemote.creaDisponibilita(idAbilita,
					// disponibilita);
					session.setAttribute("Successo",
							"Abilita creata correttamente, in fase di approvazione");

					this.redirectToPaginaListaAbilitaUser(request, response);
				}
			} else {
				session.setAttribute("Errore",
						"Devi accettare di attivare la disponibilità.");
				this.redirectToPaginaCreazioneAbilita(request, response);
			}

		} catch (AbilitaException e) {
			session.setAttribute("Errore", e.toString());
			redirect("utente/creaAbilita.jsp", request, response);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (NumberFormatException e) {
			session.setAttribute("Errore",
					"Nei minuti e nella tariffa va inserito un numero.");
			redirect("utente/creaAbilita.jsp", request, response);
		}
	}

	private void redirectToPaginaModificaAbilita(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			HttpSession session = request.getSession();

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneAbilita/remote");
			GestioneAbilitaRemote gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
					.narrow(ref1, GestioneAbilitaRemote.class);
			Object ref2 = jndiContext.lookup("GestioneUtenti/remote");
			GestioneUtentiRemote gestioneUtentiRemote = (GestioneUtentiRemote) PortableRemoteObject
					.narrow(ref2, GestioneUtentiRemote.class);
			Object ref3 = jndiContext.lookup("GestioneTag/remote");
			GestioneTagRemote gestioneTagRemote = (GestioneTagRemote) PortableRemoteObject
					.narrow(ref3, GestioneTagRemote.class);

			if (request.getParameter("idAbilita") == null)
				throw new AbilitaException(
						"Errore! Nessun'abilita' specificata");

			int idAbilita = Integer.parseInt(request.getParameter("idAbilita"));
			Abilita abilita = gestioneAbilitaRemote.getAbilita(idAbilita);
			session.setAttribute("abilita", abilita);

			// Disponibilita disponibilita =
			// gestioneDisponibilitaRemote.getIdDisponibilita(idAbilita);

			List<Tag> listaTag = gestioneTagRemote
					.getListaTagDiAbilita(idAbilita);
			String tag = "";
			if (listaTag != null) {
				for (int i = 0; i < listaTag.size(); i++) {
					Tag singoloTag = listaTag.get(i);
					tag += singoloTag.getStringaTag() + " ";
				}
			}
			session.setAttribute("tag", tag);

			List<String> val = Arrays.asList(convertStringToArray(abilita
					.getDisponibilita()));
			session.setAttribute("disponibilita", val);

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			Utente utente = gestioneUtentiRemote.getUtente(tok.getIdUtente());
			if (utente.isAdmin()) {
				redirect("admin/modificaAbilita.jsp", request, response);
			} else {
				redirect("utente/modificaAbilita.jsp", request, response);
			}

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (AbilitaException e) {
			redirect("utente/modificaAbilita.jsp", request, response);
			e.printStackTrace();
		}
	}

	private void redirectToPaginaProfiloAbilita(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneAbilita/remote");
			GestioneAbilitaRemote gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
					.narrow(ref1, GestioneAbilitaRemote.class);
			Object ref2 = jndiContext.lookup("GestionePrenotazioni/remote");
			GestionePrenotazioniRemote gestionePrenotazioniRemote = (GestionePrenotazioniRemote) PortableRemoteObject
					.narrow(ref2, GestionePrenotazioniRemote.class);
			Object ref3 = jndiContext.lookup("GestioneFeedback/remote");
			GestioneFeedbackRemote gestioneFeedbackRemote = (GestioneFeedbackRemote) PortableRemoteObject
					.narrow(ref3, GestioneFeedbackRemote.class);

			request.setCharacterEncoding("UTF-8");

			if (request.getParameter("idAbilita") == null)
				throw new AbilitaException(
						"Errore! Nessun'attivita' specificata");

			int idAbilita = Integer.parseInt(request.getParameter("idAbilita"));
			String stringaData;
			Abilita abilita = gestioneAbilitaRemote.getAbilita(idAbilita);
			List<Prenotazione> listaPrenotazioniInData = new ArrayList<Prenotazione>();
			List<String> disponibilita = new ArrayList<String>(
					Arrays.asList(convertStringToArray(abilita
							.getDisponibilita())));
			if (request.getParameter("data") == null
					|| request.getParameter("data")
							.equals("Seleziona una data")) {
				stringaData = "";
			} else {
				stringaData = request.getParameter("data");
				SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
				Date data = formatter.parse(stringaData);

				listaPrenotazioniInData = gestionePrenotazioniRemote
						.getListaPrenotazioniInData(data, idAbilita);

				String orarioSingolaPrenotazione;
				// List<String> stringa = new ArrayList<String>();
				if (listaPrenotazioniInData != null) {
					// List<String> disp = new ArrayList<String>();
					for (int i = 0; i < listaPrenotazioniInData.size(); i++) {
						orarioSingolaPrenotazione = listaPrenotazioniInData
								.get(i).getOrarioPrenotato();
						// stringa =
						// Arrays.asList(convertStringToArray(orarioSingolaPrenotazione));
						disponibilita.remove(orarioSingolaPrenotazione);
						/*
						 * if
						 * (!disponibilita.contains(orarioSingolaPrenotazione))
						 * { disp.add(disponibilita.get(i)); }
						 */

					}
					// disponibilita = disp;
				}

			}

			Utente utente = abilita.getUtente().get(0);
			List<Feedback> listaFeedback = gestioneFeedbackRemote
					.getListaFeedbackRicevutiDiUnUtente(utente.getIdUtente());

			/*
			 * List<Tag> listaTag = gestioneTagRemote
			 * .getListaTagDiAbilita(idAbilita); String tag = ""; for (int i =
			 * 0; i < listaTag.size(); i++) { Tag singoloTag = listaTag.get(i);
			 * tag += singoloTag.getStringaTag() + " "; }
			 * 
			 * session.setAttribute("tag", tag);
			 */

			session.setAttribute("listaFeedback", listaFeedback);
			session.setAttribute("abilita", abilita);
			session.setAttribute("disponibilita", disponibilita);
			session.setAttribute("data", stringaData);

			redirect("utente/profiloAbilita.jsp", request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (AbilitaException e) {
			redirect("utente/profiloAbilita.jsp", request, response);
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			// La data non è nel formato corretto.
			e.printStackTrace();
		}
	}

	private void inserisciAbilitaUtente(HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneAbilita/remote");
			GestioneAbilitaRemote gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
					.narrow(ref1, GestioneAbilitaRemote.class);
			MultipartRequest multi = new MultipartRequest(request, "./");

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			int idUtente = tok.getIdUtente();

			List<Abilita> listaAbilitaUtente = gestioneAbilitaRemote
					.getListaAbilitaDiUtente(idUtente);
			for (Abilita abilita : listaAbilitaUtente) {

				gestioneAbilitaRemote.eliminaAbilitaUtente(idUtente,
						abilita.getIdAbilita());
			}

			if (multi.getParameterValues("idAbilita") != null) {
				String[] idSetAbility = multi.getParameterValues("idAbilita");
				int i;

				for (i = 0; i < idSetAbility.length; i++) {
					gestioneAbilitaRemote.inserisciAbilitaInUtente(idUtente,
							Integer.parseInt(idSetAbility[i]));
				}
			}
			session.setAttribute("Successo",
					"Abilita' inserita/e correttamente.");

			this.redirectToPaginaListaAbilitaUser(request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

	private void redirectToPaginaAggiungiAbilitaUtente(
			HttpServletRequest request, HttpServletResponse response) {

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
					.getListaAbilita();

			List<Abilita> listaAbilitaUtente = gestioneAbilitaRemote
					.getListaAbilitaDiUtente(idUtente);

			List<Abilita> listaAbilitaNONDiUtente = new ArrayList<Abilita>();
			if (listaAbilita != null) {
				for (Abilita abilita : listaAbilita) {
					boolean abilitaDiUtente = false;

					for (Abilita abilitaUtente : listaAbilitaUtente) {
						if (abilita.getIdAbilita() == abilitaUtente
								.getIdAbilita()) {
							abilitaDiUtente = true;
						}

					}
					if (!abilitaDiUtente) {
						listaAbilitaNONDiUtente.add(abilita);
					}
				}
			}

			session.setAttribute("listaAbilitaUtente", listaAbilitaUtente);
			session.setAttribute("listaAbilitaNONDiUtente",
					listaAbilitaNONDiUtente);

			redirect("utente/aggiungiAbilita.jsp", request, response);

		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

	private void getFotoAbilita(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			Context jndiContext = new javax.naming.InitialContext();
			Object ref2 = jndiContext.lookup("GestioneAbilita/remote");
			GestioneAbilitaRemote gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
					.narrow(ref2, GestioneAbilitaRemote.class);

			// HttpSession session = request.getSession();
			// LoginToken tok = (LoginToken) session.getAttribute("LoginToken");

			int idAbilita = Integer.parseInt(request.getParameter("idAbilita"));

			byte[] fotoAbilita = gestioneAbilitaRemote
					.getFotoAbilita(idAbilita);
			if (fotoAbilita != null) {
				response.setContentType("image/png");
				response.setContentLength(fotoAbilita.length);
				response.getOutputStream().write(fotoAbilita);
			}
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/*
	 * public List<String> getDisponibilitaAbilita(int idAbilita) {
	 * 
	 * Context jndiContext; List<String> disponibilitaInData = new
	 * ArrayList<String>(); try { jndiContext = new
	 * javax.naming.InitialContext(); Object ref1 =
	 * jndiContext.lookup("GestioneAbilita/remote"); GestioneAbilitaRemote
	 * gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
	 * .narrow(ref1, GestioneAbilitaRemote.class);
	 * 
	 * Abilita abilita = gestioneAbilitaRemote.getAbilita(idAbilita);
	 * 
	 * disponibilitaInData = Arrays.asList(convertStringToArray(abilita
	 * .getDisponibilita())); } catch (NamingException e) {
	 * 
	 * e.printStackTrace(); }
	 * 
	 * return disponibilitaInData; }
	 */

	public List<String> getPrenotazioneinData(int idAbilita, Date data) {

		Context jndiContext;
		List<String> prenotazioneInData = new ArrayList<String>();
		try {
			jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestioneAbilita/remote");
			GestioneAbilitaRemote gestioneAbilitaRemote = (GestioneAbilitaRemote) PortableRemoteObject
					.narrow(ref1, GestioneAbilitaRemote.class);

			Abilita abilita = gestioneAbilitaRemote.getAbilita(idAbilita);

			prenotazioneInData = Arrays.asList(convertStringToArray(abilita
					.getDisponibilita()));
		} catch (NamingException e) {

			e.printStackTrace();
		}

		return prenotazioneInData;
	}

	private void memorizzaDataProfiloAbilita(HttpServletRequest request,
			HttpServletResponse response) {
		// HttpSession session = request.getSession();
		try {

			request.setCharacterEncoding("UTF-8");

			// String stringaData = request.getParameter("data");

			int idAbilita = Integer.parseInt(request.getParameter("idAbilita"));
			// session.setAttribute("data", stringaData);

			redirect(
					"GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita="
							+ idAbilita, request, response);
			return;

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	private void cambiaDataProfiloAbilita(HttpServletRequest request,
			HttpServletResponse response) {
		// HttpSession session = request.getSession();
		try {
			request.setCharacterEncoding("UTF-8");

			int idAbilita = Integer.parseInt(request.getParameter("idAbilita"));
			// session.setAttribute("data", "");

			redirect(
					"GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita="
							+ idAbilita, request, response);
			return;

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public List<Tag> getListaTag(int idAbilita) {
		Context jndiContext;
		List<Tag> listaTag = new ArrayList<Tag>();
		try {
			jndiContext = new javax.naming.InitialContext();

			Object ref3 = jndiContext.lookup("GestioneTag/remote");
			GestioneTagRemote gestioneTagRemote = (GestioneTagRemote) PortableRemoteObject
					.narrow(ref3, GestioneTagRemote.class);
			listaTag = gestioneTagRemote.getListaTagDiAbilita(idAbilita);

		} catch (NamingException e) {
			e.printStackTrace();
		}
		return listaTag;
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

}
