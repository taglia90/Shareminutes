package control;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import entity.Utente;
import exception.LoginException;
import remote.AutenticazioneRemote;
import util.LoginToken;
import util.LoginToken.TipoAccesso;
import util.MD5Encrypter;

public @Stateless(name = "Autenticazione") class Autenticazione implements
		AutenticazioneRemote {
	// public static final int EMAIL_AMMINISTRATORE = 1990;
	// public static final String PASSWORD_AMMINISTRATORE = "admin";
	@PersistenceContext(unitName = "shareminutes")
	private EntityManager entityManager;

	/**
	 * Fornisce il token di autenticazione, se trova l'utente corrispondente
	 * all'username e la password inserite.
	 */
	// @Override
	public LoginToken autenticazione(String email, String password)
			throws LoginException {
		LoginToken loginToken = null;
		long session = 2;
		if (email == null || password == null || email.length() == 0
				|| password.length() == 0)
			throw new LoginException("Email e/o password non inserite");

		Query query = entityManager
				.createQuery("FROM Utente WHERE email=:email");
		query.setParameter("email", email.toLowerCase());
		if (!query.getResultList().isEmpty()) {
			Utente utente = (Utente) query.getSingleResult();
			if (!MD5Encrypter.uguali(utente.getPassword(),
					MD5Encrypter.encrypt(password)))
				throw new LoginException("Email o password errati");
			if (!utente.isAdmin()) {
				loginToken = new LoginToken(utente.getIdUtente(),
						utente.getEmail(), utente.getNome(),
						utente.getCognome(), session, TipoAccesso.Utente);
			} else {
				loginToken = new LoginToken(utente.getIdUtente(),
						utente.getEmail(), utente.getNome(),
						utente.getCognome(), session,
						TipoAccesso.Amministratore);

			}
			return loginToken;
		}
		/*
		 * if (email.equals(ID_AMMINISTRATORE)) { if
		 * (!password.equals(PASSWORD_AMMINISTRATORE)) throw new
		 * LoginException("Email o password errati"); loginToken = new
		 * LoginToken(ID_AMMINISTRATORE, "Marco", "Tagliabue", session,
		 * TipoAccesso.Amministratore); return loginToken; }
		 */

		throw new LoginException("Email '" + email + "' non trovato");
	}

}
