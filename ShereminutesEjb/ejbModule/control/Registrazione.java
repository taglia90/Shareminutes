package control;

import java.util.List;
import java.util.Random;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.hsqldb.lib.MD5;

import remote.RegistrazioneRemote;
import util.ControlloreStringhe;
import util.MD5Encrypter;
import entity.Abilita;
import entity.Feedback;
import entity.Landing;
import entity.Utente;
import exception.RegistrazioneException;

public @Stateless(name = "Registrazione") class Registrazione implements
		RegistrazioneRemote {
	@PersistenceContext(unitName = "shareminutes")
	private EntityManager entityManager;
	private Utente utente = null;

	public int salvaDatiUtente(String email, String password,
			String confermaPassword, String nome, String cognome, int codice)// ,
																				// byte[]
			// foto)
			throws RegistrazioneException {
		if (email.equals("") || password.equals("")
				|| confermaPassword.equals("") || nome.equals("")
				|| cognome.equals(""))
			throw new RegistrazioneException(
					"Non sono stati compilati tutti i campi!");
		if (email.length() > 255 || password.length() > 255
				|| confermaPassword.length() > 255 || nome.length() > 255
				|| cognome.length() > 255)
			throw new RegistrazioneException(
					"Qualcuno dei campi compilati eccede la dimensione massima consentita di 255 caratteri.");
		if (!(ControlloreStringhe.emailOk(email) && ControlloreStringhe
				.userOPassUtenteOk(password)))
			throw new RegistrazioneException(
					"L'email non � valida o la password non e' compresa tra 6 e 24 caratteri o contiene carattare speciali non accettati.");
		if (!(ControlloreStringhe.nomeOCognomeUtenteOk(nome) && ControlloreStringhe
				.nomeOCognomeUtenteOk(cognome)))
			throw new RegistrazioneException(
					"Il nome e il cognome possono contenere SOLO lettere e lo spazio che non puo' comparire come primo o ultimo carattere.");
		if (!password.equals(confermaPassword))
			throw new RegistrazioneException(
					"Hai inserito due password diverse");
		/*
		 * if (foto == null) throw new RegistrazioneException(
		 * "Non hai inserito la foto del tuo profilo!");
		 */

		Query query = entityManager
				.createQuery("FROM Utente WHERE email=:email");
		query.setParameter("email", email.toLowerCase());
		if ((!query.getResultList().isEmpty()))
			throw new RegistrazioneException("L'email '" + email
					+ "' e' gia'� stata registrata!");

		Random random = new Random();

		int idUtente;
		Utente utente = null;
		Utente utenteEsistenteConQuellId = null;
		do {
			idUtente = 1 + random.nextInt(1000000);
			utenteEsistenteConQuellId = entityManager.find(Utente.class,
					idUtente);
			if (utenteEsistenteConQuellId == null) { // se non esiste gia'� un'
														// utente con quell'id
				utente = new Utente(idUtente, email.toLowerCase(),
						MD5Encrypter.encrypt(password), nome, cognome, false,
						codice); // NB:
				// in
				// minuscole

			}
		} while (utenteEsistenteConQuellId != null);

		entityManager.persist(utente);
		return idUtente;
	}

	public Utente getUtenteSalvato() {
		return this.utente;
	}

	public void annullaRegistrazioneUtenteCorrente() {
		this.utente = null;
	}

	public boolean verificaCodiceRegistrazione(int idUtente,
			int codiceRegistrazione) {
		Query query = entityManager
				.createQuery("FROM Utente WHERE idUtente = ?1 AND codiceConferma = ?2");
		query.setParameter(1, idUtente);
		query.setParameter(2, codiceRegistrazione);
		Utente utente = (Utente) query.getSingleResult();
		if (utente != null) {
			utente.setEmailConfermata(true);
			entityManager.merge(utente);
			return true;
		} else {
			return false;
		}
	}

	public boolean verificaCodice(int idUtente, int codice) {
		Query query = entityManager
				.createQuery("FROM Utente WHERE idUtente = ?1 AND codiceConferma = ?2");
		query.setParameter(1, idUtente);
		query.setParameter(2, codice);
		Utente utente = (Utente) query.getSingleResult();
		if (utente != null) {
			return true;
		} else {
			return false;
		}
	}

	public void modificaPassword(int idUtente, String password,
			String confermaPassword) throws RegistrazioneException {
		if (password.equals("") || confermaPassword.equals(""))
			throw new RegistrazioneException(
					"Non sono stati compilati tutti i campi!");
		if (password.length() > 255 || confermaPassword.length() > 255)
			throw new RegistrazioneException(
					"Qualcuno dei campi compilati eccede la dimensione massima consentita di 255 caratteri.");
		if (!(ControlloreStringhe.userOPassUtenteOk(password)))
			throw new RegistrazioneException(
					"L'email non � valida o la password non e' compresa tra 6 e 24 caratteri o contiene carattare speciali non accettati.");
		if (!password.equals(confermaPassword))
			throw new RegistrazioneException(
					"Hai inserito due password diverse");

		Query query = entityManager
				.createQuery("FROM Utente WHERE idUtente=?1");
		query.setParameter(1, idUtente);
		Utente u = (Utente) query.getSingleResult();
		if (u == null)
			throw new RegistrazioneException("L'utente non esiste.");

		u.setPassword(MD5Encrypter.encrypt(password));

		entityManager.merge(u);
		return;

	}

	public int salvaDatiLanding(String nome, String email, String nomeAbilita)
			throws RegistrazioneException {
		if (email.equals("") || nome.equals(""))
			throw new RegistrazioneException(
					"Non sono stati compilati tutti i campi!");
		if (email.length() > 255 || nome.length() > 255
				|| nomeAbilita.length() > 255)
			throw new RegistrazioneException(
					"Qualcuno dei campi compilati eccede la dimensione massima consentita di 255 caratteri.");
		if (!(ControlloreStringhe.emailOk(email)))
			throw new RegistrazioneException(
					"L'email non � valida o contiene carattare speciali non accettati.");
		if (!(ControlloreStringhe.nomeOCognomeUtenteOk(nome)))
			throw new RegistrazioneException(
					"Il nome e il cognome possono contenere SOLO lettere e lo spazio che non puo' comparire come primo o ultimo carattere.");

		Query query = entityManager
				.createQuery("FROM Landing WHERE email=:email");
		query.setParameter("email", email.toLowerCase());
		if ((!query.getResultList().isEmpty()))
			throw new RegistrazioneException("L'email '" + email
					+ "' e' gia'� stata registrata!");

		Random random = new Random();

		int idLanding;
		Landing landing = null;
		Landing landingEsistenteConQuellId = null;
		do {
			idLanding = 1 + random.nextInt(1000000);
			landingEsistenteConQuellId = entityManager.find(Landing.class,
					idLanding);
			if (landingEsistenteConQuellId == null) { // se non esiste gia'� un'
														// utente con quell'id
				landing = new Landing(idLanding, nome, email.toLowerCase(),
						nomeAbilita);
			}
		} while (landingEsistenteConQuellId != null);

		entityManager.persist(landing);
		return idLanding;
	}
}
