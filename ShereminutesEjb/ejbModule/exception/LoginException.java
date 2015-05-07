package exception;

public class LoginException extends Exception {
	private String nome = "Login Exception";
	private static final long serialVersionUID = 1L;

	public LoginException() {
		super();
	}

	public LoginException(String nome) {
		this.nome = nome;
	}

	@Override
	public String toString() {
		return nome;
	}
}
