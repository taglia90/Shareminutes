package control;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import entity.Abilita;
import entity.Utente;
import exception.AbilitaException;
import remote.GestioneAbilitaRemote;
import util.ControlloreStringhe;

@SuppressWarnings("unchecked")
public @Stateless(name = "GestioneAbilita") class GestioneAbilita implements
		GestioneAbilitaRemote {
	@PersistenceContext(unitName = "shareminutes")
	private EntityManager entityManager;

	public int creaAbilita(String nomeAbilita, String descrizioneAbilita,
			boolean isApprovata, byte[] foto, int minutiNecessari, int tariffa,
			int minuti, String cittaDoveOffreServizio, String disponibilita)
			throws AbilitaException {
		if (nomeAbilita.length() > 255)
			throw new AbilitaException(
					"Il nome dell'attivita' eccede la dimensione massima consentita di 255 caratteri");
		if (!ControlloreStringhe.nomeOggettoOk(nomeAbilita))
			throw new AbilitaException(
					"Il nome dell'attivita' deve avere da 1 a 255 caratteri e puo' contenere SOLO lettere, numeri e i caratteri speciali 'space' . _ - che non possono comparire come primo o ultimo carattere");

		if (descrizioneAbilita.length() > 65535)
			throw new AbilitaException(
					"La descrizione eccede la dimensione massima consentita di 65535 caratteri");
		if (!ControlloreStringhe.descrizioneOk(descrizioneAbilita))
			throw new AbilitaException(
					"La descrizione deve essere compresa tra 1 e 65535 caratteri e NON puo' contenere i caratteri speciali");// '<'
																																// e
																																// '>'");

		Random random = new Random();
		Abilita abilita = null;
		Abilita abilitaEsistenteConQuellId = null;
		int idAbilita;
		do {
			idAbilita = 1 + random.nextInt(1000000);
			abilitaEsistenteConQuellId = entityManager.find(Abilita.class,
					idAbilita);
			if (abilitaEsistenteConQuellId == null) { // se non esiste gia'  un'
														// abilita' con quell'id
				Query query = entityManager
						.createQuery("FROM Abilita a WHERE nomeAbilita=:nomeAbil");
				query.setParameter("nomeAbil", nomeAbilita);

				if (query.getResultList().isEmpty()) // non ci sono consegne nel
														// progetto col nome
														// richiesto
					abilita = new Abilita(idAbilita, nomeAbilita,
							descrizioneAbilita, isApprovata, foto,
							minutiNecessari, tariffa, minuti,
							cittaDoveOffreServizio, disponibilita);
				else
					throw new AbilitaException(
							"E' gia'  stata definita una abilita' con quel nome.");
			}
		} while (abilitaEsistenteConQuellId != null);
		entityManager.persist(abilita);
		return idAbilita;

	}

	public void modificaAbilita(int idAbilita, String nomeAbilita,
			String descrizioneAbilita, byte[] foto, int minutiNecessari,
			int tariffa, int minuti, String cittaDoveOffreServizio,
			String disponibilita) throws AbilitaException {
		if (nomeAbilita.length() > 255)
			throw new AbilitaException(
					"Il nome dell'attivita' eccede la dimensione massima consentita di 255 caratteri");
		if (!ControlloreStringhe.nomeOggettoOk(nomeAbilita))
			throw new AbilitaException(
					"Il nome dell'attivita' deve avere da 1 a 255 caratteri e puo' contenere SOLO lettere, numeri e i caratteri speciali 'space' . _ - che non possono comparire come primo o ultimo carattere");

		if (descrizioneAbilita.length() > 65535)
			throw new AbilitaException(
					"La descrizione eccede la dimensione massima consentita di 65535 caratteri");
		if (!ControlloreStringhe.descrizioneOk(descrizioneAbilita))
			throw new AbilitaException(
					"La descrizione deve essere compresa tra 1 e 65535 caratteri e NON puo' contenere i caratteri speciali '<' e '>'");

		Abilita abilitaDaModificare = entityManager.find(Abilita.class,
				idAbilita);
		// Query query = entityManager
		// .createQuery("FROM Abilita a WHERE nomeAbilita=:nomeAbil AND idAbilita!=:idAbil");
		// query.setParameter("nomeAbil", nomeAbilita);
		// query.setParameter("idAbil", idAbilita);

		// if (query.getResultList().isEmpty()) { // se non ci sono abilita nel
		// progetto col nome richiesto

		abilitaDaModificare.setNomeAbilita(nomeAbilita);
		abilitaDaModificare.setDescrizioneAbilita(descrizioneAbilita);
		abilitaDaModificare.setFotoAbilita(foto);
		abilitaDaModificare.setMinutiNecessari(minutiNecessari);
		abilitaDaModificare.setTariffa(tariffa);
		abilitaDaModificare.setMinuti(minuti);
		abilitaDaModificare.setCittaDoveOffreServizio(cittaDoveOffreServizio);
		abilitaDaModificare.setDisponibilita(disponibilita);
		entityManager.merge(abilitaDaModificare);
		// } else
		// throw new AbilitaException(
		// "E' gia'  stata definita un'abilita' con quel nome.");
	}

	public void modificaAbilita(int idAbilita, String nomeAbilita,
			String descrizioneAbilita) throws AbilitaException {
		if (nomeAbilita.length() > 255)
			throw new AbilitaException(
					"Il nome dell'attivita' eccede la dimensione massima consentita di 255 caratteri");
		if (!ControlloreStringhe.nomeOggettoOk(nomeAbilita))
			throw new AbilitaException(
					"Il nome dell'attivita' deve avere da 1 a 255 caratteri e puo' contenere SOLO lettere, numeri e i caratteri speciali 'space' . _ - che non possono comparire come primo o ultimo carattere");

		if (descrizioneAbilita.length() > 65535)
			throw new AbilitaException(
					"La descrizione eccede la dimensione massima consentita di 65535 caratteri");
		if (!ControlloreStringhe.descrizioneOk(descrizioneAbilita))
			throw new AbilitaException(
					"La descrizione deve essere compresa tra 1 e 65535 caratteri e NON puo' contenere i caratteri speciali '<' e '>'");

		Abilita abilitaDaModificare = entityManager.find(Abilita.class,
				idAbilita);

		abilitaDaModificare.setNomeAbilita(nomeAbilita);
		abilitaDaModificare.setDescrizioneAbilita(descrizioneAbilita);
		entityManager.merge(abilitaDaModificare);
	}

	public void approvaAbilita(int idAbilita) throws AbilitaException {

		Abilita abilitaDaAbilitare = entityManager.find(Abilita.class,
				idAbilita);
		if (abilitaDaAbilitare.isApproved())
			throw new AbilitaException("L'abilita' e' gia' stata accettata");

		abilitaDaAbilitare.setApproved(true);
		entityManager.merge(abilitaDaAbilitare);

	}

	public void eliminaAbilita(int idAbilita) throws AbilitaException {

		GestioneTag gt = new GestioneTag();
		GestionePrenotazioni gp = new GestionePrenotazioni();
		gt.eliminaTuttiTagDiAbilita(idAbilita);
		gp.eliminaTuttePrenotazioniDiAbilita(idAbilita);

		Abilita abilitaDaEliminare = entityManager.find(Abilita.class,
				idAbilita);
		if (abilitaDaEliminare == null)
			throw new AbilitaException("L'attività non esiste");
		entityManager.remove(abilitaDaEliminare);
	}

	public List<Abilita> getListaAbilita() {
		Query query = entityManager
				.createQuery("FROM Abilita a WHERE isApproved=" + true);

		List<Abilita> listaAbilita = (List<Abilita>) query.getResultList();
		if (listaAbilita.isEmpty())
			return null;
		return listaAbilita;
	}

	public List<Abilita> getListaAbilitaDiUtente(int idUtente) {
		Utente user = entityManager.find(Utente.class, idUtente);
		List<Abilita> listaAbilitaUtente = user.getAbilita();
		List<Abilita> listaAbilitaApprovate = new ArrayList<Abilita>();
		if (user.getAbilita() != null && user.getAbilita().size() > 0) {
			int i;
			for (i = 0; i < listaAbilitaUtente.size(); i++) {
				if (listaAbilitaUtente.get(i).isApproved()) {
					listaAbilitaApprovate.add(listaAbilitaUtente.get(i));
				}
			}
		}
		return listaAbilitaApprovate;

	}

	public List<Abilita> getListaAbilitaDaApprovareDiUtente(int idUtente) {
		Utente user = entityManager.find(Utente.class, idUtente);
		List<Abilita> listaAbilitaUtente = user.getAbilita();
		List<Abilita> listaAbilitaNonApprovate = new ArrayList<Abilita>();
		if (user.getAbilita() != null && user.getAbilita().size() > 0) {
			int i;
			for (i = 0; i < listaAbilitaUtente.size(); i++) {
				if (!listaAbilitaUtente.get(i).isApproved()) {
					listaAbilitaNonApprovate.add(listaAbilitaUtente.get(i));
				}
			}
		}
		return listaAbilitaNonApprovate;

	}

	public List<Abilita> getListaAbilitaDaApprovare() {
		Query getAbilitaDaApprovare = entityManager
				.createQuery("FROM Abilita a WHERE isApproved=" + false);

		List<Abilita> listaAbilitaDaApprovare = (List<Abilita>) getAbilitaDaApprovare
				.getResultList();
		return listaAbilitaDaApprovare;
	}

	public Abilita getAbilita(int idAbilita) {
		return (Abilita) entityManager.find(Abilita.class, idAbilita);
	}

	public void inserisciAbilitaInUtente(int idUtente, int idAbilita) {

		Utente user = entityManager.find(Utente.class, idUtente);
		Abilita abilita = entityManager.find(Abilita.class, idAbilita);
		user.setNewAbilita(abilita);

		entityManager.merge(user);

	}

	public void eliminaAbilitaUtente(int idUtente, int idAbility) {

		Utente utente = entityManager.find(Utente.class, idUtente);
		Abilita ability = entityManager.find(Abilita.class, idAbility);
		utente.rimuoviAbilita(ability);
		entityManager.merge(utente);
		entityManager.merge(ability);

	}

	public void svuotaAbilitaInUtente(int idUtente) {
		Utente utente = entityManager.find(Utente.class, idUtente);
		utente.svuotaAbilita();

		entityManager.merge(utente);
		entityManager.flush();

	}

	public byte[] getFotoAbilita(int idAbilita) {
		Abilita abilita = entityManager.find(Abilita.class, idAbilita);
		return abilita.getFotoAbilita();
	}

}
