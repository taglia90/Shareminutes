package control;

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
import entity.Utente;
import exception.RegistrazioneException;

public @Stateless(name = "Registrazione") class Registrazione implements
		RegistrazioneRemote {
	@PersistenceContext(unitName = "shareminutes")
	private EntityManager entityManager;
	private Utente utente = null;

	public void salvaDatiUtente(String email, String password,
			String confermaPassword, String nome, String cognome)// , byte[]
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
					"L'email non è valida o la password non e' compresa tra 6 e 24 caratteri o contiene carattare speciali non accettati.");
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
					+ "' e' gia'  stata registrata!");

		Random random = new Random();

		int idUtente;
		Utente utente = null;
		Utente utenteEsistenteConQuellId = null;
		do {
			idUtente = 1 + random.nextInt(1000000);
			utenteEsistenteConQuellId = entityManager.find(Utente.class,
					idUtente);
			if (utenteEsistenteConQuellId == null) { // se non esiste gia'  un'
														// utente con quell'id
				utente = new Utente(idUtente, email.toLowerCase(),
						MD5Encrypter.encrypt(password), nome, cognome, false); // NB:
				// in
				// minuscole

			}
		} while (utenteEsistenteConQuellId != null);

		entityManager.persist(utente);

	}

	public Utente getUtenteSalvato() {
		return this.utente;
	}

	public void annullaRegistrazioneUtenteCorrente() {
		this.utente = null;
	}

}
