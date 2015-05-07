package exception;

public class RegistrazioneException extends Exception {
	private String nome = "Registrazione Exception";
	private static final long serialVersionUID = 1L;

	public RegistrazioneException() {
		super();
	}

	public RegistrazioneException(String nome) {
		this.nome = nome;
	}

	@Override
	public String toString() {
		return nome;
	}
}
