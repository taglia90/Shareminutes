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
@Table(name = "Follower")
public class Follower implements Serializable {
	private int idFollower;
	private Utente utente;
	private Utente utenteSeguito;
	private boolean isPreferito;

	public Follower() {
		super();
	}

	public Follower(int id, Utente user, Utente userSeguito, boolean isPreferito) {
		super();
		setIdFollower(id);
		setUtente(user);
		setUtenteSeguito(userSeguito);
		setPreferito(isPreferito);
	}

	@Id
	@Column(name = "idFollower", length = Integer.MAX_VALUE)
	public int getIdFollower() {
		return idFollower;
	}

	public void setIdFollower(int id) {
		this.idFollower = id;
	}

	@ManyToOne(optional = false)
	@PrimaryKeyJoinColumn(name = "utente", referencedColumnName = "idUtente")
	public Utente getUtente() {
		return utente;
	}

	public void setUtente(Utente user) {
		this.utente = user;
	}

	@ManyToOne(optional = false)
	@PrimaryKeyJoinColumn(name = "utenteSeguito", referencedColumnName = "idUtente")
	public Utente getUtenteSeguito() {
		return utenteSeguito;
	}

	public void setUtenteSeguito(Utente userSeguito) {
		this.utenteSeguito = userSeguito;
	}

	@Column(name = "isPreferito")
	public boolean isPreferito() {
		return isPreferito;
	}

	public void setPreferito(boolean isPreferito) {
		this.isPreferito = isPreferito;
	}

}
