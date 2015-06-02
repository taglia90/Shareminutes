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
@Table(name = "Amicizia")
public class Amicizia implements Serializable {
	private int idAmicizia;
	private Utente utenteCliente;
	private Utente utenteFornitore;
	private boolean isAmiciziaAccettata;
	private boolean isAmiciziaRifiutata;

	public Amicizia() {
		super();
	}

	public Amicizia(int id, Utente userCliente, Utente userFornitore,
			boolean amiciziaAcc) {
		super();
		setIdAmicizia(id);
		setUtenteCliente(userCliente);
		setUtenteFornitore(userFornitore);
		setAmiciziaAccettata(amiciziaAcc);
		setAmiciziaRifiutata(false);
	}

	@Id
	@Column(name = "idAmicizia", length = Integer.MAX_VALUE)
	public int getIdAmicizia() {
		return idAmicizia;
	}

	public void setIdAmicizia(int id) {
		this.idAmicizia = id;
	}

	@ManyToOne(optional = false)
	@PrimaryKeyJoinColumn(name = "utenteCliente", referencedColumnName = "idUtente")
	public Utente getUtenteCliente() {
		return utenteCliente;
	}

	public void setUtenteCliente(Utente userCliente) {
		this.utenteCliente = userCliente;
	}

	@ManyToOne(optional = false)
	@PrimaryKeyJoinColumn(name = "utenteFornitore", referencedColumnName = "idUtente")
	public Utente getUtenteFornitore() {
		return utenteFornitore;
	}

	public void setUtenteFornitore(Utente userFornitore) {
		this.utenteFornitore = userFornitore;
	}

	@Column(name = "isAmiciziaAccettata")
	public boolean isAmiciziaAccettata() {
		return isAmiciziaAccettata;
	}

	public void setAmiciziaAccettata(boolean isAmiciziaAcc) {
		this.isAmiciziaAccettata = isAmiciziaAcc;
	}

	@Column(name = "isAmiciziaRifiutata")
	public boolean isAmiciziaRifiutata() {
		return isAmiciziaRifiutata;
	}

	public void setAmiciziaRifiutata(boolean isAmiciziarif) {
		this.isAmiciziaRifiutata = isAmiciziarif;
	}

}
