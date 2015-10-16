package entity;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.*;

@SuppressWarnings("serial")
@Entity
@Table(name = "Landing")
public class Landing implements Serializable {

	private int idLanding;
	private String nome;
	private String email;
	private String nomeAbilita;

	public Landing() {
		super();
	}

	public Landing(int id, String nome, String email, String nomeAbilita) {
		super();

		setIdLanding(id);
		setNome(nome);
		setEmail(email);
		setNomeAbilita(nomeAbilita);
	}

	@Id
	@Column(name = "idLanding", length = Integer.MAX_VALUE)
	public int getIdLanding() {
		return idLanding;
	}

	private void setIdLanding(int id) {
		this.idLanding = id;
	}

	@Column(name = "nome")
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	@Column(name = "email")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "nomeAbilita")
	public String getNomeAbilita() {
		return nomeAbilita;
	}

	public void setNomeAbilita(String nomeAbilita) {
		this.nomeAbilita = nomeAbilita;
	}
}