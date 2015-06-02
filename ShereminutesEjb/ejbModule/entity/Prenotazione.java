package entity;

import java.io.Serializable;
import java.time.LocalDateTime;
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
	/*
	 * private int orarioDalle; private int orarioAlle;
	 */
	private String orarioPrenotato;
	private Boolean isAccettataSeller;
	private Boolean isConfermataBuyer;
	private Boolean isPagata;
	private Boolean isFeedbackRilasciato;
	private Boolean isRifiutata;
	private Utente utenteBuyer;
	private Utente utenteSeller;
	private Abilita abilita;
	private LocalDateTime dataInvioPrenotazione;
	private Long numeroVendite;
	private Long numeroAcquisti;

	public Prenotazione() {
		super();
	}

	public Prenotazione(int id, Date data, String orarioPrenotato,
			Utente utenteB, Utente utenteS, Abilita abilita,
			boolean isAccettataSeller, boolean isConfermataBuyer,
			boolean isFeedbackRilasciato, boolean isPagata,
			boolean isRifiutata, LocalDateTime dataInvioPrenotazione) {
		super();
		setIdPrenotazione(id);
		setDataPrenotazione(data);
		// setOrarioDalle(orarioDalle);
		// setOrarioAlle(orarioAlle);
		setOrarioPrenotato(orarioPrenotato);

		setUtenteBuyer(utenteB);
		setUtenteSeller(utenteS);
		setAbilita(abilita);
		setAccettataSeller(isAccettataSeller);
		setConfermataBuyer(isConfermataBuyer);
		setFeedbackRilasciato(isFeedbackRilasciato);
		setPagata(isPagata);
		setRifiutata(isRifiutata);
		setDataInvioPrenotazione(dataInvioPrenotazione);

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

	/*
	 * @Column(name = "orarioDalle") public int getOrarioDalle() { return
	 * orarioDalle; }
	 * 
	 * public void setOrarioDalle(int orarioDalle) { this.orarioDalle =
	 * orarioDalle; }
	 * 
	 * @Column(name = "orarioAlle") public int getOrarioAlle() { return
	 * orarioAlle; }
	 * 
	 * public void setOrarioAlle(int orarioAlle) { this.orarioAlle = orarioAlle;
	 * }
	 */

	@Column(name = "orarioPrenotato")
	public String getOrarioPrenotato() {
		return orarioPrenotato;
	}

	public void setOrarioPrenotato(String orarioPrenotato) {
		this.orarioPrenotato = orarioPrenotato;
	}

	@Column(name = "isAccettataSeller")
	public Boolean isAccettataSeller() {
		return isAccettataSeller;
	}

	public void setAccettataSeller(Boolean isAccettataSeller) {
		this.isAccettataSeller = isAccettataSeller;
	}

	@Column(name = "isConfermataBuyer")
	public Boolean isConfermataBuyer() {
		return isConfermataBuyer;
	}

	public void setConfermataBuyer(Boolean isConfermataBuyer) {
		this.isConfermataBuyer = isConfermataBuyer;
	}

	@Column(name = "isPagata")
	public Boolean isPagata() {
		return isPagata;
	}

	public void setPagata(Boolean isPagata) {
		this.isPagata = isPagata;
	}

	@Column(name = "isFeedbackRilasciato")
	public boolean isFeedbackRilasciato() {
		return isFeedbackRilasciato;
	}

	public void setFeedbackRilasciato(boolean isFeedbackRilasciato) {
		this.isFeedbackRilasciato = isFeedbackRilasciato;
	}

	@Column(name = "isRifiutata")
	public boolean isRifiutata() {
		return isRifiutata;
	}

	public void setRifiutata(boolean isRifiutata) {
		this.isRifiutata = isRifiutata;
	}

	@Column(name = "dataInvioPrenotazione")
	public LocalDateTime getDataInvioPrenotazione() {
		return dataInvioPrenotazione;
	}

	public void setDataInvioPrenotazione(LocalDateTime dataInvioPrenotazione) {
		this.dataInvioPrenotazione = dataInvioPrenotazione;
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
	@PrimaryKeyJoinColumn(name = "utenteBuyer", referencedColumnName = "idUtente")
	public Utente getUtenteBuyer() {
		return this.utenteBuyer;
	}

	public void setUtenteBuyer(Utente utenteBuyer) {
		this.utenteBuyer = utenteBuyer;
	}

	@ManyToOne(optional = false)
	@PrimaryKeyJoinColumn(name = "utenteSeller", referencedColumnName = "idUtente")
	public Utente getUtenteSeller() {
		return this.utenteSeller;
	}

	public void setUtenteSeller(Utente utenteSeller) {
		this.utenteSeller = utenteSeller;
	}

	// NON SONO TABELLE NEL DB
	public Long getNumeroVendite() {
		return this.numeroVendite;
	}

	public void setNumeroVendite(Long numeroVendite) {
		this.numeroVendite = numeroVendite;
	}

	public Long getNumeroAcquisti() {
		return this.numeroAcquisti;
	}

	public void setNumeroAcquisti(Long numeroAcquisti) {
		this.numeroAcquisti = numeroAcquisti;
	}

}