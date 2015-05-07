package remote;

import javax.ejb.Remote;

import entity.Disponibilita;

@Remote
public interface GestioneDisponibilitaRemote {

	int creaDisponibilita(int idAbilita, int disponibilitaLunedìDalle,
			int disponibilitaLunedìAlle, int disponibilitaMartedìDalle,
			int disponibilitaMartedìAlle, int disponibilitaMercoledìDalle,
			int disponibilitaMercoledìAlle, int disponibilitaGiovedìDalle,
			int disponibilitaGiovedìAlle, int disponibilitaVenerdìDalle,
			int disponibilitaVenerdìAlle, int disponibilitaSabatoDalle,
			int disponibilitaSabatoAlle, int disponibilitaDomenicaDalle,
			int disponibilitaDomenicaAlle);

	void modificaDisponibilita(int idAbilita, int disponibilitaLunedìDalle,
			int disponibilitaLunedìAlle, int disponibilitaMartedìDalle,
			int disponibilitaMartedìAlle, int disponibilitaMercoledìDalle,
			int disponibilitaMercoledìAlle, int disponibilitaGiovedìDalle,
			int disponibilitaGiovedìAlle, int disponibilitaVenerdìDalle,
			int disponibilitaVenerdìAlle, int disponibilitaSabatoDalle,
			int disponibilitaSabatoAlle, int disponibilitaDomenicaDalle,
			int disponibilitaDomenicaAlle);

	Disponibilita getIdDisponibilita(int idAbilita);

}
