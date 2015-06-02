package exception;

public class PrenotazioneException extends Exception {
	private String nome = "Prenotazione Exception";
	private static final long serialVersionUID = 1L;

	public PrenotazioneException() {
		super();
	}

	public PrenotazioneException(String nome) {
		this.nome = nome;
	}

	@Override
	public String toString() {
		return nome;
	}

}
