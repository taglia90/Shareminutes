package control;

import java.util.List;
import java.util.Random;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import remote.GestioneRichiesteRemote;

import entity.Richiesta;
import entity.Messaggio;
import entity.Utente;
import exception.RichiestaException;
import util.ControlloreStringhe;

@SuppressWarnings("unchecked")
public @Stateless(name = "GestioneRichieste") class GestioneRichieste implements
		GestioneRichiesteRemote {
	@PersistenceContext(unitName = "shareminutes")
	private EntityManager entityManager;

	// @Override
	/*
	 * (non-Javadoc)
	 * 
	 * @see control.ddd#creaRichiesta(java.lang.String, java.lang.String,
	 * entity.Utente, entity.Utente, java.util.Date)
	 */
	public int creaRichiesta(String oggettoRichiesta, int idUtenteMittente,
			int idUtenteDestinatario) throws RichiestaException {

		if (oggettoRichiesta.length() > 255)
			throw new RichiestaException(
					"L'oggetto del messaggio eccede la dimensione massima consentita di 255 caratteri");
		if (!ControlloreStringhe.nomeOggettoOk(oggettoRichiesta))
			throw new RichiestaException(
					"L'oggetto del messaggio deve avere da 1 a 255 caratteri e puo' contenere SOLO lettere, numeri e i caratteri speciali 'space' . _ - che non possono comparire come primo o ultimo carattere");

		Utente utenteMittente = entityManager.find(Utente.class,
				idUtenteMittente);

		Utente utenteDestinatario = entityManager.find(Utente.class,
				idUtenteDestinatario);

		Random random = new Random();
		Richiesta richiesta = null;
		Richiesta richiestaEsistenteConQuellId = null;
		int idRichiesta;
		do {
			idRichiesta = 1 + random.nextInt(1000000);
			richiestaEsistenteConQuellId = entityManager.find(Richiesta.class,
					idRichiesta);
			if (richiestaEsistenteConQuellId == null) { // se non esiste gia' 
														// una

				// richiesta con
				// quell'id
				richiesta = new Richiesta(idRichiesta, oggettoRichiesta,
						utenteMittente, utenteDestinatario);

			}
		} while (richiestaEsistenteConQuellId != null);
		entityManager.persist(richiesta);
		return idRichiesta;
	}

	public void valutaRichiesta(int idRichiesta) throws RichiestaException {

		Richiesta richiesta = entityManager.find(Richiesta.class, idRichiesta);
		if (richiesta.getHaRicevutoFeedback())
			throw new RichiestaException("Feedback già' rilasciato");

		richiesta.setHaRicevutoFeedback(true);

		entityManager.merge(richiesta);

	}

	public void rispondiARichiesta(int idRichiesta, int idUtente,
			String CorpoMessaggio) throws RichiestaException {

		if (CorpoMessaggio.length() > 65535)
			throw new RichiestaException(
					"Il corpo del messaggio eccede la dimensione massima consentita di 65535 caratteri");
		if (!ControlloreStringhe.descrizioneOk(CorpoMessaggio))
			throw new RichiestaException(
					"Il corpo del messaggio deve essere compresa tra 1 e 65535 caratteri e NON puo' contenere i caratteri speciali '<' e '>'");

		Richiesta richiesta = entityManager.find(Richiesta.class, idRichiesta);
		Utente utente = entityManager.find(Utente.class, idUtente);
		Messaggio messaggio = null;
		Messaggio messaggioEsistenteConQuellId = null;
		Random random = new Random();

		do {
			int idMessaggio = 1 + random.nextInt(1000000);
			messaggioEsistenteConQuellId = entityManager.find(Messaggio.class,
					idMessaggio);
			if (messaggioEsistenteConQuellId == null) { // se non esiste gia' 
														// una
														// richiesta con
														// quell'id
				messaggio = new Messaggio(idMessaggio, CorpoMessaggio,
						richiesta, utente, richiesta.getListaMessaggi().size());
				richiesta.addMessaggio(messaggio);
			}
		} while (messaggioEsistenteConQuellId != null);
		entityManager.persist(messaggio);
		entityManager.merge(richiesta);

	}

	public List<Richiesta> getListaRichiestaInviateDaUtente(int idUtente) {

		Query query = entityManager
				.createQuery("FROM Richiesta a WHERE utenteMittente_idUtente=?1");

		query.setParameter(1, idUtente);

		List<Richiesta> listaRichiesteInviate = query.getResultList();

		return listaRichiesteInviate;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see control.ddd#getListaRichiestaRicevuteDaUtente(java.lang.String)
	 */
	public List<Richiesta> getListaRichiestaRicevuteDaUtente(int idUtente) {

		Query query = entityManager
				.createQuery("FROM Richiesta a WHERE utenteDestinatario_idUtente=?1");

		query.setParameter(1, idUtente);

		List<Richiesta> listaRichiesteInviate = query.getResultList();
		return listaRichiesteInviate;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see control.ddd#getListaMessaggiDiRichiesta(int)
	 */
	public List<Messaggio> getListaMessaggiDiRichiesta(int idRichiesta) {

		List<Messaggio> ListaMessaggiDiRichiesta = (entityManager.find(
				Richiesta.class, idRichiesta)).getListaMessaggi();
		System.out.println(ListaMessaggiDiRichiesta.get(0).getCorpoMessaggio());
		System.out.println(ListaMessaggiDiRichiesta);

		return ListaMessaggiDiRichiesta;
	}

	// @Override
	/*
	 * (non-Javadoc)
	 * 
	 * @see control.ddd#getRichiesta(int)
	 */
	public Richiesta getRichiesta(int idRichiesta) {

		return (Richiesta) entityManager.find(Richiesta.class, idRichiesta);
	}

}
