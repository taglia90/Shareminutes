package remote;

import javax.ejb.Remote;

import entity.Disponibilita;

@Remote
public interface GestioneDisponibilitaRemote {

	/*int creaDisponibilita(int idAbilita, int disponibilitaLunedžDalle,
			int disponibilitaLunedžAlle, int disponibilitaMartedžDalle,
			int disponibilitaMartedžAlle, int disponibilitaMercoledžDalle,
			int disponibilitaMercoledžAlle, int disponibilitaGiovedžDalle,
			int disponibilitaGiovedžAlle, int disponibilitaVenerdžDalle,
			int disponibilitaVenerdžAlle, int disponibilitaSabatoDalle,
			int disponibilitaSabatoAlle, int disponibilitaDomenicaDalle,
			int disponibilitaDomenicaAlle);

	void modificaDisponibilita(int idAbilita, int disponibilitaLunedžDalle,
			int disponibilitaLunedžAlle, int disponibilitaMartedžDalle,
			int disponibilitaMartedžAlle, int disponibilitaMercoledžDalle,
			int disponibilitaMercoledžAlle, int disponibilitaGiovedžDalle,
			int disponibilitaGiovedžAlle, int disponibilitaVenerdžDalle,
			int disponibilitaVenerdžAlle, int disponibilitaSabatoDalle,
			int disponibilitaSabatoAlle, int disponibilitaDomenicaDalle,
			int disponibilitaDomenicaAlle);*/
	
	int creaDisponibilita(int idAbilita, String disponibilita);
	
	void modificaDisponibilita(int idAbilita, String disponibilita);

	Disponibilita getIdDisponibilita(int idAbilita);

}
