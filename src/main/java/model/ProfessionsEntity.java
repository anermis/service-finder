package model;

import javax.persistence.*;
import java.util.Objects;

/**
 * @author tsamo
 */
@Entity
@Table(name = "professions", schema = "dnmgdb")
public class ProfessionsEntity {
    private int id;
    private String profession;


    public ProfessionsEntity() {
    }

    public ProfessionsEntity(ProfessionsEntity p) {
        this.id = p.getId();
        this.profession = p.getProfession();
    }

    @Id
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "profession", nullable = false, length = 50)
    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProfessionsEntity that = (ProfessionsEntity) o;
        return id == that.id &&
                Objects.equals(profession, that.profession);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, profession);
    }
}