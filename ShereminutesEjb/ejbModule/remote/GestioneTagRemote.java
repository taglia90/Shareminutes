package remote;

import java.util.Date;
import java.util.List;

import javax.ejb.Remote;

import entity.Abilita;
import entity.Tag;
import exception.TagException;

@Remote
public interface GestioneTagRemote {

	public int creaTag(String stringaTag, int idAbilita) throws TagException;

	public void modificaTag(int idTag, String stringaTag, int idAbilita)
			throws TagException;

	public void eliminaTag(int idTag) throws TagException;

	public void eliminaTuttiTagDiAbilita(int idAbilita);

	public List<Tag> getListaTagDiAbilita(int idAbilita);

	public List<Abilita> ricercaTag(String stringaDiRicerca, String citta,
			String disponibilita, Date data) throws TagException;

}
