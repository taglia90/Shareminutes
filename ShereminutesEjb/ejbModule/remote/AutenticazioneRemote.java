package remote;

import javax.ejb.Remote;

import util.LoginToken;
import exception.LoginException;

@Remote
public interface AutenticazioneRemote {
	public LoginToken autenticazione(String email, String password)
			throws LoginException;
}
