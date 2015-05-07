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

	public int creaDisponibilita(int idAbilita, int disponibilitaLuned�Dalle,
			int disponibilitaLuned�Alle, int disponibilitaMarted�Dalle,
			int disponibilitaMarted�Alle, int disponibilitaMercoled�Dalle,
			int disponibilitaMercoled�Alle, int disponibilitaGioved�Dalle,
			int disponibilitaGioved�Alle, int disponibilitaVenerd�Dalle,
			int disponibilitaVenerd�Alle, int disponibilitaSabatoDalle,
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
															// gia'� una
				// disponibilita con quell'id
				disponibilita = new Disponibilita(idDisponibilita,
						disponibilitaLuned�Dalle, disponibilitaLuned�Alle,
						disponibilitaMarted�Dalle, disponibilitaMarted�Alle,
						disponibilitaMercoled�Dalle,
						disponibilitaMercoled�Alle, disponibilitaGioved�Dalle,
						disponibilitaGioved�Alle, disponibilitaVenerd�Dalle,
						disponibilitaVenerd�Alle, disponibilitaSabatoDalle,
						disponibilitaSabatoAlle, disponibilitaDomenicaDalle,
						disponibilitaDomenicaAlle, abilita);
			}
		} while (disponibilitaEsistenteConQuellId != null);
		entityManager.persist(disponibilita);
		return idDisponibilita;

	}

	public void modificaDisponibilita(int idAbilita,
			int disponibilitaLuned�Dalle, int disponibilitaLuned�Alle,
			int disponibilitaMarted�Dalle, int disponibilitaMarted�Alle,
			int disponibilitaMercoled�Dalle, int disponibilitaMercoled�Alle,
			int disponibilitaGioved�Dalle, int disponibilitaGioved�Alle,
			int disponibilitaVenerd�Dalle, int disponibilitaVenerd�Alle,
			int disponibilitaSabatoDalle, int disponibilitaSabatoAlle,
			int disponibilitaDomenicaDalle, int disponibilitaDomenicaAlle) {

		Query query = entityManager
				.createQuery("FROM Disponibilita WHERE abilita_idAbilita=:idabilita");
		query.setParameter("idabilita", idAbilita);

		Disponibilita disponibilitaDaModificare = (Disponibilita) query
				.getSingleResult();
		Abilita abilita = entityManager.find(Abilita.class, idAbilita);

		disponibilitaDaModificare
				.setDisponibilitaLuned�Dalle(disponibilitaLuned�Dalle);
		disponibilitaDaModificare
				.setDisponibilitaLuned�Alle(disponibilitaLuned�Alle);
		disponibilitaDaModificare
				.setDisponibilitaMarted�Dalle(disponibilitaMarted�Dalle);
		disponibilitaDaModificare
				.setDisponibilitaMarted�Alle(disponibilitaMarted�Alle);
		disponibilitaDaModificare
				.setDisponibilitaMercoled�Dalle(disponibilitaMercoled�Dalle);
		disponibilitaDaModificare
				.setDisponibilitaMercoled�Alle(disponibilitaMercoled�Alle);
		disponibilitaDaModificare
				.setDisponibilitaGioved�Dalle(disponibilitaGioved�Dalle);
		disponibilitaDaModificare
				.setDisponibilitaGioved�Alle(disponibilitaGioved�Alle);
		disponibilitaDaModificare
				.setDisponibilitaVenerd�Dalle(disponibilitaVenerd�Dalle);
		disponibilitaDaModificare
				.setDisponibilitaVenerd�Alle(disponibilitaVenerd�Alle);
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