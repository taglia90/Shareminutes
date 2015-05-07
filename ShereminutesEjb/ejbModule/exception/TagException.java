package exception;

public class TagException extends Exception {
	private String nome = "Tag Exception";
	private static final long serialVersionUID = 1L;

	public TagException() {
		super();
	}

	public TagException(String nome) {
		this.nome = nome;
	}

	@Override
	public String toString() {
		return nome;
	}

}
