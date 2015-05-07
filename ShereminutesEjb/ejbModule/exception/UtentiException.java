package exception;

public class UtentiException extends Exception {
	private String nome = "Utenti Exception";
	private static final long serialVersionUID = 1L;

	public UtentiException() {
		super();
	}

	public UtentiException(String nome) {
		this.nome = nome;
	}

	public String toString() {
		return nome;
	}
}
