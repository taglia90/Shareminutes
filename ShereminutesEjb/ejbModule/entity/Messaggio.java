package entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "Messaggio")
public class Messaggio implements Serializable {

	private int idMessaggio;
	private String corpoMessaggio;
	private Richiesta richiesta;
	private Utente utente;
	private int numeroMessaggio;

	public Messaggio() {
		super();
	}

	public Messaggio(int id, String corpoMess, Richiesta ric, Utente utente,
			int numeroMess) {
		super();
		setIdMessaggio(id);
		setCorpoMessaggio(corpoMess);
		setRichiesta(ric);
		setUtente(utente);
		setNumeroMessaggio(numeroMess);
	}

	@Id
	@Column(name = "idMessaggio", length = Integer.MAX_VALUE)
	public int getIdMessaggio() {
		return this.idMessaggio;
	}

	private void setIdMessaggio(int id) {
		this.idMessaggio = id;
	}

	@Column(name = "corpoMessaggio", length = 10000)
	public String getCorpoMessaggio() {
		return corpoMessaggio;
	}

	public void setCorpoMessaggio(String corpoMess) {
		this.corpoMessaggio = corpoMess;
	}

	@JoinColumn(name = "idRichiesta", referencedColumnName = "idRichiesta")
	@ManyToOne(fetch = FetchType.LAZY)
	public Richiesta getRichiesta() {
		return richiesta;
	}

	public void setRichiesta(Richiesta richiesta) {
		this.richiesta = richiesta;
	}

	@ManyToOne(optional = false)
	@PrimaryKeyJoinColumn(name = "utente", referencedColumnName = "idUtente")
	public Utente getUtente() {
		return this.utente;
	}

	public void setUtente(Utente user) {
		this.utente = user;
	}

	@Column(name = "numeroMessaggio")
	public int getNumeroMessaggio() {
		return numeroMessaggio;
	}

	public void setNumeroMessaggio(int numeroMessaggio) {
		this.numeroMessaggio = numeroMessaggio;
	}

}