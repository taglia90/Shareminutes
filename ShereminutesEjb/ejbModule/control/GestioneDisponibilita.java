package control;

import java.util.Random;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import entity.Abilita;
import entity.Disponibilita;
import remote.GestioneDisponibilitaRemote;

public @Stateless(name = "GestioneDisponibilita") class GestioneDisponibilita
		implements GestioneDisponibilitaRemote {
	@PersistenceContext(unitName = "shareminutes")
	private EntityManager entityManager;

	public int creaDisponibilita(int idAbilita, String stringaDisponibilita) {
		Abilita abilita = entityManager.find(Abilita.class, idAbilita);
		Random random = new Random();
		Disponibilita disponibilita = null;
		Disponibilita disponibilitaEsistenteConQuellId = null;
		int idDisponibilita;
		do {
			idDisponibilita = 1 + random.nextInt(1000000);
			disponibilitaEsistenteConQuellId = entityManager.find(
					Disponibilita.class, idDisponibilita);
			if (disponibilitaEsistenteConQuellId == null) { // se non esiste
															// gia'  una
				// disponibilita con quell'id
				disponibilita = new Disponibilita(idDisponibilita,
						stringaDisponibilita, abilita);
			}
		} while (disponibilitaEsistenteConQuellId != null);
		entityManager.persist(disponibilita);
		return idDisponibilita;

	}

	public void modificaDisponibilita(int idAbilita,
			String stringaDisponibilita) {

		Query query = entityManager
				.createQuery("FROM Disponibilita WHERE abilita_idAbilita=:idabilita");
		query.setParameter("idabilita", idAbilita);

		Disponibilita disponibilitaDaModificare = (Disponibilita) query
				.getSingleResult();
		Abilita abilita = entityManager.find(Abilita.class, idAbilita);

		/*disponibilitaDaModificare
				.setDisponibilitaLunedìDalle(disponibilitaLunedìDalle);
		disponibilitaDaModificare
				.setDisponibilitaLunedìAlle(disponibilitaLunedìAlle);
		disponibilitaDaModificare
				.setDisponibilitaMartedìDalle(disponibilitaMartedìDalle);
		disponibilitaDaModificare
				.setDisponibilitaMartedìAlle(disponibilitaMartedìAlle);
		disponibilitaDaModificare
				.setDisponibilitaMercoledìDalle(disponibilitaMercoledìDalle);
		disponibilitaDaModificare
				.setDisponibilitaMercoledìAlle(disponibilitaMercoledìAlle);
		disponibilitaDaModificare
				.setDisponibilitaGiovedìDalle(disponibilitaGiovedìDalle);
		disponibilitaDaModificare
				.setDisponibilitaGiovedìAlle(disponibilitaGiovedìAlle);
		disponibilitaDaModificare
				.setDisponibilitaVenerdìDalle(disponibilitaVenerdìDalle);
		disponibilitaDaModificare
				.setDisponibilitaVenerdìAlle(disponibilitaVenerdìAlle);
		disponibilitaDaModificare
				.setDisponibilitaSabatoDalle(disponibilitaSabatoDalle);
		disponibilitaDaModificare
				.setDisponibilitaSabatoAlle(disponibilitaSabatoAlle);
		disponibilitaDaModificare
				.setDisponibilitaDomenicaDalle(disponibilitaDomenicaDalle);
		disponibilitaDaModificare
				.setDisponibilitaDomenicaAlle(disponibilitaDomenicaAlle);*/
		disponibilitaDaModificare.setStringaDisponibilita(stringaDisponibilita);
		disponibilitaDaModificare.setAbilita(abilita);
		entityManager.merge(disponibilitaDaModificare);
	}

	public Disponibilita getIdDisponibilita(int idAbilita) {
		Query query = entityManager
				.createQuery("FROM Disponibilita WHERE abilita_idAbilita=:idabilita");
		query.setParameter("idabilita", idAbilita);

		return (Disponibilita) query.getSingleResult();
	}
}