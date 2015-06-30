package control;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.context.ApplicationScoped;
import javax.ejb.Stateless;
import javax.jms.Session;
import javax.persistence.EntityManager;
import javax.persistence.NamedQuery;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hsqldb.Database;

import entity.Abilita;
import entity.Tag;
import entity.Utente;
import exception.TagException;
import exception.UtentiException;
import remote.GestioneTagRemote;
import util.ControlloreStringhe;

@SuppressWarnings("unchecked")
public @Stateless(name = "GestioneTag") class GestioneTag implements
		GestioneTagRemote {
	@PersistenceContext(unitName = "shareminutes")
	private EntityManager entityManager;

	public int creaTag(String stringaTag, int idAbilita) throws TagException {
		if (stringaTag.length() > 255)
			throw new TagException(
					"Il nome del tag eccede la dimensione massima consentita di 255 caratteri");
		if (!ControlloreStringhe.nomeOggettoOk(stringaTag))
			throw new TagException(
					"Il nome dell'attivita' deve avere da 1 a 255 caratteri e puo' contenere SOLO lettere, numeri e i caratteri speciali 'space' . _ - che non possono comparire come primo o ultimo carattere");

		Abilita abilita = entityManager.find(Abilita.class, idAbilita);
		Random random = new Random();
		Tag tag = null;
		Tag tagEsistenteConQuellId = null;
		int idTag;
		do {
			idTag = 1 + random.nextInt(1000000);
			tagEsistenteConQuellId = entityManager.find(Tag.class, idTag);
			if (tagEsistenteConQuellId == null) { // se non esiste gia'  un
													// tag con quell'id
				tag = new Tag(idTag, stringaTag, abilita);
			}
		} while (tagEsistenteConQuellId != null);
		entityManager.persist(tag);
		return idTag;

	}

	public void modificaTag(int idTag, String stringaTag, int idAbilita)
			throws TagException {
		if (stringaTag.length() > 255)
			throw new TagException(
					"Il nome del tag eccede la dimensione massima consentita di 255 caratteri");
		if (!ControlloreStringhe.nomeOggettoOk(stringaTag))
			throw new TagException(
					"Il nome del tag deve avere da 1 a 255 caratteri e puo' contenere SOLO lettere, numeri e i caratteri speciali 'space' . _ - che non possono comparire come primo o ultimo carattere");

		Tag tagDaModificare = entityManager.find(Tag.class, idTag);
		Abilita abilita = entityManager.find(Abilita.class, idAbilita);

		tagDaModificare.setStringaTag(stringaTag);
		tagDaModificare.setAbilita(abilita);
		entityManager.merge(tagDaModificare);

	}

	public void eliminaTag(int idTag) throws TagException {

		Tag tagDaEliminare = entityManager.find(Tag.class, idTag);
		if (tagDaEliminare == null)
			throw new TagException("Il tag non esiste");

		entityManager.remove(tagDaEliminare);
	}

	public void eliminaTuttiTagDiAbilita(int idAbilita) {
		List<Tag> listaTag = getListaTagDiAbilita(idAbilita);

		for (int i = 0; i < listaTag.size(); i++) {
			Tag tag = listaTag.get(i);
			try {
				eliminaTag(tag.getIdTag());
			} catch (TagException e) {
				e.printStackTrace();
			}
		}
	}

	public List<Tag> getListaTagDiAbilita(int idAbilita) {
		Query query = entityManager
				.createQuery("FROM Abilita WHERE idAbilita=:idA");
		query.setParameter("idA", idAbilita);
		Abilita abilita = (Abilita) query.getSingleResult();
		if (abilita == null)
			return null;

		query = entityManager.createQuery("FROM Tag WHERE abilita=:ab");
		query.setParameter("ab", abilita);
		List<Tag> listaTag = (List<Tag>) query.getResultList();
		if (listaTag.isEmpty())
			return null;
		return listaTag;
	}

	public Abilita getAbilitaDaTag(int idTag) {
		Tag tag = entityManager.find(Tag.class, idTag);
		if (tag == null)
			return null;
		return tag.getAbilita();
	}

	// @ApplicationScoped
	// @NamedQuery(name="ricercaTag",
	// query="FROM entity.Abilita WHERE idAbilita IN (FROM entity.Tag WHERE stringaTag LIKE '%software%') AND idAbilita IN (FROM entity.Tag WHERE stringaTag LIKE '%sinapps%') AND idAbilita IN (FROM entity.Tag t3 WHERE stringaTag LIKE '%apps%')	AND idAbilita IN (FROM entity.Abilita WHERE cittaDoveOffreServizio='Monza') AND idAbilita IN (FROM entity.Abilita WHERE disponibilita LIKE '%DO0%') AND idAbilita NOT IN (FROM entity.Abilita WHERE idAbilita IN (FROM entity.Prenotazione WHERE dataPrenotazione='2015-05-30') AND idAbilita IN (FROM entity.Prenotazione WHERE orarioPrenotato LIKE '%DO9%')) GROUP BY idAbilita")

	public List<Abilita> ricercaTag(String stringaDiRicerca, String citta,
			String disponibilita, Date data) throws TagException {
		if (stringaDiRicerca.length() > 255 || citta.length() > 255)
			throw new TagException(
					"La ricerca eccede la dimensione massima consentita di 255 caratteri");
		if (!ControlloreStringhe.nomeOggettoOk(stringaDiRicerca))
			throw new TagException(
					"La ricerca deve avere da 1 a 255 caratteri e puo' contenere SOLO lettere, numeri e i caratteri speciali 'space' . _ - che non possono comparire come primo o ultimo carattere");

		String[] stringaArrayTag = convertStringToArray(stringaDiRicerca);
		String where = "";// = "%' and stringaTag like '%";
		// stringaDiRicerca.replaceAll(" ", sost);

		// String stringaFinale = string.Replace(stringaDiRicerca, " ", sost);

		// Query queryOLD =
		// entityManager.createQuery("FROM Tag WHERE stringaTag LIKE ?1");

		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("SELECT a FROM entity.Abilita AS a WHERE ");// idAbilita
																			// IN
																			// (SELECT
																			// t0.abilita
																			// FROM
																			// entity.Tag
																			// t0
																			// WHERE
																			// stringaTag
																			// LIKE
																			// '%software%')");

		for (int i = 0; i < stringaArrayTag.length && i < 3; i++) {

			if (i != 0) {
				stringBuilder.append(" AND ");
			}
			stringBuilder.append(" idAbilita IN (SELECT t" + i
					+ ".abilita FROM entity.Tag t" + i
					+ " WHERE stringaTag LIKE '%" + stringaArrayTag[i] + "%')");// Perchè
			// gli
			// array
			// partono
			// a
			// contare
			// da
			// 0.

		}

		// stringBuilder.append(" AND idAbilita IN (SELECT t1.abilita FROM entity.Tag t1 WHERE stringaTag LIKE '%sinapps%')");
		// stringBuilder.append(" AND idAbilita IN (SELECT t2.abilita FROM entity.Tag t2 WHERE stringaTag LIKE '%apps%')");
		stringBuilder
				.append(" AND idAbilita IN (SELECT a1.idAbilita FROM entity.Abilita a1 WHERE cittaDoveOffreServizio = :citta)");
		stringBuilder
				.append(" AND idAbilita IN (SELECT a2.idAbilita FROM entity.Abilita a2 WHERE disponibilita LIKE :disp)");
		stringBuilder.append(" AND idAbilita NOT IN ");
		stringBuilder
				.append(" (SELECT a3.idAbilita FROM entity.Abilita a3 WHERE idAbilita IN (SELECT p0.abilita FROM entity.Prenotazione p0 WHERE dataPrenotazione = :data)");
		stringBuilder
				.append(" AND idAbilita IN (SELECT p1.abilita FROM entity.Prenotazione p1 WHERE orarioPrenotato LIKE :orario)) ");
		stringBuilder.append(" GROUP BY idAbilita");

		Query query = entityManager.createQuery(stringBuilder.toString());

		// query.setParameter(1, "%" + stringaDiRicerca + "%");
		// query.setParameter("where", where);
		query.setParameter("citta", citta);
		query.setParameter("disp", "%" + disponibilita + "%");
		if (data != null) {
			query.setParameter("data", data);// Nel formato '2015-05-30'
		} else {
			query.setParameter("data", "");
		}
		query.setParameter("orario", "%" + disponibilita + "%");

		List<Abilita> listaAbilita = query.getResultList();
		if (listaAbilita.isEmpty())
			listaAbilita = new ArrayList<Abilita>();

		/*
		 * List<Tag> listaTag = query.getResultList(); if (listaTag.isEmpty())
		 * listaTag = new ArrayList<Tag>();
		 * 
		 * List<Abilita> listaAbilita = new ArrayList<Abilita>(); Abilita
		 * singolaAbilita; for (int i = 0; i < listaTag.size(); i++) {
		 * singolaAbilita = listaTag.get(i).getAbilita(); if
		 * (!listaAbilita.contains(singolaAbilita)) {
		 * listaAbilita.add(singolaAbilita); } }
		 */

		return listaAbilita;// results;
	}

	/*
	 * public List<Tag> getListaTagDiUtente(int idUtente) { Utente user =
	 * entityManager.find(Utente.class, idUtente); List<Abilita>
	 * listaAbilitaUtente = user.getAbilita(); List<Abilita>
	 * listaAbilitaApprovate = new ArrayList<Abilita>(); if (user.getAbilita()
	 * != null && user.getAbilita().size() > 0) { int i; for (i = 0; i <
	 * listaAbilitaUtente.size(); i++) { if
	 * (listaAbilitaUtente.get(i).isApproved()) {
	 * listaAbilitaApprovate.add(listaAbilitaUtente.get(i)); } } } return
	 * listaAbilitaApprovate;
	 * 
	 * }
	 */

	public Tag getTag(int idTag) {
		return (Tag) entityManager.find(Tag.class, idTag);
	}

	public static String strSeparator = " ";

	public static String convertArrayToString(String[] array) {
		String str = "";
		if (array != null) {
			for (int i = 0; i < array.length; i++) {
				str = str + array[i];
				// Do not append comma at the end of last element
				if (i < array.length - 1) {
					str = str + strSeparator;
				}
			}
		}
		return str;
	}

	public static String[] convertStringToArray(String str) {
		String[] arr = str.split(strSeparator);
		return arr;
	}
}
