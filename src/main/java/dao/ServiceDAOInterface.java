package dao;

import model.RegisterEntity;
import model.ServiceEntity;

import java.util.ArrayList;
import java.util.List;


public interface ServiceDAOInterface {
    int returnIfServiceExists(int customerID, int professionalID);
    ServiceEntity insertService(ServiceEntity serviceEntity);
    ServiceEntity getServiceByID(int serviceID);
    ArrayList<ServiceEntity> getAllServiceOfUser(int userID);
    ArrayList<ServiceEntity> getAllServiceOfProfessional(int profID);
    long getRating(RegisterEntity user);
    void setRating(ServiceEntity serviceEntity, int rating);
    List<ServiceEntity> getServicesForProf(RegisterEntity user);
    List<ServiceEntity> getSubServicesForProf(RegisterEntity user, boolean fulfilled);
    ServiceEntity getServiceById(int id);
    List<ServiceEntity> getServicesForUser(RegisterEntity user);
    List<ServiceEntity> getSubServicesForUser(RegisterEntity user, boolean fulfilled);
    void updateService(ServiceEntity s);
}
