package model;

import javax.persistence.*;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import java.sql.Timestamp;
import java.util.Objects;
import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.Max;

/**
 * @author tsamo
 */
@Entity
@Table(name = "service", schema = "dnmgdb", catalog = "")
public class ServiceEntity {
    private int id;
    private Timestamp startDate;
    private int professionalId;
    private int customerId;
    private int cost;
    private boolean fulfilled;
    @Min(1)
    @Max(5)
    private int rating;

    @Transient
    private RegisterEntity otherUser;
    private String topic;

    @Id
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "start_date", nullable = false)
    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    @Basic
    @Column(name = "professional_id", nullable = false)
    public int getProfessionalId() {
        return professionalId;
    }

    public void setProfessionalId(int professionalId) {
        this.professionalId = professionalId;
    }

    @Basic
    @Column(name = "customer_id", nullable = false)
    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    @Basic
    @Column(name = "cost", nullable = false)
    public int getCost() {
        return cost;
    }

    public void setCost(int cost) {
        this.cost = cost;
    }

    @Basic
    @Column(name = "fulfilled", nullable = false)
    public boolean isFulfilled() {
        return fulfilled;
    }

    public void setFulfilled(boolean fulfilled) {
        this.fulfilled = fulfilled;
    }

    @Basic
    @Column(name = "rating")
    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    @Transient
    public RegisterEntity getOtherUser() {
        return otherUser;
    }

    public void setOtherUser(RegisterEntity otherUser) {
        this.otherUser = otherUser;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ServiceEntity that = (ServiceEntity) o;
        return id == that.id &&
                professionalId == that.professionalId &&
                customerId == that.customerId &&
                cost == that.cost &&
                fulfilled == that.fulfilled &&
                Objects.equals(startDate, that.startDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, startDate, professionalId, customerId, cost, fulfilled);
    }

    @Basic
    @Column(name = "topic")
    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }
}
