package remote;

import javax.ejb.Remote;

import entity.Utente;
import exception.RegistrazioneException;

@Remote
public interface RegistrazioneRemote {
	public int salvaDatiUtente(String email, String password,
			String confermaPassword, String nome, String cognome, int codice)// ,
																				// byte[]
			// foto)
			throws RegistrazioneException;

	public Utente getUtenteSalvato();

	public void annullaRegistrazioneUtenteCorrente();

	public boolean verificaCodiceRegistrazione(int idUtente,
			int codiceRegistrazione);

	public boolean verificaCodice(int idUtente, int codice);

	public void modificaPassword(int idUtente, String password,
			String confermaPassword) throws RegistrazioneException;

	public int salvaDatiLanding(String nome, String email, String nomeAbilita)
			throws RegistrazioneException;

}
