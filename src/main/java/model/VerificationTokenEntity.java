package model;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

/**
 * @author tsamo
 */
@Entity
@Table(name = "verificationToken", schema = "dnmgdb")
public class VerificationTokenEntity {
    private int id;
    private String token;
    private Timestamp generatedTokenDateTime;
    private int userId;

    @Id
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "token", nullable = false, length = 100)
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    @Basic
    @Column(name = "generatedTokenDateTime", nullable = false)
    public Timestamp getGeneratedTokenDateTime() {
        return generatedTokenDateTime;
    }

    public void setGeneratedTokenDateTime(Timestamp generatedTokenDateTime) {
        this.generatedTokenDateTime = generatedTokenDateTime;
    }

    @Basic
    @Column(name = "user_id", nullable = false)
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        VerificationTokenEntity that = (VerificationTokenEntity) o;
        return id == that.id &&
                userId == that.userId &&
                Objects.equals(token, that.token) &&
                Objects.equals(generatedTokenDateTime, that.generatedTokenDateTime);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, token, generatedTokenDateTime, userId);
    }
}
