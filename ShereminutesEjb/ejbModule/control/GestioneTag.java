package control;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

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

	public List<Abilita> ricercaTag(String stringaDiRicerca)
			throws TagException {
		if (stringaDiRicerca.length() > 255)
			throw new TagException(
					"La ricerca eccede la dimensione massima consentita di 255 caratteri");
		if (!ControlloreStringhe.nomeOggettoOk(stringaDiRicerca))
			throw new TagException(
					"La ricerca deve avere da 1 a 255 caratteri e puo' contenere SOLO lettere, numeri e i caratteri speciali 'space' . _ - che non possono comparire come primo o ultimo carattere");

		String sost = "%' and corpo like '%";
		stringaDiRicerca.replaceAll(" ", sost);
		// String stringaFinale = string.Replace(stringaDiRicerca, " ", sost);

		Query query = entityManager
				.createQuery("FROM Tag WHERE stringaTag LIKE ?1");
		query.setParameter(1, "%" + stringaDiRicerca + "%");
		List<Tag> listaTag = query.getResultList();
		if (listaTag.isEmpty())
			listaTag = new ArrayList<Tag>();

		List<Abilita> listaAbilita = new ArrayList<Abilita>();
		Abilita singolaAbilita;
		for (int i = 0; i < listaTag.size(); i++) {
			singolaAbilita = listaTag.get(i).getAbilita();
			if (!listaAbilita.contains(singolaAbilita)) {
				listaAbilita.add(singolaAbilita);
			}
		}

		return listaAbilita;
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
