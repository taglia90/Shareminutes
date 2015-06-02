package remote;

import java.util.List;

import javax.ejb.Remote;

import entity.Abilita;
import entity.Follower;
import entity.Utente;
import exception.AmiciziaException;
import exception.UtentiException;

@Remote
public interface GestioneUtentiRemote {
	public List<Utente> getListaAbilitaUtente(Abilita abilita);

	public Utente getUtente(int idUtente);

	public byte[] getFotoProfilo(int idUtente);

	public List<Utente> getListaUtenti();

	public List<Utente> getListaUtenti(String qualsiasiStringa)
			throws UtentiException;

	public List<Utente> getListaAmici(int idUtente);

	public List<Utente> getListaFollowerDiUtente(int idUtente);
	
	public List<Follower> getListaFollower(int idUtente);
	
	public List<Follower> getListaFollowerPreferiti(int idUtente);

	public List<Utente> getListaAmiciInSospeso(int idUtente);

	public void creaRichiestaAmicizia(int idUtente1, int idUtente2)
			throws AmiciziaException;

	public void accettaAmicizia(int idUtente1, int idUtente2)
			throws AmiciziaException;

	public void eliminaAmicizia(int idUtente1, int idUtente2)
			throws AmiciziaException;

	public List<Utente> getListaUtentiConAbilita(int idAbilita);

	// public Utente getUtenteConAbilita(int idAbilita);

	public void modificaProfilo(int idUtente, String nome, String cognome,
			String paese, String cittaAttuale, String cap, String sesso,
			String eta, String posizioneLavorativa, String headline,
			String biografia, byte[] fotoProfilo) throws UtentiException;

	public void salvaEmailPayPal(int idUtente, String emailPayPal)
			throws UtentiException;

	public void modificaPassword(int idUtente, String vecchiaPwd,
			String nuovaPwd, String confermaPwd) throws UtentiException;

	public int aggiungiFollower(int idUtente, int idUtenteFollower)
			throws AmiciziaException;

	public void setPreferito(int idFollower);
	
	public void rimuoviPreferito(int idFollower);
	
	public void eliminaFollower(int idFollower);
	
}
