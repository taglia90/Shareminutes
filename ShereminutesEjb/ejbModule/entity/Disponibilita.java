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
	int disponibilitaLunedìDalle;
	int disponibilitaLunedìAlle;
	int disponibilitaMartedìDalle;
	int disponibilitaMartedìAlle;
	int disponibilitaMercoledìDalle;
	int disponibilitaMercoledìAlle;
	int disponibilitaGiovedìDalle;
	int disponibilitaGiovedìAlle;
	int disponibilitaVenerdìDalle;
	int disponibilitaVenerdìAlle;
	int disponibilitaSabatoDalle;
	int disponibilitaSabatoAlle;
	int disponibilitaDomenicaDalle;
	int disponibilitaDomenicaAlle;

	private Abilita abilita;

	public Disponibilita() {
		super();
	}

	public Disponibilita(int id, int disponibilitaLunedìDalle,
			int disponibilitaLunedìAlle, int disponibilitaMartedìDalle,
			int disponibilitaMartedìAlle, int disponibilitaMercoledìDalle,
			int disponibilitaMercoledìAlle, int disponibilitaGiovedìDalle,
			int disponibilitaGiovedìAlle, int disponibilitaVenerdìDalle,
			int disponibilitaVenerdìAlle, int disponibilitaSabatoDalle,
			int disponibilitaSabatoAlle, int disponibilitaDomenicaDalle,
			int disponibilitaDomenicaAlle, Abilita abilita) {
		super();
		setIdDisponibilita(id);
		setDisponibilitaLunedìDalle(disponibilitaLunedìDalle);
		setDisponibilitaLunedìAlle(disponibilitaLunedìAlle);
		setDisponibilitaMartedìDalle(disponibilitaMartedìDalle);
		setDisponibilitaMartedìAlle(disponibilitaMartedìAlle);
		setDisponibilitaMercoledìDalle(disponibilitaMercoledìDalle);
		setDisponibilitaMercoledìAlle(disponibilitaMercoledìAlle);
		setDisponibilitaGiovedìDalle(disponibilitaGiovedìDalle);
		setDisponibilitaGiovedìAlle(disponibilitaGiovedìAlle);
		setDisponibilitaVenerdìDalle(disponibilitaVenerdìDalle);
		setDisponibilitaVenerdìAlle(disponibilitaVenerdìAlle);
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

	@Column(name = "disponibilitaLunedìDalle")
	public int getDisponibilitaLunedìDalle() {
		return disponibilitaLunedìDalle;
	}

	public void setDisponibilitaLunedìDalle(int disponibilitaLunedìDalle) {
		this.disponibilitaLunedìDalle = disponibilitaLunedìDalle;
	}

	@Column(name = "disponibilitaLunedìAlle")
	public int getDisponibilitaLunedìAlle() {
		return disponibilitaLunedìAlle;
	}

	public void setDisponibilitaLunedìAlle(int disponibilitaLunedìAlle) {
		this.disponibilitaLunedìAlle = disponibilitaLunedìAlle;
	}

	@Column(name = "disponibilitaMartedìDalle")
	public int getDisponibilitaMartedìDalle() {
		return disponibilitaMartedìDalle;
	}

	public void setDisponibilitaMartedìDalle(int disponibilitaMartedìDalle) {
		this.disponibilitaMartedìDalle = disponibilitaMartedìDalle;
	}

	@Column(name = "disponibilitaMartedìAlle")
	public int getDisponibilitaMartedìAlle() {
		return disponibilitaMartedìAlle;
	}

	public void setDisponibilitaMartedìAlle(int disponibilitaMartedìAlle) {
		this.disponibilitaMartedìAlle = disponibilitaMartedìAlle;
	}

	@Column(name = "disponibilitaMercoledìDalle")
	public int getDisponibilitaMercoledìDalle() {
		return disponibilitaMercoledìDalle;
	}

	public void setDisponibilitaMercoledìDalle(int disponibilitaMercoledìDalle) {
		this.disponibilitaMercoledìDalle = disponibilitaMercoledìDalle;
	}

	@Column(name = "disponibilitaMercoledìAlle")
	public int getDisponibilitaMercoledìAlle() {
		return disponibilitaMercoledìAlle;
	}

	public void setDisponibilitaMercoledìAlle(int disponibilitaMercoledìAlle) {
		this.disponibilitaMercoledìAlle = disponibilitaMercoledìAlle;
	}

	@Column(name = "disponibilitaGiovedìDalle")
	public int getDisponibilitaGiovedìDalle() {
		return disponibilitaGiovedìDalle;
	}

	public void setDisponibilitaGiovedìDalle(int disponibilitaGiovedìDalle) {
		this.disponibilitaGiovedìDalle = disponibilitaGiovedìDalle;
	}

	@Column(name = "disponibilitaGiovedìAlle")
	public int getDisponibilitaGiovedìAlle() {
		return disponibilitaGiovedìAlle;
	}

	public void setDisponibilitaGiovedìAlle(int disponibilitaGiovedìAlle) {
		this.disponibilitaGiovedìAlle = disponibilitaGiovedìAlle;
	}

	@Column(name = "disponibilitaVenerdìDalle")
	public int getDisponibilitaVenerdìDalle() {
		return disponibilitaVenerdìDalle;
	}

	public void setDisponibilitaVenerdìDalle(int disponibilitaVenerdìDalle) {
		this.disponibilitaVenerdìDalle = disponibilitaVenerdìDalle;
	}

	@Column(name = "disponibilitaVenerdìAlle")
	public int getDisponibilitaVenerdìAlle() {
		return disponibilitaVenerdìAlle;
	}

	public void setDisponibilitaVenerdìAlle(int disponibilitaVenerdìAlle) {
		this.disponibilitaVenerdìAlle = disponibilitaVenerdìAlle;
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
		if (giorno.equals("Lunedì") && stringa.equals("dalle")) {
			return getDisponibilitaLunedìDalle();
		}
		if (giorno.equals("Lunedì") && stringa.equals("alle")) {
			return getDisponibilitaLunedìAlle();
		}
		if (giorno.equals("Martedì") && stringa.equals("dalle")) {
			return getDisponibilitaMartedìDalle();
		}
		if (giorno.equals("Martedì") && stringa.equals("alle")) {
			return getDisponibilitaMartedìAlle();
		}
		if (giorno.equals("Mercoledì") && stringa.equals("dalle")) {
			return getDisponibilitaMercoledìDalle();
		}
		if (giorno.equals("Mercoledì") && stringa.equals("alle")) {
			return getDisponibilitaMercoledìAlle();
		}
		if (giorno.equals("Giovedì") && stringa.equals("dalle")) {
			return getDisponibilitaGiovedìDalle();
		}
		if (giorno.equals("Giovedì") && stringa.equals("alle")) {
			return getDisponibilitaGiovedìAlle();
		}
		if (giorno.equals("Venerdì") && stringa.equals("dalle")) {
			return getDisponibilitaVenerdìDalle();
		}
		if (giorno.equals("Venerdì") && stringa.equals("alle")) {
			return getDisponibilitaVenerdìAlle();
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