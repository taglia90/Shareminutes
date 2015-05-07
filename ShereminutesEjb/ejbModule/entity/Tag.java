package entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "Tag")
public class Tag implements Serializable {

	private int idTag;
	private String stringaTag;
	private Abilita abilita;

	public Tag() {
		super();
	}

	public Tag(int id, String stringaTag, Abilita abilita) {
		super();
		setIdTag(id);
		setStringaTag(stringaTag);
		setAbilita(abilita);

	}

	@Id
	@Column(name = "idTag", length = Integer.MAX_VALUE)
	public int getIdTag() {
		return this.idTag;
	}

	private void setIdTag(int id) {
		this.idTag = id;
	}

	@Column(name = "stringaTag")
	public String getStringaTag() {
		return stringaTag;
	}

	public void setStringaTag(String stringaTag) {
		this.stringaTag = stringaTag;
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
}