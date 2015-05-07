package exception;

public class SicurezzaException extends Exception {
	private String nome = "VIOLAZIONE DELLA SICUREZZA! Non hai i privilegi per accedere a questa pagina";
	private static final long serialVersionUID = 1L;

	public SicurezzaException() {
		super();
	}

	public SicurezzaException(String nome) {
		this.nome = nome;
	}

	@Override
	public String toString() {
		return nome;
	}
}
