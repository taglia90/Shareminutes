package remote;

import java.util.Date;
import java.util.List;

import javax.ejb.Remote;

import entity.Prenotazione;
import entity.Utente;
import exception.PrenotazioneException;

@Remote
public interface GestionePrenotazioniRemote {

	public int nuovaPrenotazione(Date data, String orarioPrenotato,
			int idUtenteBuyer, int idUtenteSeller, int idAbilita);

	public List<Prenotazione> getListaOrdiniAsABuyer(int idUtenteBuyer);

	public List<Prenotazione> getListaOrdiniAsASeller(int idUtenteSeller);

	public List<Prenotazione> getListaOrdiniAsABuyerDiUtenteSeller(
			int idUtenteBuyer, int idUtenteSeller);

	public List<Prenotazione> getListaOrdiniAsASellerDiUtenteBuyer(
			int idUtenteSeller, int idUtenteBuyer);

	public Prenotazione getPrenotazione(int idPrenotazione);

	public void valutaPrenotazione(int idPrenotazione, int idUtenteMittente)
			throws PrenotazioneException;

	public void setAccettataSeller(int idPrenotazione);

	public void setConfermataBuyer(int idPrenotazione);

	public void setPagata(int idPrenotazione);

	public void setRifiutata(int idPrenotazione);

	public List<Prenotazione> getListaPrenotazioniInData(Date data,
			int idAbilita);

	public List<Prenotazione> getListaClienti(int idSeller);

	public List<Prenotazione> getListaFornitori(int idBuyer);

	public List<Prenotazione> getListaClienti(int idSeller, int idBuyer);

	public List<Prenotazione> getListaFornitori(int idBuyer, int idSeller);

	public boolean ciSonoOrdiniNonLettiDiUtente(int idUtente);
}
