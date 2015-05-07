package util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * E' un algoritmo di crittografia (utilizzato per le password degli utenti)
 */
public class MD5Encrypter {
	public static byte[] encrypt(String message) {
		byte[] bytesOfMessage;
		try {
			bytesOfMessage = message.getBytes("UTF-8");
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] thedigest = md.digest(bytesOfMessage);
			return thedigest;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static boolean uguali(byte[] digesta, byte[] digestb) {
		return MessageDigest.isEqual(digesta, digestb);
	}

}
