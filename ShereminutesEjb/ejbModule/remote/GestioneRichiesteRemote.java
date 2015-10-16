package remote;

import java.util.List;

import javax.ejb.Remote;

import entity.Messaggio;
import entity.Richiesta;
import exception.RichiestaException;

@Remote
public interface GestioneRichiesteRemote {

	public int creaRichiesta(String oggettoRichiesta, int idUtenteMittente,
			int idUtenteDestinatario) throws RichiestaException;

	public void valutaRichiesta(int idRichiesta) throws RichiestaException;

	public void rispondiARichiesta(int idRichiesta, int idUtente,
			String CorpoMessaggio) throws RichiestaException;

	public List<Richiesta> getListaRichiestaInviateDaUtente(int idUtente);

	public List<Richiesta> getListaRichiestaRicevuteDaUtente(int idUtente);

	public List<Messaggio> getListaMessaggiDiRichiesta(int idRichiesta);

	public Richiesta getRichiesta(int idRichiesta);

	public boolean ciSonoMessaggiNonLettiDiUtente(int idUtente);

	public void setRichiestaALetta(int idRichiesta);

}
