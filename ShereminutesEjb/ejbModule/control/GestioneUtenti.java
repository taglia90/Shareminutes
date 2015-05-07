package control;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import remote.GestioneUtentiRemote;
import util.ControlloreStringhe;
import util.MD5Encrypter;
import entity.Abilita;
import entity.Amicizia;
import entity.Utente;
import exception.AbilitaException;
import exception.AmiciziaException;
import exception.RegistrazioneException;
import exception.UtentiException;

@SuppressWarnings("unchecked")
public @Stateless(name = "GestioneUtenti") class GestioneUtenti implements
		GestioneUtentiRemote {
	@PersistenceContext(unitName = "shareminutes")
	private EntityManager entityManager;

	public List<Utente> getListaAbilitaUtente(Abilita abilita) {
		Query query = entityManager
				.createQuery("FROM Utente WHERE idAbilita = ?1");
		query.setParameter(1, abilita.getIdAbilita());
		List<Utente> listaAbilita = query.getResultList();
		if (listaAbilita.isEmpty())
			return null;
		return listaAbilita;
	}

	public Utente getUtente(int idUtente) {
		Utente utente = entityManager.find(Utente.class, idUtente);
		return utente;
	}

	public byte[] getFotoProfilo(int idUtente) {
		Utente utente = entityManager.find(Utente.class, idUtente);
		return utente.getFotoProfilo();
	}

	public List<Utente> getListaUtenti() {
		Query query = entityManager.createQuery("FROM Utente");
		List<Utente> listaUtenti = query.getResultList();
		if (listaUtenti.isEmpty())
			listaUtenti = new ArrayList<Utente>();
		return listaUtenti;
	}

	public List<Utente> getListaUtenti(String qualsiasiStringa)
			throws UtentiException {

		if (qualsiasiStringa.length() > 255)
			throw new UtentiException(
					"Il nome dell'utente eccede la dimensione massima consentita di 255 caratteri");
		if (!ControlloreStringhe.nomeOggettoOk(qualsiasiStringa))
			throw new UtentiException(
					"Il nome dell'utente deve avere da 1 a 255 caratteri e puo' contenere SOLO lettere, numeri e i caratteri speciali 'space' . _ - che non possono comparire come primo o ultimo carattere");

		Query query = entityManager
				.createQuery("FROM Utente WHERE username LIKE ?1 OR nome LIKE ?1 OR cognome LIKE ?1");
		query.setParameter(1, "%" + qualsiasiStringa + "%");
		List<Utente> listaUtenti = query.getResultList();
		if (listaUtenti.isEmpty())
			listaUtenti = new ArrayList<Utente>();
		return listaUtenti;
	}

	public List<Utente> getListaUtentiConAbilita(int idAbilita) {
		Abilita abilita = entityManager.find(Abilita.class, idAbilita);
		return abilita.getUtente();
	}

	public List<Utente> getListaAmiciInSospeso(int idUtente) {
		Query query = entityManager
				.createQuery("FROM Amicizia a WHERE utente2_idUtente=?1)");

		query.setParameter(1, idUtente);

		List<Utente> listaUtenti = new ArrayList<Utente>();
		List<Amicizia> listaAmicizia = query.getResultList();

		for (Amicizia amicizia : listaAmicizia) {

			if (!listaUtenti.contains(amicizia.getUtente1())
					&& !amicizia.isAmiciziaAccettata()
					&& !amicizia.isAmiciziaRifiutata()) {
				listaUtenti.add(amicizia.getUtente1());
			}
		}
		return listaUtenti;
	}

	public List<Utente> getListaAmici(int idUtente) {
		Query query = entityManager
				.createQuery("FROM Amicizia a WHERE (utente1_idUtente=?1 OR utente2_idUtente=?2)");

		query.setParameter(1, idUtente);
		query.setParameter(2, idUtente);

		List<Utente> listaUtenti = new ArrayList<Utente>();

		List<Amicizia> listaAmicizia = query.getResultList();
		for (Amicizia amicizia : listaAmicizia) {
			if (!listaUtenti.contains(amicizia.getUtente1())
					&& !(amicizia.getUtente1().getUsername().equals(idUtente))
					&& amicizia.isAmiciziaAccettata()
					&& !amicizia.isAmiciziaRifiutata()) {
				listaUtenti.add(amicizia.getUtente1());
			}
			if (!listaUtenti.contains(amicizia.getUtente2())
					&& !(amicizia.getUtente2().getUsername().equals(idUtente))
					&& amicizia.isAmiciziaAccettata()
					&& !amicizia.isAmiciziaRifiutata()) {
				listaUtenti.add(amicizia.getUtente2());
			}
		}
		return listaUtenti;
	}

	public void creaRichiestaAmicizia(int idUtente1, int idUtente2)
			throws AmiciziaException {

		if (idUtente1 == idUtente2)
			throw new AmiciziaException("Non puoi essere amico di te stesso");

		Random random = new Random();
		Amicizia amicizia = null;
		Amicizia amiciziaEsistenteConQuellId = null;
		Utente user1 = entityManager.find(Utente.class, idUtente1);
		Utente user2 = entityManager.find(Utente.class, idUtente2);

		if (this.getListaAmici(idUtente1).contains(user2))
			throw new AmiciziaException("Non puoi essere amico di te stesso");

		Query query = entityManager
				.createQuery("FROM Amicizia a WHERE utente1_idUtente=?1 AND utente2_idUtente=?2");

		query.setParameter(1, idUtente1);
		query.setParameter(2, idUtente2);

		List<Amicizia> listaAmicizia = query.getResultList();

		if (!query.getResultList().isEmpty()) {
			if (listaAmicizia.size() != 1) {
				throw new AmiciziaException("amico1 con "
						+ listaAmicizia.size() + " referenze");
			}
			if (listaAmicizia.get(0).isAmiciziaAccettata()) {
				throw new AmiciziaException(
						"Sei gia' amico dell'utente selezionato.");
			}
			if (!listaAmicizia.get(0).isAmiciziaAccettata()
					|| listaAmicizia.get(0).isAmiciziaRifiutata()) {
				throw new AmiciziaException("Amicizia in fase di approvazione.");
			}

			if (!listaAmicizia.get(0).isAmiciziaRifiutata()) {
				throw new AmiciziaException(
						"Sei gia' amico dell'utente selezionato.");
			}
		}

		Query query2 = entityManager
				.createQuery("FROM Amicizia a WHERE utente1_idUtente=?1 AND utente2_idUtente=?2");

		query2.setParameter(1, idUtente2);
		query2.setParameter(2, idUtente1);

		List<Amicizia> listaAmicizia2 = query2.getResultList();

		if (!query2.getResultList().isEmpty()) {

			if (listaAmicizia2.get(0).isAmiciziaAccettata()) {
				throw new AmiciziaException(
						"Sei gia' amico dell'utente selezionata");

			}

			if (!listaAmicizia2.get(0).isAmiciziaAccettata()
					&& !listaAmicizia2.get(0).isAmiciziaRifiutata()) {
				throw new AmiciziaException(
						"Hai gia' una richiesta di amicizia in sospeo con l'utente selezionato");
			}
		}

		if (!query2.getResultList().isEmpty()) {

			if (listaAmicizia2.get(0).isAmiciziaRifiutata()) {
				Utente utenteTemp = listaAmicizia2.get(0).getUtente1();
				listaAmicizia2.get(0).setUtente1(
						listaAmicizia2.get(0).getUtente2());
				listaAmicizia2.get(0).setUtente2(utenteTemp);

				listaAmicizia2.get(0).setAmiciziaAccettata(false);
				listaAmicizia2.get(0).setAmiciziaRifiutata(false);

				entityManager.merge(listaAmicizia2.get(0));
			} else {
				throw new AmiciziaException("errore");
			}

			if (listaAmicizia2.size() != 1) {
				throw new AmiciziaException("amico2 con "
						+ listaAmicizia2.size() + " referenze");
			}
		}

		else {
			do {
				int idAmicizia = 1 + random.nextInt(1000000);
				amiciziaEsistenteConQuellId = entityManager.find(
						Amicizia.class, idAmicizia);
				if (amiciziaEsistenteConQuellId == null) { // se non esiste
															// gia' 
															// un'
															// amicizia con
															// quell'id
					amicizia = new Amicizia(idAmicizia, user1, user2, false);
				}
			} while (amiciziaEsistenteConQuellId != null);
			entityManager.persist(amicizia);
		}
	}

	public void accettaAmicizia(int idUtente1, int idUtente2)
			throws AmiciziaException {

		Query query2 = entityManager
				.createQuery("FROM Amicizia a WHERE (utente1_idUtente=?2 AND utente2_idUtente=?1)");
		query2.setParameter(1, idUtente1);

		query2.setParameter(2, idUtente2);
		List<Amicizia> listaAmicizia2 = query2.getResultList();

		if (query2.getResultList().isEmpty()) {
			throw new AmiciziaException(
					"non hai amicizie da accettare con l'utente selezionato");
		}
		if (listaAmicizia2.size() != 1) {
			throw new AmiciziaException("ci sono " + listaAmicizia2.size()
					+ " con l'utente selezionato");
		}

		listaAmicizia2.get(0).setAmiciziaAccettata(true);
		entityManager.merge(listaAmicizia2.get(0));
	}

	public void eliminaAmicizia(int idUtente1, int idUtente2)
			throws AmiciziaException {

		Query query2 = entityManager
				.createQuery("FROM Amicizia a WHERE (utente1_idUtente=?2 AND utente2_idUtente=?1)");

		query2.setParameter(1, idUtente1);
		query2.setParameter(2, idUtente2);

		List<Amicizia> listaAmicizia2 = query2.getResultList();

		if (query2.getResultList().isEmpty()) {
			throw new AmiciziaException("errore");
		}

		listaAmicizia2.get(0).setAmiciziaRifiutata(true);
		entityManager.merge(listaAmicizia2.get(0));
	}

	public void modificaProfilo(int idUtente, String nome, String cognome,
			String paese, String citta, String cap, String sesso, String eta,
			String posizioneLavorativa, String headline, String biografia,
			byte[] foto) throws UtentiException {
		if (nome.equals("") || cognome.equals(""))
			throw new UtentiException(
					"È obbligatorio inserire il nome e il cognome!");
		if (nome.length() > 255 || cognome.length() > 255
				|| headline.length() > 255
				|| posizioneLavorativa.length() > 255 || sesso.length() > 255
				|| paese.length() > 255 || citta.length() > 255
				|| cap.length() > 255 || biografia.length() > 65535)
			throw new UtentiException(
					"Qualcuno dei campi compilati eccede la dimensione massima consentita di 255 caratteri.");
		if (!(ControlloreStringhe.nomeOCognomeUtenteOk(nome) && ControlloreStringhe
				.nomeOCognomeUtenteOk(cognome)))
			throw new UtentiException(
					"Il nome e il cognome possono contenere SOLO lettere e lo spazio che non puo' comparire come primo o ultimo carattere.");

		/*
		 * if (foto == null) throw new UtentiException(
		 * "Non hai inserito la foto del tuo profilo!");
		 */
		Utente utenteDaModificare = entityManager.find(Utente.class, idUtente);

		if (utenteDaModificare != null) { // se ci sono utenti con
											// questo ID
			utenteDaModificare.setNome(nome);
			utenteDaModificare.setCognome(cognome);
			utenteDaModificare.setPaese(paese);
			utenteDaModificare.setCittaAttuale(citta);
			utenteDaModificare.setCap(cap);
			utenteDaModificare.setSesso(sesso);
			utenteDaModificare.setEta(eta);
			utenteDaModificare.setPosizioneLavorativa(posizioneLavorativa);
			utenteDaModificare.setHeadline(headline);
			utenteDaModificare.setBiografia(biografia);
			utenteDaModificare.setFotoProfilo(foto);
			entityManager.merge(utenteDaModificare);

		} else
			throw new UtentiException("Errore nella modifica dell'utente.");
	}

	public void salvaEmailPayPal(int idUtente, String emailPayPal)
			throws UtentiException {

		if (emailPayPal.equals(""))
			throw new UtentiException("Non sono stati compilati tutti i campi!");
		if (emailPayPal.length() > 255)
			throw new UtentiException("Non puoi inserire più di 255 caratteri.");
		if (!(ControlloreStringhe.emailOk(emailPayPal)))
			throw new UtentiException("L'email non è valida.");

		Utente utente = entityManager.find(Utente.class, idUtente);

		if (utente == null)
			throw new UtentiException("Errore nel salvataggio.");

		utente.setEmailPayPal(emailPayPal);
		entityManager.merge(utente);
	}

	public void modificaPassword(int idUtente, String vecchiaPwd,
			String nuovaPwd, String confermaPwd) throws UtentiException {

		if (vecchiaPwd.equals("") || nuovaPwd.equals("")
				|| confermaPwd.equals(""))
			throw new UtentiException("Non sono stati compilati tutti i campi!");
		if (vecchiaPwd.length() > 255 || nuovaPwd.length() > 255
				|| confermaPwd.length() > 255)
			throw new UtentiException(
					"La password non può essere più lunga di 255 caratteri.");
		if (!(ControlloreStringhe.userOPassUtenteOk(nuovaPwd)))
			throw new UtentiException(
					"La password non e' compresa tra 6 e 24 caratteri o contiene carattare speciali non accettati.");
		if (!nuovaPwd.equals(confermaPwd))
			throw new UtentiException("Hai inserito due password diverse");

		Utente utente = entityManager.find(Utente.class, idUtente);

		if (utente == null)
			throw new UtentiException("Errore nella modifica.");

		utente.setPassword(MD5Encrypter.encrypt(nuovaPwd));

		entityManager.merge(utente);

	}
}
