package entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "Disponibilita")
public class Disponibilita implements Serializable {

	private int idDisponibilita;
	int disponibilitaLuned�Dalle;
	int disponibilitaLuned�Alle;
	int disponibilitaMarted�Dalle;
	int disponibilitaMarted�Alle;
	int disponibilitaMercoled�Dalle;
	int disponibilitaMercoled�Alle;
	int disponibilitaGioved�Dalle;
	int disponibilitaGioved�Alle;
	int disponibilitaVenerd�Dalle;
	int disponibilitaVenerd�Alle;
	int disponibilitaSabatoDalle;
	int disponibilitaSabatoAlle;
	int disponibilitaDomenicaDalle;
	int disponibilitaDomenicaAlle;

	private Abilita abilita;

	public Disponibilita() {
		super();
	}

	public Disponibilita(int id, int disponibilitaLuned�Dalle,
			int disponibilitaLuned�Alle, int disponibilitaMarted�Dalle,
			int disponibilitaMarted�Alle, int disponibilitaMercoled�Dalle,
			int disponibilitaMercoled�Alle, int disponibilitaGioved�Dalle,
			int disponibilitaGioved�Alle, int disponibilitaVenerd�Dalle,
			int disponibilitaVenerd�Alle, int disponibilitaSabatoDalle,
			int disponibilitaSabatoAlle, int disponibilitaDomenicaDalle,
			int disponibilitaDomenicaAlle, Abilita abilita) {
		super();
		setIdDisponibilita(id);
		setDisponibilitaLuned�Dalle(disponibilitaLuned�Dalle);
		setDisponibilitaLuned�Alle(disponibilitaLuned�Alle);
		setDisponibilitaMarted�Dalle(disponibilitaMarted�Dalle);
		setDisponibilitaMarted�Alle(disponibilitaMarted�Alle);
		setDisponibilitaMercoled�Dalle(disponibilitaMercoled�Dalle);
		setDisponibilitaMercoled�Alle(disponibilitaMercoled�Alle);
		setDisponibilitaGioved�Dalle(disponibilitaGioved�Dalle);
		setDisponibilitaGioved�Alle(disponibilitaGioved�Alle);
		setDisponibilitaVenerd�Dalle(disponibilitaVenerd�Dalle);
		setDisponibilitaVenerd�Alle(disponibilitaVenerd�Alle);
		setDisponibilitaSabatoDalle(disponibilitaSabatoDalle);
		setDisponibilitaSabatoAlle(disponibilitaSabatoAlle);
		setDisponibilitaDomenicaDalle(disponibilitaDomenicaDalle);
		setDisponibilitaDomenicaAlle(disponibilitaDomenicaAlle);
		setAbilita(abilita);

	}

	@Id
	@Column(name = "idDisponibilita", length = Integer.MAX_VALUE)
	public int getIdDisponibilita() {
		return this.idDisponibilita;
	}

	private void setIdDisponibilita(int id) {
		this.idDisponibilita = id;
	}

	@Column(name = "disponibilitaLuned�Dalle")
	public int getDisponibilitaLuned�Dalle() {
		return disponibilitaLuned�Dalle;
	}

	public void setDisponibilitaLuned�Dalle(int disponibilitaLuned�Dalle) {
		this.disponibilitaLuned�Dalle = disponibilitaLuned�Dalle;
	}

	@Column(name = "disponibilitaLuned�Alle")
	public int getDisponibilitaLuned�Alle() {
		return disponibilitaLuned�Alle;
	}

	public void setDisponibilitaLuned�Alle(int disponibilitaLuned�Alle) {
		this.disponibilitaLuned�Alle = disponibilitaLuned�Alle;
	}

	@Column(name = "disponibilitaMarted�Dalle")
	public int getDisponibilitaMarted�Dalle() {
		return disponibilitaMarted�Dalle;
	}

	public void setDisponibilitaMarted�Dalle(int disponibilitaMarted�Dalle) {
		this.disponibilitaMarted�Dalle = disponibilitaMarted�Dalle;
	}

	@Column(name = "disponibilitaMarted�Alle")
	public int getDisponibilitaMarted�Alle() {
		return disponibilitaMarted�Alle;
	}

	public void setDisponibilitaMarted�Alle(int disponibilitaMarted�Alle) {
		this.disponibilitaMarted�Alle = disponibilitaMarted�Alle;
	}

	@Column(name = "disponibilitaMercoled�Dalle")
	public int getDisponibilitaMercoled�Dalle() {
		return disponibilitaMercoled�Dalle;
	}

	public void setDisponibilitaMercoled�Dalle(int disponibilitaMercoled�Dalle) {
		this.disponibilitaMercoled�Dalle = disponibilitaMercoled�Dalle;
	}

	@Column(name = "disponibilitaMercoled�Alle")
	public int getDisponibilitaMercoled�Alle() {
		return disponibilitaMercoled�Alle;
	}

	public void setDisponibilitaMercoled�Alle(int disponibilitaMercoled�Alle) {
		this.disponibilitaMercoled�Alle = disponibilitaMercoled�Alle;
	}

	@Column(name = "disponibilitaGioved�Dalle")
	public int getDisponibilitaGioved�Dalle() {
		return disponibilitaGioved�Dalle;
	}

