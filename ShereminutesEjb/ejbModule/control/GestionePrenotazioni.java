package control;

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
import entity.Utente;
import exception.AbilitaException;
import remote.GestionePrenotazioniRemote;
import util.ControlloreStringhe;

@SuppressWarnings("unchecked")
public @Stateless(name = "GestionePrenotazioni") class GestionePrenotazioni
		implements GestionePrenotazioniRemote {
	@PersistenceContext(unitName = "shareminutes")
	private EntityManager entityManager;

	public int nuovaPrenotazione(Date data, int disponibilitaDalle,
			int disponibilitaAlle, int idUtenteRichiedente, int idAbilita) {

		Random random = new Random();
		Prenotazione prenotazione = null;
		Prenotazione prenotazioneEsistenteConQuellId = null;
		int idPrenotazione;
		do {
			idPrenotazione = 1 + random.nextInt(1000000);
			prenotazioneEsistenteConQuellId = entityManager.find(
					Prenotazione.class, idPrenotazione);
			Utente utenteRichiedente = entityManager.find(Utente.class,
					idUtenteRichiedente);
			Abilita abilita = entityManager.find(Abilita.class, idAbilita);
			if (prenotazioneEsistenteConQuellId == null) { // se non esiste
															// gia'  una
															// prenotazione con
															// quell'id

				prenotazione = new Prenotazione(idPrenotazione, data,
						disponibilitaDalle, disponibilitaAlle, false, false,
						utenteRichiedente, abilita);

			}
		} while (prenotazioneEsistenteConQuellId != null);
		entityManager.persist(prenotazione);
		return idPrenotazione;

	}
}
