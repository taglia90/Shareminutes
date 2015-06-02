package control;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import entity.Abilita;
import entity.Prenotazione;
import entity.Richiesta;
import entity.Tag;
import entity.Utente;
import exception.AbilitaException;
import exception.PrenotazioneException;
import exception.RichiestaException;
import exception.TagException;
import remote.GestionePrenotazioniRemote;
import util.ControlloreStringhe;

@SuppressWarnings("unchecked")
public @Stateless(name = "GestionePrenotazioni") class GestionePrenotazioni
		implements GestionePrenotazioniRemote {
	@PersistenceContext(unitName = "shareminutes")
	private EntityManager entityManager;

	public int nuovaPrenotazione(Date data, String orarioPrenotato,
			int idUtenteBuyer, int idUtenteSeller, int idAbilita) {

		Random random = new Random();
		Prenotazione prenotazione = null;
		Prenotazione prenotazioneEsistenteConQuellId = null;
		int idPrenotazione;
		do {
			idPrenotazione = 1 + random.nextInt(1000000);
			prenotazioneEsistenteConQuellId = entityManager.find(
					Prenotazione.class, idPrenotazione);
			Utente utenteBuyer = entityManager
					.find(Utente.class, idUtenteBuyer);
			Utente utenteSeller = entityManager.find(Utente.class,
					idUtenteSeller);
			Abilita abilita = entityManager.find(Abilita.class, idAbilita);
			if (prenotazioneEsistenteConQuellId == null) { // se non esiste
															// gia'  una
															// prenotazione con
															// quell'id
				LocalDateTime dataOra = LocalDateTime.now();
				prenotazione = new Prenotazione(idPrenotazione, data,
						orarioPrenotato, utenteBuyer, utenteSeller, abilita,
						false, false, false, false, false, dataOra);

			}
		} while (prenotazioneEsistenteConQuellId != null);
		entityManager.persist(prenotazione);
		return idPrenotazione;

	}

	public void eliminaPrenotazione(int idPrenotazione)
			throws PrenotazioneException {

		Prenotazione prenotazioneDaEliminare = entityManager.find(
				Prenotazione.class, idPrenotazione);
		if (prenotazioneDaEliminare == null)
			throw new PrenotazioneException("La prenotazione non esiste");

		entityManager.remove(prenotazioneDaEliminare);
	}

	public void eliminaTuttePrenotazioniDiAbilita(int idAbilita) {
		List<Prenotazione> listaPrenotazioni = getListaPrenotazioniDiAbilita(idAbilita);

		for (int i = 0; i < listaPrenotazioni.size(); i++) {
			Prenotazione prenotazione = listaPrenotazioni.get(i);
			try {
				eliminaPrenotazione(prenotazione.getIdPrenotazione());
			} catch (PrenotazioneException e) {
				e.printStackTrace();
			}
		}
	}

	public List<Prenotazione> getListaPrenotazioniDiAbilita(int idAbilita) {
		Abilita abilita = entityManager.find(Abilita.class, idAbilita);

		Query query = entityManager
				.createQuery("FROM Prenotazione WHERE abilita=:ab");
		query.setParameter("ab", abilita);
		List<Prenotazione> listaPrenotazioni = (List<Prenotazione>) query
				.getResultList();
		if (listaPrenotazioni.isEmpty())
			return null;
		return listaPrenotazioni;
	}

	public List<Prenotazione> getListaPrenotazioniInData(Date data,
			int idAbilita) {
		Abilita abilita = entityManager.find(Abilita.class, idAbilita);

		Query query = entityManager
				.createQuery("FROM Prenotazione WHERE abilita=:ab AND dataPrenotazione=:da");
		query.setParameter("ab", abilita);
		query.setParameter("da", data);
		List<Prenotazione> listaPrenotazioniInData = (List<Prenotazione>) query
				.getResultList();
		if (listaPrenotazioniInData.isEmpty())
			return null;
		return listaPrenotazioniInData;

	}

	public List<Prenotazione> getListaOrdiniAsABuyer(int idUtenteBuyer) {

		Query query = entityManager
				.createQuery("FROM Prenotazione WHERE utenteBuyer_idUtente=?1");

		query.setParameter(1, idUtenteBuyer);

		List<Prenotazione> listaRichiesteBuyer = query.getResultList();
		return listaRichiesteBuyer;
	}

	public List<Prenotazione> getListaOrdiniAsASeller(int idUtenteSeller) {

		Query query = entityManager
				.createQuery("FROM Prenotazione WHERE utenteSeller_idUtente=?1");

		query.setParameter(1, idUtenteSeller);

		List<Prenotazione> listaRichiesteInviate = query.getResultList();

		return listaRichiesteInviate;
	}

	public List<Prenotazione> getListaOrdiniAsABuyerDiUtenteSeller(int idUtenteBuyer, int idUtenteSeller) {

		Query query = entityManager
				.createQuery("FROM Prenotazione WHERE utenteBuyer_idUtente=?1 AND utenteSeller_idUtente=?2");

		query.setParameter(1, idUtenteBuyer);
		query.setParameter(2, idUtenteSeller);

		List<Prenotazione> listaRichiesteBuyer = query.getResultList();
		return listaRichiesteBuyer;
	}

	public List<Prenotazione> getListaOrdiniAsASellerDiUtenteBuyer(int idUtenteSeller, int idUtenteBuyer) {

		Query query = entityManager
				.createQuery("FROM Prenotazione WHERE utenteSeller_idUtente=?1 AND utenteBuyer_idUtente=?2");

		query.setParameter(1, idUtenteSeller);
		query.setParameter(2, idUtenteBuyer);

		List<Prenotazione> listaRichiesteInviate = query.getResultList();

		return listaRichiesteInviate;
	}
	
	public Prenotazione getPrenotazione(int idPrenotazione) {

		return (Prenotazione) entityManager.find(Prenotazione.class,
				idPrenotazione);
	}

	public void valutaPrenotazione(int idPrenotazione)
			throws PrenotazioneException {

		Prenotazione prenotazione = entityManager.find(Prenotazione.class,
				idPrenotazione);
		if (prenotazione.isFeedbackRilasciato())
			throw new PrenotazioneException("Feedback già' rilasciato");

		prenotazione.setFeedbackRilasciato(true);

		entityManager.merge(prenotazione);

	}

	public void setAccettataSeller(int idPrenotazione) {
		Prenotazione prenotazione = entityManager.find(Prenotazione.class,
				idPrenotazione);
		prenotazione.setAccettataSeller(true);

		entityManager.merge(prenotazione);
	}

	public void setConfermataBuyer(int idPrenotazione) {
		Prenotazione prenotazione = entityManager.find(Prenotazione.class,
				idPrenotazione);
		prenotazione.setConfermataBuyer(true);

		entityManager.merge(prenotazione);
	}

	public void setPagata(int idPrenotazione) {
		Prenotazione prenotazione = entityManager.find(Prenotazione.class,
				idPrenotazione);

		prenotazione.setPagata(true);
		entityManager.merge(prenotazione);
	}

	public void setRifiutata(int idPrenotazione) {
		Prenotazione prenotazione = entityManager.find(Prenotazione.class,
				idPrenotazione);
		prenotazione.setRifiutata(true);

		entityManager.merge(prenotazione);
	}

	public List<Prenotazione> getListaClienti(int idUtenteSeller) {

		Query query = entityManager
				.createQuery("FROM Prenotazione WHERE utenteSeller_idUtente=?1 GROUP BY utenteBuyer_idUtente");// SELECT
																												// *,
																												// count(*)
																												// as
																												// numeroVendite
		query.setParameter(1, idUtenteSeller);

		// long count = (long) query.getSingleResult();
		List<Prenotazione> listaPrenotazioni = query.getResultList();
		for (Prenotazione prenotazione : listaPrenotazioni) {
			Long numeroVendite = getNumeroVendite(prenotazione.getUtenteBuyer().getIdUtente(), idUtenteSeller);
			prenotazione.setNumeroVendite(numeroVendite);
		}

		return listaPrenotazioni;
	}

	public Long getNumeroVendite(int idUtenteBuyer, int idUtenteSeller) {
		Query query = entityManager
				.createQuery("SELECT count(idPrenotazione) as numeroVendite FROM Prenotazione WHERE utenteSeller_idUtente=?1 AND utenteBuyer_idUtente=?2");
		query.setParameter(1, idUtenteSeller);
		query.setParameter(2, idUtenteBuyer);

		// long count = (long) query.getSingleResult();
		Long numeroVendite = Long.parseLong(query.getSingleResult().toString());
		return numeroVendite;
	}

	public List<Prenotazione> getListaFornitori(int idUtenteBuyer) {
		Query query = entityManager
				.createQuery("FROM Prenotazione WHERE utenteBuyer_idUtente=?1 GROUP BY utenteSeller_idUtente");// SELECT
																												// *,
																												// count(*)
																												// as
																												// numeroAcquisti
		query.setParameter(1, idUtenteBuyer);

		// long count = (long) query.getSingleResult();
		List<Prenotazione> listaPrenotazioni = query.getResultList();
		for (Prenotazione prenotazione : listaPrenotazioni) {
			Long numeroAcquisti = getNumeroAcquisti(prenotazione.getUtenteSeller().getIdUtente(), idUtenteBuyer);
			prenotazione.setNumeroAcquisti(numeroAcquisti);
		}

		return listaPrenotazioni;
	}

	public Long getNumeroAcquisti(int idUtenteSeller, int idUtenteBuyer) {
		Query query = entityManager
				.createQuery("SELECT count(*) as numeroAcquisti FROM Prenotazione WHERE utenteBuyer_idUtente=?1 AND utenteSeller_idUtente=?2");
		query.setParameter(1, idUtenteBuyer);
		query.setParameter(2, idUtenteSeller);

		// long count = (long) query.getSingleResult();
		Long numeroAcquisti = Long
				.parseLong(query.getSingleResult().toString());
		return numeroAcquisti;
	}
}
