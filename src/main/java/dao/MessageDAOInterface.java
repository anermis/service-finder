package dao;

import model.MessageEntity;

import java.util.ArrayList;

/**
 * @author tsamo
 */
public interface MessageDAOInterface {
    ArrayList<MessageEntity> getServicesMessages(int serviceID);
}
