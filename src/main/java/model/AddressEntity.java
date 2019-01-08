package model;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Objects;

/**
 * @author tsamo
 */
@Entity
@Table(name = "address", schema = "dnmgdb")
public class AddressEntity {
    private int userId;
    private String address;
    private BigDecimal longit;
    private BigDecimal latit;

    public AddressEntity() {
    }

    public AddressEntity(AddressEntity a){
        this.userId = a.getUserId();
        this.address = a.getAddress();
        this.longit = a.getLongit();
        this.latit = a.getLatit();
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
    @Column(name = "address", nullable = false, length = 50)
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Basic
    @Column(name = "longit", precision = 8)
    public BigDecimal getLongit() {
        return longit;
    }

    public void setLongit(BigDecimal longit) {
        this.longit = longit;
    }

    @Basic
    @Column(name = "latit", precision = 8)
    public BigDecimal getLatit() {
        return latit;
    }

    public void setLatit(BigDecimal latit) {
        this.latit = latit;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AddressEntity that = (AddressEntity) o;
        return userId == that.userId &&
                Objects.equals(address, that.address) &&
                Objects.equals(longit, that.longit) &&
                Objects.equals(latit, that.latit);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, address, longit, latit);
    }
}
