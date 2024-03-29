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
	/*
	 * int disponibilitaLunedžDalle; int disponibilitaLunedžAlle; int
	 * disponibilitaMartedžDalle; int disponibilitaMartedžAlle; int
	 * disponibilitaMercoledžDalle; int disponibilitaMercoledžAlle; int
	 * disponibilitaGiovedžDalle; int disponibilitaGiovedžAlle; int
	 * disponibilitaVenerdžDalle; int disponibilitaVenerdžAlle; int
	 * disponibilitaSabatoDalle; int disponibilitaSabatoAlle; int
	 * disponibilitaDomenicaDalle; int disponibilitaDomenicaAlle;
	 */
	private String stringaDisponibilita;
	private Abilita abilita;

	public Disponibilita() {
		super();
	}

	public Disponibilita(int id, String stringaDisponibilita, Abilita abilita) {
		super();
		setIdDisponibilita(id);
		/*
		 * setDisponibilitaLunedžDalle(disponibilitaLunedžDalle);
		 * setDisponibilitaLunedžAlle(disponibilitaLunedžAlle);
		 * setDisponibilitaMartedžDalle(disponibilitaMartedžDalle);
		 * setDisponibilitaMartedžAlle(disponibilitaMartedžAlle);
		 * setDisponibilitaMercoledžDalle(disponibilitaMercoledžDalle);
		 * setDisponibilitaMercoledžAlle(disponibilitaMercoledžAlle);
		 * setDisponibilitaGiovedžDalle(disponibilitaGiovedžDalle);
		 * setDisponibilitaGiovedžAlle(disponibilitaGiovedžAlle);
		 * setDisponibilitaVenerdžDalle(disponibilitaVenerdžDalle);
		 * setDisponibilitaVenerdžAlle(disponibilitaVenerdžAlle);
		 * setDisponibilitaSabatoDalle(disponibilitaSabatoDalle);
		 * setDisponibilitaSabatoAlle(disponibilitaSabatoAlle);
		 * setDisponibilitaDomenicaDalle(disponibilitaDomenicaDalle);
		 * setDisponibilitaDomenicaAlle(disponibilitaDomenicaAlle);
		 */
		setStringaDisponibilita(stringaDisponibilita);
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

	@Column(name = "stringaDisponibilita", length = 10000)
	public String getStringaDisponibilita() {
		return this.stringaDisponibilita;
	}

	public void setStringaDisponibilita(String stringaDisponibilita) {
		this.stringaDisponibilita = stringaDisponibilita;
	}

	/*
	 * @Column(name = "disponibilitaLunedžDalle") public int
	 * getDisponibilitaLunedžDalle() { return disponibilitaLunedžDalle; }
	 * 
	 * public void setDisponibilitaLunedžDalle(int disponibilitaLunedžDalle) {
	 * this.disponibilitaLunedžDalle = disponibilitaLunedžDalle; }
	 * 
	 * @Column(name = "disponibilitaLunedžAlle") public int
	 * getDisponibilitaLunedžAlle() { return disponibilitaLunedžAlle; }
	 * 
	 * public void setDisponibilitaLunedžAlle(int disponibilitaLunedžAlle) {
	 * this.disponibilitaLunedžAlle = disponibilitaLunedžAlle; }
	 * 
	 * @Column(name = "disponibilitaMartedžDalle") public int
	 * getDisponibilitaMartedžDalle() { return disponibilitaMartedžDalle; }
	 * 
	 * public void setDisponibilitaMartedžDalle(int disponibilitaMartedžDalle) {
	 * this.disponibilitaMartedžDalle = disponibilitaMartedžDalle; }
	 * 
	 * @Column(name = "disponibilitaMartedžAlle") public int
	 * getDisponibilitaMartedžAlle() { return disponibilitaMartedžAlle; }
	 * 
	 * public void setDisponibilitaMartedžAlle(int disponibilitaMartedžAlle) {
	 * this.disponibilitaMartedžAlle = disponibilitaMartedžAlle; }
	 * 
	 * @Column(name = "disponibilitaMercoledžDalle") public int
	 * getDisponibilitaMercoledžDalle() { return disponibilitaMercoledžDalle; }
	 * 
	 * public void setDisponibilitaMercoledžDalle(int
	 * disponibilitaMercoledžDalle) { this.disponibilitaMercoledžDalle =
	 * disponibilitaMercoledžDalle; }
	 * 
	 * @Column(name = "disponibilitaMercoledžAlle") public int
	 * getDisponibilitaMercoledžAlle() { return disponibilitaMercoledžAlle; }
	 * 
	 * public void setDisponibilitaMercoledžAlle(int disponibilitaMercoledžAlle)
	 * { this.disponibilitaMercoledžAlle = disponibilitaMercoledžAlle; }
	 * 
	 * @Column(name = "disponibilitaGiovedžDalle") public int
	 * getDisponibilitaGiovedžDalle() { return disponibilitaGiovedžDalle; }
	 * 
	 * public void setDisponibilitaGiovedžDalle(int disponibilitaGiovedžDalle) {
	 * this.disponibilitaGiovedžDalle = disponibilitaGiovedžDalle; }
	 * 
	 * @Column(name = "disponibilitaGiovedžAlle") public int
	 * getDisponibilitaGiovedžAlle() { return disponibilitaGiovedžAlle; }
	 * 
	 * public void setDisponibilitaGiovedžAlle(int disponibilitaGiovedžAlle) {
	 * this.disponibilitaGiovedžAlle = disponibilitaGiovedžAlle; }
	 * 
	 * @Column(name = "disponibilitaVenerdžDalle") public int
	 * getDisponibilitaVenerdžDalle() { return disponibilitaVenerdžDalle; }
	 * 
	 * public void setDisponibilitaVenerdžDalle(int disponibilitaVenerdžDalle) {
	 * this.disponibilitaVenerdžDalle = disponibilitaVenerdžDalle; }
	 * 
	 * @Column(name = "disponibilitaVenerdžAlle") public int
	 * getDisponibilitaVenerdžAlle() { return disponibilitaVenerdžAlle; }
	 * 
	 * public void setDisponibilitaVenerdžAlle(int disponibilitaVenerdžAlle) {
	 * this.disponibilitaVenerdžAlle = disponibilitaVenerdžAlle; }
	 * 
	 * @Column(name = "disponibilitaSabatoDalle") public int
	 * getDisponibilitaSabatoDalle() { return disponibilitaSabatoDalle; }
	 * 
	 * public void setDisponibilitaSabatoDalle(int disponibilitaSabatoDalle) {
	 * this.disponibilitaSabatoDalle = disponibilitaSabatoDalle; }
	 * 
	 * @Column(name = "disponibilitaSabatoAlle") public int
	 * getDisponibilitaSabatoAlle() { return disponibilitaSabatoAlle; }
	 * 
	 * public void setDisponibilitaSabatoAlle(int disponibilitaSabatoAlle) {
	 * this.disponibilitaSabatoAlle = disponibilitaSabatoAlle; }
	 * 
	 * @Column(name = "disponibilitaDomenicaDalle") public int
	 * getDisponibilitaDomenicaDalle() { return disponibilitaDomenicaDalle; }
	 * 
	 * public void setDisponibilitaDomenicaDalle(int disponibilitaDomenicaDalle)
	 * { this.disponibilitaDomenicaDalle = disponibilitaDomenicaDalle; }
	 * 
	 * @Column(name = "disponibilitaDomenicaAlle") public int
	 * getDisponibilitaDomenicaAlle() { return disponibilitaDomenicaAlle; }
	 * 
	 * public void setDisponibilitaDomenicaAlle(int disponibilitaDomenicaAlle) {
	 * this.disponibilitaDomenicaAlle = disponibilitaDomenicaAlle; }
	 */
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

	/*
	 * public int getDisponibilita(String giorno, String stringa) { if
	 * (giorno.equals("Lunedž") && stringa.equals("dalle")) { return
	 * getDisponibilitaLunedžDalle(); } if (giorno.equals("Lunedž") &&
	 * stringa.equals("alle")) { return getDisponibilitaLunedžAlle(); } if
	 * (giorno.equals("Martedž") && stringa.equals("dalle")) { return
	 * getDisponibilitaMartedžDalle(); } if (giorno.equals("Martedž") &&
	 * stringa.equals("alle")) { return getDisponibilitaMartedžAlle(); } if
	 * (giorno.equals("Mercoledž") && stringa.equals("dalle")) { return
	 * getDisponibilitaMercoledžDalle(); } if (giorno.equals("Mercoledž") &&
	 * stringa.equals("alle")) { return getDisponibilitaMercoledžAlle(); } if
	 * (giorno.equals("Giovedž") && stringa.equals("dalle")) { return
	 * getDisponibilitaGiovedžDalle(); } if (giorno.equals("Giovedž") &&
	 * stringa.equals("alle")) { return getDisponibilitaGiovedžAlle(); } if
	 * (giorno.equals("Venerdž") && stringa.equals("dalle")) { return
	 * getDisponibilitaVenerdžDalle(); } if (giorno.equals("Venerdž") &&
	 * stringa.equals("alle")) { return getDisponibilitaVenerdžAlle(); } if
	 * (giorno.equals("Sabato") && stringa.equals("dalle")) { return
	 * getDisponibilitaSabatoDalle(); } if (giorno.equals("Sabato") &&
	 * stringa.equals("alle")) { return getDisponibilitaSabatoAlle(); } if
	 * (giorno.equals("Domenica") && stringa.equals("dalle")) { return
	 * getDisponibilitaDomenicaDalle(); } if (giorno.equals("Domenica") &&
	 * stringa.equals("alle")) { return getDisponibilitaDomenicaAlle(); } return
	 * -2; }
	 */
}