	public void setDisponibilitaGioved�Dalle(int disponibilitaGioved�Dalle) {
		this.disponibilitaGioved�Dalle = disponibilitaGioved�Dalle;
	}

	@Column(name = "disponibilitaGioved�Alle")
	public int getDisponibilitaGioved�Alle() {
		return disponibilitaGioved�Alle;
	}

	public void setDisponibilitaGioved�Alle(int disponibilitaGioved�Alle) {
		this.disponibilitaGioved�Alle = disponibilitaGioved�Alle;
	}

	@Column(name = "disponibilitaVenerd�Dalle")
	public int getDisponibilitaVenerd�Dalle() {
		return disponibilitaVenerd�Dalle;
	}

	public void setDisponibilitaVenerd�Dalle(int disponibilitaVenerd�Dalle) {
		this.disponibilitaVenerd�Dalle = disponibilitaVenerd�Dalle;
	}

	@Column(name = "disponibilitaVenerd�Alle")
	public int getDisponibilitaVenerd�Alle() {
		return disponibilitaVenerd�Alle;
	}

	public void setDisponibilitaVenerd�Alle(int disponibilitaVenerd�Alle) {
		this.disponibilitaVenerd�Alle = disponibilitaVenerd�Alle;
	}

	@Column(name = "disponibilitaSabatoDalle")
	public int getDisponibilitaSabatoDalle() {
		return disponibilitaSabatoDalle;
	}

	public void setDisponibilitaSabatoDalle(int disponibilitaSabatoDalle) {
		this.disponibilitaSabatoDalle = disponibilitaSabatoDalle;
	}

	@Column(name = "disponibilitaSabatoAlle")
	public int getDisponibilitaSabatoAlle() {
		return disponibilitaSabatoAlle;
	}

	public void setDisponibilitaSabatoAlle(int disponibilitaSabatoAlle) {
		this.disponibilitaSabatoAlle = disponibilitaSabatoAlle;
	}

	@Column(name = "disponibilitaDomenicaDalle")
	public int getDisponibilitaDomenicaDalle() {
		return disponibilitaDomenicaDalle;
	}

	public void setDisponibilitaDomenicaDalle(int disponibilitaDomenicaDalle) {
		this.disponibilitaDomenicaDalle = disponibilitaDomenicaDalle;
	}

	@Column(name = "disponibilitaDomenicaAlle")
	public int getDisponibilitaDomenicaAlle() {
		return disponibilitaDomenicaAlle;
	}

	public void setDisponibilitaDomenicaAlle(int disponibilitaDomenicaAlle) {
		this.disponibilitaDomenicaAlle = disponibilitaDomenicaAlle;
	}

	/*
	 * @JoinColumn(name = "abilita", referencedColumnName = "idAbilita")
	 * 
	 * @ManyToOne(fetch = FetchType.LAZY) public Abilita getAbilita() { return
	 * abilita; }
	 * 
	 * public void setAbilita(Abilita abilita) { this.abilita = abilita; }
	 */

	@ManyToOne(optional = false)
	@PrimaryKeyJoinColumn(name = "abilita", referencedColumnName = "idAbilita")
	public Abilita getAbilita() {
		return this.abilita;
	}

	public void setAbilita(Abilita abilita) {
		this.abilita = abilita;
	}

	public int getDisponibilita(String giorno, String stringa) {
		if (giorno.equals("Luned�") && stringa.equals("dalle")) {
			return getDisponibilitaLuned�Dalle();
		}
		if (giorno.equals("Luned�") && stringa.equals("alle")) {
			return getDisponibilitaLuned�Alle();
		}
		if (giorno.equals("Marted�") && stringa.equals("dalle")) {
			return getDisponibilitaMarted�Dalle();
		}
		if (giorno.equals("Marted�") && stringa.equals("alle")) {
			return getDisponibilitaMarted�Alle();
		}
		if (giorno.equals("Mercoled�") && stringa.equals("dalle")) {
			return getDisponibilitaMercoled�Dalle();
		}
		if (giorno.equals("Mercoled�") && stringa.equals("alle")) {
			return getDisponibilitaMercoled�Alle();
		}
		if (giorno.equals("Gioved�") && stringa.equals("dalle")) {
			return getDisponibilitaGioved�Dalle();
		}
		if (giorno.equals("Gioved�") && stringa.equals("alle")) {
			return getDisponibilitaGioved�Alle();
		}
		if (giorno.equals("Venerd�") && stringa.equals("dalle")) {
			return getDisponibilitaVenerd�Dalle();
		}
		if (giorno.equals("Venerd�") && stringa.equals("alle")) {
			return getDisponibilitaVenerd�Alle();
		}
		if (giorno.equals("Sabato") && stringa.equals("dalle")) {
			return getDisponibilitaSabatoDalle();
		}
		if (giorno.equals("Sabato") && stringa.equals("alle")) {
			return getDisponibilitaSabatoAlle();
		}
		if (giorno.equals("Domenica") && stringa.equals("dalle")) {
			return getDisponibilitaDomenicaDalle();
		}
		if (giorno.equals("Domenica") && stringa.equals("alle")) {
			return getDisponibilitaDomenicaAlle();
		}
		return -2;
	}
}