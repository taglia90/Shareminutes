package remote;

import javax.ejb.Remote;

import entity.Utente;
import exception.RegistrazioneException;

@Remote
public interface RegistrazioneRemote {
	public void salvaDatiUtente(String email, String password,
			String confermaPassword, String nome, String cognome)// , byte[]
																	// foto)
			throws RegistrazioneException;

	public Utente getUtenteSalvato();

	public void annullaRegistrazioneUtenteCorrente();
}
