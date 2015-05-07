package exception;

public class AbilitaException extends Exception {
	private String nome = "Abilita Exception";
	private static final long serialVersionUID = 1L;

	public AbilitaException() {
		super();
	}

	public AbilitaException(String nome) {
		this.nome = nome;
	}

	@Override
	public String toString() {
		return nome;
	}
}
