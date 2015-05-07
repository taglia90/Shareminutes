package exception;

public class FeedbackException extends Exception {
	private String nome = "Feedback Exception";
	private static final long serialVersionUID = 1L;

	public FeedbackException() {
		super();
	}

	public FeedbackException(String nome) {
		this.nome = nome;
	}

	@Override
	public String toString() {
		return nome;
	}
}
