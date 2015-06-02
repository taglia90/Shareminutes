package entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "Abilita")
public class Abilita implements Serializable {

	private int idAbilita;
	private String nomeAbilita;
	private String descrizioneAbilita;
	private boolean isApproved;
	private byte[] fotoAbilita;
	private int tariffa;
	private int minuti;
	private String cittaDoveOffreServizio;
	private int minutiNecessari;
	private int minutiCondivisi;
	private String disponibilita;
	

	@Column(name = "idAbilitaddd")
	private List<Utente> utente = new ArrayList<Utente>();

	public Abilita() {
		super();
	}

	public Abilita(int id, String nomeAb, String descrizioneAb, boolean isAppr,
			byte[] fotoAbilita, int minutiNecessari, int tariffa, int minuti,
			String cittaDoveOffreServizio, String disponibilita) {
		super();
		setIdAbilita(id);
		setNomeAbilita(nomeAb);
		setDescrizioneAbilita(descrizioneAb);
		setApproved(isAppr);
		setFotoAbilita(fotoAbilita);
		setMinutiNecessari(minutiNecessari);
		setTariffa(tariffa);
		setMinuti(minuti);
		setCittaDoveOffreServizio(cittaDoveOffreServizio);
		setDisponibilita(disponibilita);
	}
	
	public Abilita(int id, int minutiCondivisi){
		super();
		setIdAbilita(id);
		setMinutiCondivisi(minutiCondivisi);
	}

	@Id
	@Column(name = "idAbilita", length = Integer.MAX_VALUE)
	public int getIdAbilita() {
		return idAbilita;
	}

	private void setIdAbilita(int id) {
		this.idAbilita = id;
	}

	@Column(name = "nomeAbilita")
	public String getNomeAbilita() {
		return nomeAbilita;
	}

	public void setNomeAbilita(String nomeAb) {
		this.nomeAbilita = nomeAb;
	}

	@Column(name = "descrizioneAbilita", length = 10000)
	public String getDescrizioneAbilita() {
		return descrizioneAbilita;
	}

	public void setDescrizioneAbilita(String descrizioneAb) {
		this.descrizioneAbilita = descrizioneAb;
	}

	@Column(name = "isApproved")
	public boolean isApproved() {
		return isApproved;
	}

	public void setApproved(boolean isAppr) {
		this.isApproved = isAppr;
	}

	@Lob
	@Basic(fetch = FetchType.LAZY)
	@Column(length = 100000, name = "fotoAbilita")
	// fino a 1Mb
	public byte[] getFotoAbilita() {
		return fotoAbilita;
	}

	public void setFotoAbilita(byte[] fotoAbilita) {
		this.fotoAbilita = fotoAbilita;
	}

	@Column(name = "tariffa")
	public int getTariffa() {
		return tariffa;
	}

	public void setTariffa(int tariffa) {
		this.tariffa = tariffa;
	}

	@Column(name = "minuti")
	public int getMinuti() {
		return minuti;
	}

	public void setMinuti(int minutiM) {
		this.minuti = minutiM;
	}

	@Column(name = "cittaDoveOffreServizio")
	public String getCittaDoveOffreServizio() {
		return cittaDoveOffreServizio;
	}

	public void setCittaDoveOffreServizio(String cittaDoveOffreServizio) {
		this.cittaDoveOffreServizio = cittaDoveOffreServizio;
	}

	@Column(name = "minutiNecessari")
	public int getMinutiNecessari() {
		return minutiNecessari;
	}

	public void setMinutiNecessari(int minutiNecessari) {
		this.minutiNecessari = minutiNecessari;
	}

	@Column(name = "minutiCondivisi")
	public int getMinutiCondivisi() {
		return minutiCondivisi;
	}

	public void setMinutiCondivisi(int minutiCondivisi) {
		this.minutiCondivisi = minutiCondivisi;
	}

	@Lob
	@Column(name = "disponibilita")
	public String getDisponibilita() {
		return disponibilita;
	}

	public void setDisponibilita(String disponibilita) {
		this.disponibilita = disponibilita;
	}

	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "UtenteAbilita", joinColumns = { @JoinColumn(name = "idAbilita", nullable = false) }, inverseJoinColumns = { @JoinColumn(name = "idUtente", nullable = false) })
	public List<Utente> getUtente() {
		return utente;
	}

	public void setUtente(List<Utente> utentiConAbilita) {
		this.utente = utentiConAbilita;
	}

}