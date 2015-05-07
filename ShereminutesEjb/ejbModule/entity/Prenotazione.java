package entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "Prenotazione")
public class Prenotazione implements Serializable {

	private int idPrenotazione;
	private Date dataPrenotazione;
	private int orarioDalle;
	private int orarioAlle;
	private Boolean isConfermata;
	private Boolean isPagata;
	private Utente utenteRichiedente;
	private Abilita abilita;

	public Prenotazione() {
		super();
	}

	public Prenotazione(int id, Date data, int orarioDalle, int orarioAlle,
			Boolean isConfermata, Boolean isPagata, Utente utente,
			Abilita abilita) {
		super();
		setIdPrenotazione(id);
		setDataPrenotazione(data);
		setOrarioDalle(orarioDalle);
		setOrarioAlle(orarioAlle);
		setConfermata(isConfermata);
		setPagata(isPagata);
		setUtenteRichiedente(utente);
		setAbilita(abilita);

	}

	@Id
	@Column(name = "idPrenotazione", length = Integer.MAX_VALUE)
	public int getIdPrenotazione() {
		return this.idPrenotazione;
	}

	private void setIdPrenotazione(int id) {
		this.idPrenotazione = id;
	}

	@Column(name = "dataPrenotazione")
	public Date getDataPrenotazione() {
		return dataPrenotazione;
	}

	public void setDataPrenotazione(Date dataPrenotazione) {
		this.dataPrenotazione = dataPrenotazione;
	}

	@Column(name = "orarioDalle")
	public int getOrarioDalle() {
		return orarioDalle;
	}

	public void setOrarioDalle(int orarioDalle) {
		this.orarioDalle = orarioDalle;
	}

	@Column(name = "orarioAlle")
	public int getOrarioAlle() {
		return orarioAlle;
	}

	public void setOrarioAlle(int orarioAlle) {
		this.orarioAlle = orarioAlle;
	}

	@Column(name = "isConfermata")
	public Boolean isConfermata() {
		return isConfermata;
	}

	public void setConfermata(Boolean isConfermata) {
		this.isConfermata = isConfermata;
	}

	@Column(name = "isPagata")
	public Boolean isPagata() {
		return isPagata;
	}

	public void setPagata(Boolean isPagata) {
		this.isPagata = isPagata;
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

	@ManyToOne(optional = false)
	@PrimaryKeyJoinColumn(name = "utenteRichiedente", referencedColumnName = "idUtente")
	public Utente getUtenteRichiedente() {
		return this.utenteRichiedente;
	}

	public void setUtenteRichiedente(Utente utenteRichiedente) {
		this.utenteRichiedente = utenteRichiedente;
	}
}