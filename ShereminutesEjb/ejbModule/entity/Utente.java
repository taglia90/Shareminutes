package entity;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.*;

@SuppressWarnings("serial")
@Entity
@Table(name = "Utente")
public class Utente implements Serializable {

	private int idUtente;
	private String username;
	private boolean isAdmin;
	private String cognome;
	private byte[] fotoProfilo;
	private String nome;
	private byte[] password;
	private String biografia;
	private String cap;
	private String cittaAttuale;
	private Date dataNascita;
	private String email;
	private String eta;
	private String headline;
	private String paese;
	private String posizioneLavorativa;
	private String sesso;
	private int tempoMedioRisposta;
	private String emailPayPal;

	private List<Abilita> abilita = new ArrayList<Abilita>();

	public Utente() {
		super();
	}

	public Utente(int id, String email, byte[] password, String nome,
			String cognome, boolean isAdminU) {
		super();

		setIdUtente(id);
		setUsername(email);
		setAdmin(isAdminU);
		setCognome(cognome);
		setNome(nome);
		setPassword(password);
		setEmail(email);
		
	}

	public Utente(int id, String nome, String cognome, String paese,
			String cittaAttuale, String cap, String sesso, String eta,
			String posizioneLavorativa, String headline, String biografia,
			byte[] fotoProfilo) {
		super();

		setIdUtente(id);
		setCognome(cognome);
		setFotoProfilo(fotoProfilo);
		setNome(nome);
		setPaese(paese);
		setCittaAttuale(cittaAttuale);
		setCap(cap);
		setSesso(sesso);
		setEta(eta);
		setPosizioneLavorativa(posizioneLavorativa);
		setHeadline(headline);
		setBiografia(biografia);
		
	}

	public Utente(int id, String emailPayPal) {
		super();
		setIdUtente(id);
		setEmailPayPal(emailPayPal);
	}

	@Id
	@Column(name = "idUtente", length = Integer.MAX_VALUE)
	public int getIdUtente() {
		return idUtente;
	}

	private void setIdUtente(int id) {
		this.idUtente = id;
	}

	@Column(name = "username")
	public String getUsername() {
		return username;
	}

	public void setUsername(String usernameU) {
		this.username = usernameU;
	}

	@Column(name = "isAdmin")
	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdm) {
		this.isAdmin = isAdm;
	}
	
	@Column(name = "cognome")
	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	
	@Lob
	@Basic(fetch = FetchType.LAZY)
	@Column(length = 100000, name = "fotoProfilo")
	// fino a 1Mb
	public byte[] getFotoProfilo() {
		return fotoProfilo;
	}

	public void setFotoProfilo(byte[] fotoProfilo) {
		this.fotoProfilo = fotoProfilo;
	}
	
	@Column(name = "nome")
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	
	@Column(name = "password")
	public byte[] getPassword() {
		return password;
	}

	public void setPassword(byte[] password) {
		this.password = password;
	}

	@Column(name = "biografia", length = 10000)
	public String getBiografia() {
		return biografia;
	}

	public void setBiografia(String biografia) {
		this.biografia = biografia;
	}
	
	@Column(name = "cap")
	public String getCap() {
		return cap;
	}

	public void setCap(String cap) {
		this.cap = cap;
	}
	
	@Column(name = "cittaAttuale")
	public String getCittaAttuale() {
		return cittaAttuale;
	}

	public void setCittaAttuale(String cittaAttuale) {
		this.cittaAttuale = cittaAttuale;
	}
	
	@Column(name = "dataNascita")
	public Date getDataNascita() {
		return dataNascita;
	}

	public void setDataNascita(Date dataNascita) {
		this.dataNascita = dataNascita;
	}
	
	@Column(name = "email", unique = true)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "eta")
	public String getEta() {
		return eta;
	}

	public void setEta(String eta) {
		this.eta = eta;
	}

	@Column(name = "headline")
	public String getHeadline() {
		return headline;
	}

	public void setHeadline(String headline) {
		this.headline = headline;
	}
	
	@Column(name = "paese")
	public String getPaese() {
		return paese;
	}

	public void setPaese(String paese) {
		this.paese = paese;
	}

	@Column(name = "posizioneLavorativa")
	public String getPosizioneLavorativa() {
		return posizioneLavorativa;
	}

	public void setPosizioneLavorativa(String posizioneLavorativa) {
		this.posizioneLavorativa = posizioneLavorativa;
	}
	@Column(name = "sesso")
	public String getSesso() {
		return sesso;
	}

	public void setSesso(String sesso) {
		this.sesso = sesso;
	}

	@Column(name = "tempoMedioRisposta")
	public int getTempoMedioRisposta() {
		return tempoMedioRisposta;
	}

	public void setTempoMedioRisposta(int tempoMedioRisposta) {
		this.tempoMedioRisposta = tempoMedioRisposta;
	}

	@Column(name = "emailPayPal")
	public String getEmailPayPal() {
		return emailPayPal;
	}

	public void setEmailPayPal(String emailPayPal) {
		this.emailPayPal = emailPayPal;
	}

	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "UtenteAbilita", joinColumns = { @JoinColumn(name = "idUtente", nullable = false) }, inverseJoinColumns = { @JoinColumn(name = "idAbilita", nullable = false) })
	public List<Abilita> getAbilita() {
		return abilita;
	}

	public void setAbilita(List<Abilita> abilita) {
		this.abilita = abilita;
	}

	public void setNewAbilita(Abilita ability) {
		abilita.add(ability);
	}

	public void rimuoviAbilita(Abilita abilita) {
		this.abilita.remove(abilita);
	}

	public void svuotaAbilita() {
		int i;
		for (i = 0; i < abilita.size(); i++) {
			abilita.remove(i);
		}
	}

}