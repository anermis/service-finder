package model;

import javax.persistence.*;
import java.util.Objects;

/**
 * @author tsamo
 */
@Entity
@Table(name = "phone", schema = "dnmgdb")
public class PhoneEntity {
    private int userId;
    private String landline;
    private String mobile;

    public PhoneEntity() {
    }

    public PhoneEntity(PhoneEntity p){
        this.userId = p.getUserId();
        this.landline = p.getLandline();
        this.mobile = p.getMobile();
    }

    @Id
    @Column(name = "user_id", nullable = false)
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "landline", nullable = true, length = 15)
    public String getLandline() {
        return landline;
    }

    public void setLandline(String landline) {
        this.landline = landline;
    }

    @Basic
    @Column(name = "mobile", nullable = true, length = 15)
    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PhoneEntity that = (PhoneEntity) o;
        return userId == that.userId &&
                Objects.equals(landline, that.landline) &&
                Objects.equals(mobile, that.mobile);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, landline, mobile);
    }
}
