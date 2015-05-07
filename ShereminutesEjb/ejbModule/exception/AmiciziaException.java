package exception;

public class AmiciziaException extends Exception {
	private String nome = "Amicizia Exception";
	private static final long serialVersionUID = 1L;

	public AmiciziaException() {
		super();
	}

	public AmiciziaException(String nome) {
		this.nome = nome;
	}

	@Override
	public String toString() {
		return nome;
	}
}
