package util;

import java.io.Serializable;

/**
 * Crea il token di autenticazione
 */
public class LoginToken implements Serializable {
	private static final long serialVersionUID = 1L;

	public enum TipoAccesso {
		Amministratore, Utente
	}

	private int idUtente;
	private String email;
	private String nome;
	private String cognome;
	private long sessionID;
	private TipoAccesso requiredAccess;

	public LoginToken(int idUtenteL, String emailL, String nomeL, String cognomeL,
			long sessionIDL, TipoAccesso requiredAccessL) {
		this.idUtente = idUtenteL;
		this.email = emailL;
		this.nome = nomeL;
		this.cognome = cognomeL;
		this.sessionID = sessionIDL;
		this.requiredAccess = requiredAccessL;
	}

	public int getIdUtente() {
		return idUtente;
	}

	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public long getSessionID() {
		return sessionID;
	}

	public void setSessionID(long sessionID) {
		this.sessionID = sessionID;
	}

	public TipoAccesso getRequiredAccess() {
		return requiredAccess;
	}

	public void setRequiredAccess(TipoAccesso requiredAccess) {
		this.requiredAccess = requiredAccess;
	}

}
