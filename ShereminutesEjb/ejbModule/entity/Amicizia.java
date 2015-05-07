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
	private Utente utente1;
	private Utente utente2;
	private boolean isAmiciziaAccettata;
	private boolean isAmiciziaRifiutata;

	public Amicizia() {
		super();
	}

	public Amicizia(int id, Utente user1, Utente user2, boolean amiciziaAcc) {
		super();
		setIdAmicizia(id);
		setUtente1(user1);
		setUtente2(user2);
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
	@PrimaryKeyJoinColumn(name = "utente1", referencedColumnName = "idUtente")
	public Utente getUtente1() {
		return utente1;
	}

	public void setUtente1(Utente user1) {
		this.utente1 = user1;
	}

	@ManyToOne(optional = false)
	@PrimaryKeyJoinColumn(name = "utente2", referencedColumnName = "idUtente")
	public Utente getUtente2() {
		return utente2;
	}

	public void setUtente2(Utente user2) {
		this.utente2 = user2;
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
