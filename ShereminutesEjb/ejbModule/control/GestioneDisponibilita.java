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

	public int creaDisponibilita(int idAbilita, int disponibilitaLunedžDalle,
			int disponibilitaLunedžAlle, int disponibilitaMartedžDalle,
			int disponibilitaMartedžAlle, int disponibilitaMercoledžDalle,
			int disponibilitaMercoledžAlle, int disponibilitaGiovedžDalle,
			int disponibilitaGiovedžAlle, int disponibilitaVenerdžDalle,
			int disponibilitaVenerdžAlle, int disponibilitaSabatoDalle,
			int disponibilitaSabatoAlle, int disponibilitaDomenicaDalle,
			int disponibilitaDomenicaAlle) {
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
															// gia'† una
				// disponibilita con quell'id
				disponibilita = new Disponibilita(idDisponibilita,
						disponibilitaLunedžDalle, disponibilitaLunedžAlle,
						disponibilitaMartedžDalle, disponibilitaMartedžAlle,
						disponibilitaMercoledžDalle,
						disponibilitaMercoledžAlle, disponibilitaGiovedžDalle,
						disponibilitaGiovedžAlle, disponibilitaVenerdžDalle,
						disponibilitaVenerdžAlle, disponibilitaSabatoDalle,
						disponibilitaSabatoAlle, disponibilitaDomenicaDalle,
						disponibilitaDomenicaAlle, abilita);
			}
		} while (disponibilitaEsistenteConQuellId != null);
		entityManager.persist(disponibilita);
		return idDisponibilita;

	}

	public void modificaDisponibilita(int idAbilita,
			int disponibilitaLunedžDalle, int disponibilitaLunedžAlle,
			int disponibilitaMartedžDalle, int disponibilitaMartedžAlle,
			int disponibilitaMercoledžDalle, int disponibilitaMercoledžAlle,
			int disponibilitaGiovedžDalle, int disponibilitaGiovedžAlle,
			int disponibilitaVenerdžDalle, int disponibilitaVenerdžAlle,
			int disponibilitaSabatoDalle, int disponibilitaSabatoAlle,
			int disponibilitaDomenicaDalle, int disponibilitaDomenicaAlle) {

		Query query = entityManager
				.createQuery("FROM Disponibilita WHERE abilita_idAbilita=:idabilita");
		query.setParameter("idabilita", idAbilita);

		Disponibilita disponibilitaDaModificare = (Disponibilita) query
				.getSingleResult();
		Abilita abilita = entityManager.find(Abilita.class, idAbilita);

		disponibilitaDaModificare
				.setDisponibilitaLunedžDalle(disponibilitaLunedžDalle);
		disponibilitaDaModificare
				.setDisponibilitaLunedžAlle(disponibilitaLunedžAlle);
		disponibilitaDaModificare
				.setDisponibilitaMartedžDalle(disponibilitaMartedžDalle);
		disponibilitaDaModificare
				.setDisponibilitaMartedžAlle(disponibilitaMartedžAlle);
		disponibilitaDaModificare
				.setDisponibilitaMercoledžDalle(disponibilitaMercoledžDalle);
		disponibilitaDaModificare
				.setDisponibilitaMercoledžAlle(disponibilitaMercoledžAlle);
		disponibilitaDaModificare
				.setDisponibilitaGiovedžDalle(disponibilitaGiovedžDalle);
		disponibilitaDaModificare
				.setDisponibilitaGiovedžAlle(disponibilitaGiovedžAlle);
		disponibilitaDaModificare
				.setDisponibilitaVenerdžDalle(disponibilitaVenerdžDalle);
		disponibilitaDaModificare
				.setDisponibilitaVenerdžAlle(disponibilitaVenerdžAlle);
		disponibilitaDaModificare
				.setDisponibilitaSabatoDalle(disponibilitaSabatoDalle);
		disponibilitaDaModificare
				.setDisponibilitaSabatoAlle(disponibilitaSabatoAlle);
		disponibilitaDaModificare
				.setDisponibilitaDomenicaDalle(disponibilitaDomenicaDalle);
		disponibilitaDaModificare
				.setDisponibilitaDomenicaAlle(disponibilitaDomenicaAlle);
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