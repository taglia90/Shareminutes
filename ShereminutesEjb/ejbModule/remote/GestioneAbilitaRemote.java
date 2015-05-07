package remote;

import java.util.List;

import javax.ejb.Remote;

import entity.Abilita;
import exception.AbilitaException;

@Remote
public interface GestioneAbilitaRemote {

	public int creaAbilita(String nomeAbilita, String descrizioneAbilita,
			boolean isApprovata, byte[] foto, int minutiNecessari, int tariffa,
			int minuti, String cittaDoveOffreServizio) throws AbilitaException;

	public void modificaAbilita(int idAbilita, String nomeAbilita,
			String descrizioneAbilita, byte[] foto, int minutiNecessari,
			int tariffa, int minuti, String cittaDoveOffreServizio)
			throws AbilitaException;

	public void approvaAbilita(int idAbilita) throws AbilitaException;

	public void eliminaAbilita(int idAbilita) throws AbilitaException;

	public List<Abilita> getListaAbilita();

	public List<Abilita> getListaAbilitaDiUtente(int idUtente);

	public List<Abilita> getListaAbilitaDaApprovareDiUtente(int idUtente);

	public Abilita getAbilita(int idAbilita);

	public List<Abilita> getListaAbilitaDaApprovare();

	public void inserisciAbilitaInUtente(int idUtente, int idAbilita);

	public void svuotaAbilitaInUtente(int idUtente);

	public void eliminaAbilitaUtente(int idUtente, int idAbility);

	public byte[] getFotoAbilita(int idAbilita);

}
