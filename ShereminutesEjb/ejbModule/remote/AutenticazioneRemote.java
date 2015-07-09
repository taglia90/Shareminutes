package remote;

import javax.ejb.Remote;

import util.LoginToken;
import entity.Utente;
import exception.LoginException;

@Remote
public interface AutenticazioneRemote {
	public LoginToken autenticazione(String email, String password)
			throws LoginException;

	public Utente getUtente(String email);
	
	public void inserisciCodiceConferma(int idUtente, int codice);
}
