package entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "Feedback")
public class Feedback implements Serializable {
	private int idFeedback;
	private int votoSintetico;
	private String votoEsteso;
	private Utente utenteRicevente;
	private Utente utenteGiudicante;

	public Feedback() {
		super();
	}

	public Feedback(int id, int votoSint, String votoEst, Utente utenteRic,
			Utente utenteGiud) {
		super();
		setIdFeedback(id);
		setVotoSintetico(votoSint);
		setVotoEsteso(votoEst);
		setUtenteRicevente(utenteRic);
		setUtenteGiudicante(utenteGiud);
	}

	@Id
	@Column(name = "idFeedback", length = Integer.MAX_VALUE)
	public int getIdFeedback() {
		return idFeedback;
	}

	private void setIdFeedback(int id) {
		this.idFeedback = id;
	}

	@Column(name = "votoSintetico")
	public int getVotoSintetico() {
		return votoSintetico;
	}

	public void setVotoSintetico(int votoSint) {
		this.votoSintetico = votoSint;
	}

	@Column(name = "votoEsteso", length = 10000)
	public String getVotoEsteso() {
		return votoEsteso;
	}

	public void setVotoEsteso(String votoEst) {
		this.votoEsteso = votoEst;
	}

	@ManyToOne(optional = false)
	@PrimaryKeyJoinColumn(name = "utenteRicevente", referencedColumnName = "idUtente")
	public Utente getUtenteRicevente() {
		return utenteRicevente;
	}

	private void setUtenteRicevente(Utente utenteRic) {
		this.utenteRicevente = utenteRic;
	}

	@ManyToOne(optional = false)
	@PrimaryKeyJoinColumn(name = "utenteGiudicante", referencedColumnName = "idUtente")
	public Utente getUtenteGiudicante() {
		return utenteGiudicante;
	}

	private void setUtenteGiudicante(Utente utenteGiud) {
		this.utenteGiudicante = utenteGiud;
	}

}