package control;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import remote.GestionePrenotazioniRemote;
import remote.GestioneTagRemote;
import remote.GestioneUtentiRemote;
import remote.RegistrazioneRemote;
import util.GetBytesFromFile;
import util.LoginToken;

import com.oreilly.servlet.MultipartRequest;

import entity.Abilita;
import entity.Disponibilita;
import entity.Tag;
import entity.Utente;
import exception.AbilitaException;
import exception.RegistrazioneException;
import exception.TagException;

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

	}

	private void nuovaPrenotazione(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {

			Context jndiContext = new javax.naming.InitialContext();
			Object ref1 = jndiContext.lookup("GestionePrenotazioni/remote");
			GestionePrenotazioniRemote gestionePrenotazioniRemote = (GestionePrenotazioniRemote) PortableRemoteObject
					.narrow(ref1, GestionePrenotazioniRemote.class);

			request.setCharacterEncoding("UTF-8");

			String stringaData = request.getParameter("data");

			SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			String dateInString = stringaData;

			Date data = formatter.parse(dateInString);
			// System.out.println(data);
			// System.out.println(formatter.format(data));

			int disponibilitaDalle = Integer.parseInt(request
					.getParameter("disponibilitaDalle"));
			int disponibilitaAlle = Integer.parseInt(request
					.getParameter("disponibilitaAlle"));
			int idAbilita = Integer.parseInt(request
					.getParameter("idAbilita"));

			if (disponibilitaDalle > disponibilitaAlle) {
				session.setAttribute("Errore",
						"L'ora di fine di un lavoro non può essere minore di quella di inizio.");
				redirect("utente/profiloAbilita.jsp", request, response);
				return;

			}

			LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
			gestionePrenotazioniRemote.nuovaPrenotazione(data,
					disponibilitaDalle, disponibilitaAlle, tok.getIdUtente(),
					idAbilita);
			session.setAttribute("Successo",
					"Prenotazione avvenuta con successo!");

			redirect(
					"GestioneAbilitaServlet?to=redirectToPaginaProfiloAbilita&idAbilita="
							+ idAbilita, request, response);
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

}
