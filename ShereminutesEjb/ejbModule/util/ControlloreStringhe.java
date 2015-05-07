package util;

public class ControlloreStringhe {
	/**
	 * Controlla che la stringa passata sia compresa tra 6 e 24 caratteri. Puo'
	 * inoltre contenere solo lettere, numeri e i caratteri speciali . _ - che
	 * non possono essere usati come primo o ultimo carattere. esempio:
	 * "admin_90" e' accettata; "admin 90" non e' accettata.
	 */
	// per usernameUtente e passwordUtente
	public static boolean userOPassUtenteOk(String s) {
		if (s == null)
			return false;
		if (s.length() < 6 || s.length() > 24)
			return false;
		if (s.charAt(0) == '_' || s.charAt(0) == '-' || s.charAt(0) == '.'
				|| s.charAt(s.length() - 1) == '_'
				|| s.charAt(s.length() - 1) == '-'
				|| s.charAt(s.length() - 1) == '.')
			return false;
		for (int i = 0; i < s.length(); i++)
			if (!(Character.isLetterOrDigit(s.charAt(i)) || s.charAt(i) == '_'
					|| s.charAt(i) == '-' || s.charAt(i) == '.'))
				return false;
		return true;
	}

	public static boolean emailOk(String email) {
		String emailPattern = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,4})$";
		if (email.matches(emailPattern)) {
			return true;
		}
		return false;
	}

	/**
	 * Controlla che la stringa passata sia compresa tra 1 e 255 caratteri e
	 * contenenga SOLO lettere e il carattere speciale 'space' che non puo'
	 * essere usato come primo o ultimo carattere. esempio: "Marco Tagliabue" e'
	 * accettata; " Marco" non e' accettata.
	 */
	// per nomeUtente e cognomeUtente
	public static boolean nomeOCognomeUtenteOk(String s) {
		if (s == null)
			return false;
		if (s.length() == 0 || s.length() > 255)
			return false;
		if (s.charAt(0) == ' ' || s.charAt(s.length() - 1) == ' ') // non puo'
																	// cominciare
																	// o finire
																	// con uno
																	// spazio
			return false;
		for (int i = 0; i < s.length(); i++)
			if (!(Character.isLetter(s.charAt(i)) || s.charAt(i) == ' '))
				return false;
		return true;
	}

	/**
	 * Controlla che la stringa passata sia compresa tra 1 e 255 caratteri e
	 * contenenga SOLO lettere, numeri e i caratteri speciali 'space' . _ - che
	 * non possono essere usati come primo o ultimo carattere.
	 */
	// per nomeAbilita
	public static boolean nomeOggettoOk(String s) {
		if (s == null)
			return false;
		if (s.length() == 0 || s.length() > 255)
			return false;
		if (s.charAt(0) == ' ' || s.charAt(0) == '_' || s.charAt(0) == '-'
				|| s.charAt(0) == '.' || s.charAt(s.length() - 1) == ' '
				|| s.charAt(s.length() - 1) == '_'
				|| s.charAt(s.length() - 1) == '-'
				|| s.charAt(s.length() - 1) == '.')
			return false;
		for (int i = 0; i < s.length(); i++)
			if (!(Character.isLetterOrDigit(s.charAt(i)) || s.charAt(i) == ' '
					|| s.charAt(i) == '_' || s.charAt(i) == '-' || s.charAt(i) == '.'))
				return false;
		return true;
	}

	/**
	 * Controlla che la stringa passata sia compresa tra 1 e 65535 caratteri e
	 * NON contenga i caratteri speciali < > esempio: "< Ciao >" non e'
	 * accettata; "Ciao " e' accettata.
	 */
	// per descrizioneAbilita
	public static boolean descrizioneOk(String s) {
		if (s == null)
			return false;
		if (s.length() == 0 || s.length() > 65535)
			return false;
		for (int i = 0; i < s.length(); i++)
			if (s.charAt(i) == '<' || s.charAt(i) == '>')
				return false;
		return true;
	}
}