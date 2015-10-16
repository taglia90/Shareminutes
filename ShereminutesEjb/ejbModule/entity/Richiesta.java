package entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "Richiesta")
public class Richiesta implements Serializable {

	private int idRichiesta;
	private String oggettoRichiesta;
	private Utente utenteMittente;
	private Utente utenteDestinatario;
	private boolean haRicevutoFeedback;
	private List<Messaggio> listaMessaggi = new ArrayList<Messaggio>();
	private int lettoDa = 0;

	public Richiesta() {
		super();
	}

	public Richiesta(int id, String oggettoRich, Utente utenteMitt,
			Utente utenteDest, int lettaDa) {
		super();
		setIdRichiesta(id);
		setOggettoRichiesta(oggettoRich);
		setUtenteMittente(utenteMitt);
		setUtenteDestinatario(utenteDest);
		this.haRicevutoFeedback = false;
		setLettoDa(lettaDa);
	}

	@Id
	@Column(name = "idRichiesta", length = Integer.MAX_VALUE)
	public int getIdRichiesta() {
		return idRichiesta;
	}

	private void setIdRichiesta(int id) {
		this.idRichiesta = id;
	}

	@Column(name = "oggettoRichiesta")
	public String getOggettoRichiesta() {
		return oggettoRichiesta;
	}

	public void setOggettoRichiesta(String oggettoRich) {
		this.oggettoRichiesta = oggettoRich;
	}

	@ManyToOne(optional = false)
	@PrimaryKeyJoinColumn(name = "utenteMittente", referencedColumnName = "idUtente")
	public Utente getUtenteMittente() {
		return utenteMittente;
	}

	private void setUtenteMittente(Utente utenteMitt) {
		this.utenteMittente = utenteMitt;
	}

	@ManyToOne(optional = false)
	@PrimaryKeyJoinColumn(name = "utenteDestinatario", referencedColumnName = "idUtente")
	public Utente getUtenteDestinatario() {
		return utenteDestinatario;
	}

	private void setUtenteDestinatario(Utente utenteDest) {
		this.utenteDestinatario = utenteDest;
	}

	@Column(name = "haRicevutoFeedback")
	public boolean getHaRicevutoFeedback() {
		return this.haRicevutoFeedback;
	}

	public void setHaRicevutoFeedback(boolean haRicevuto) {
		this.haRicevutoFeedback = haRicevuto;
	}

	@OneToMany(mappedBy = "richiesta", fetch = FetchType.LAZY)
	@OrderBy("numeroMessaggio ASC")
	public List<Messaggio> getListaMessaggi() {
		return listaMessaggi;
	}

	public void setListaMessaggi(List<Messaggio> listaMessaggi) {
		this.listaMessaggi = listaMessaggi;
	}

	public void addMessaggio(Messaggio messaggio) {
		listaMessaggi.add(messaggio);
	}

	@Column(name = "lettoDa")
	public int getLettoDa() {
		return lettoDa;
	}

	public void setLettoDa(int lettoDa) {
		this.lettoDa = lettoDa;
	}
}