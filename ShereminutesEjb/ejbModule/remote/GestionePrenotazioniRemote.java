package remote;

import java.util.Date;
import java.util.List;

import javax.ejb.Remote;

import entity.Abilita;
import exception.AbilitaException;

@Remote
public interface GestionePrenotazioniRemote {

	int nuovaPrenotazione(Date data, int disponibilitaDalle,
			int disponibilitaAlle, int idUtenteRichiedente, int idAbilita);

}
