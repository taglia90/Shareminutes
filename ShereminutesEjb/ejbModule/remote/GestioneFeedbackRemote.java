package remote;

import java.util.List;

import javax.ejb.Remote;

import entity.Feedback;
import exception.FeedbackException;

@Remote
public interface GestioneFeedbackRemote {

	public void creaFeedback(int votoSintetico, String votoEsteso,
			int idUtenteRicevente, int idUtenteGiudicante)
			throws FeedbackException;

	public List<Feedback> getListaFeedbackRicevutiDiUnUtente(int idUtente);

	public List<Feedback> getListaFeedbackCreatiDiUnUtente(int idUtente);

	public Feedback getFeedback(int idFeedback);
	
	public int aggiornaMediaFeedbackUtente(int idUtente);
}
