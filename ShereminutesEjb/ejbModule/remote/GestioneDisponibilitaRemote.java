package remote;

import javax.ejb.Remote;

import entity.Disponibilita;

@Remote
public interface GestioneDisponibilitaRemote {

	/*int creaDisponibilita(int idAbilita, int disponibilitaLuned�Dalle,
			int disponibilitaLuned�Alle, int disponibilitaMarted�Dalle,
			int disponibilitaMarted�Alle, int disponibilitaMercoled�Dalle,
			int disponibilitaMercoled�Alle, int disponibilitaGioved�Dalle,
			int disponibilitaGioved�Alle, int disponibilitaVenerd�Dalle,
			int disponibilitaVenerd�Alle, int disponibilitaSabatoDalle,
			int disponibilitaSabatoAlle, int disponibilitaDomenicaDalle,
			int disponibilitaDomenicaAlle);

	void modificaDisponibilita(int idAbilita, int disponibilitaLuned�Dalle,
			int disponibilitaLuned�Alle, int disponibilitaMarted�Dalle,
			int disponibilitaMarted�Alle, int disponibilitaMercoled�Dalle,
			int disponibilitaMercoled�Alle, int disponibilitaGioved�Dalle,
			int disponibilitaGioved�Alle, int disponibilitaVenerd�Dalle,
			int disponibilitaVenerd�Alle, int disponibilitaSabatoDalle,
			int disponibilitaSabatoAlle, int disponibilitaDomenicaDalle,
			int disponibilitaDomenicaAlle);*/
	
	int creaDisponibilita(int idAbilita, String disponibilita);
	
	void modificaDisponibilita(int idAbilita, String disponibilita);

	Disponibilita getIdDisponibilita(int idAbilita);

}
