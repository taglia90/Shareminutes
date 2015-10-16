package control;

import java.util.List;
import java.util.Random;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import remote.GestioneFeedbackRemote;

import entity.Feedback;
import entity.Utente;
import exception.FeedbackException;
import util.ControlloreStringhe;

@SuppressWarnings("unchecked")
public @Stateless(name = "GestioneFeedback") class GestioneFeedback implements
		GestioneFeedbackRemote {
	@PersistenceContext(unitName = "shareminutes")
	private EntityManager entityManager;

	// @Override
	public void creaFeedback(int votoSintetico, String votoEsteso,
			int idUtenteRicevente, int idUtenteGiudicante)
			throws FeedbackException {
		if (votoSintetico > 5 || votoSintetico < 1)
			throw new FeedbackException("Il voto dev'essere tra 1 e 5.");

		if (votoEsteso.length() > 65535)
			throw new FeedbackException(
					"La descrizione eccede la dimensione massima consentita di 65535 caratteri");
		if (!ControlloreStringhe.descrizioneOk(votoEsteso))
			throw new FeedbackException(
					"La descrizione deve essere compresa tra 1 e 65535 caratteri e NON puo' contenere i caratteri speciali '<' e '>'");

		Utente utenteRicevente = entityManager.find(Utente.class,
				idUtenteRicevente);

		Utente utenteGiudicante = entityManager.find(Utente.class,
				idUtenteGiudicante);

		Random random = new Random();
		Feedback feedback = null;
		Feedback feedbackEsistenteConQuellId = null;
		do {
			int idFeedback = 1 + random.nextInt(1000000);
			feedbackEsistenteConQuellId = entityManager.find(Feedback.class,
					idFeedback);
			if (feedbackEsistenteConQuellId == null) { // se non esiste gia'  un
														// feedback con quell'id
				feedback = new Feedback(idFeedback, votoSintetico, votoEsteso,
						utenteRicevente, utenteGiudicante);
			}
		} while (feedbackEsistenteConQuellId != null);
		entityManager.persist(feedback);
	}

	// @Override
	public List<Feedback> getListaFeedbackRicevutiDiUnUtente(int idUtente) {
		Query FeedbackUtente = entityManager
				.createQuery("FROM Feedback f WHERE utenteRicevente_idUtente=?1");
		FeedbackUtente.setParameter(1, idUtente);

		List<Feedback> listaFeedbackDiUnUtente = FeedbackUtente.getResultList();
		return listaFeedbackDiUnUtente;
	}

	public List<Feedback> getListaFeedbackCreatiDiUnUtente(int idUtente) {
		Query FeedbackUtente = entityManager
				.createQuery("FROM Feedback f WHERE utenteGiudicante_idUtente=?1");
		FeedbackUtente.setParameter(1, idUtente);
		List<Feedback> listaFeedbackDiUnUtente = FeedbackUtente.getResultList();
		return listaFeedbackDiUnUtente;
	}

	// @Override
	public Feedback getFeedback(int idFeedback) {
		return (Feedback) entityManager.find(Feedback.class, idFeedback);
	}

	public int aggiornaMediaFeedbackUtente(int idUtente) {
		List<Feedback> listaFeedback = getListaFeedbackRicevutiDiUnUtente(idUtente);
		int media = 0;
		int i = 0;
		for (i = 0; i < listaFeedback.size(); i++) {
			media += listaFeedback.get(i).getVotoSintetico();
		}
		if (i > 0) {
			media /= i;
			Utente u = entityManager.find(Utente.class, idUtente);
			u.setMediaFeedback(media);
			entityManager.merge(u);
			return media;
		}
		return 0;
	}
}
