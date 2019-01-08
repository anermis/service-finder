package model;

import utils.MessageType;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

/**
 * @author tsamo
 */
@Entity
@Table(name = "message", schema = "dnmgdb")
public class MessageEntity {
    private int id;
    private int senderId;
    private int receiverId;
    private String data;
    private Timestamp timeSent;
    private int serviceId;
    @Transient
    private MessageType messageType;

    @Transient
    public MessageType getMessageType() {
        return messageType;
    }

    public void setMessageType(MessageType messageType) {
        this.messageType = messageType;
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
    @Column(name = "sender_id", nullable = false)
    public int getSenderId() {
        return senderId;
    }

    public void setSenderId(int senderId) {
        this.senderId = senderId;
    }

    @Basic
    @Column(name = "receiver_id", nullable = false)
    public int getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
    }

    @Basic
    @Column(name = "data", nullable = false, length = 250)
    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    @Basic
    @Column(name = "time_sent", nullable = false)
    public Timestamp getTimeSent() {
        return timeSent;
    }

    public void setTimeSent(Timestamp timeSent) {
        this.timeSent = timeSent;
    }

    @Basic
    @Column(name = "service_id", nullable = false)
    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MessageEntity that = (MessageEntity) o;
        return id == that.id &&
                senderId == that.senderId &&
                receiverId == that.receiverId &&
                serviceId == that.serviceId &&
                Objects.equals(data, that.data) &&
                Objects.equals(timeSent, that.timeSent);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, senderId, receiverId, data, timeSent, serviceId);
    }
}
