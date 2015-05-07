package exception;

public class RichiestaException extends Exception {
	private String nome = "Richiesta Exception";
	private static final long serialVersionUID = 1L;

	public RichiestaException() {
		super();
	}

	public RichiestaException(String nome) {
		this.nome = nome;
	}

	@Override
	public String toString() {
		return nome;
	}
}
