package dao;

import model.RegisterEntity;
import model.ServiceEntity;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.List;

/**
 * @author tsamo
 */

@Repository
public class ServiceDAO implements ServiceDAOInterface {

    @PersistenceContext
    private EntityManager em;

    @Override
    public int returnIfServiceExists(int customerID, int professionalID) {
        int flag;
        Query query = em.createQuery("SELECT s FROM ServiceEntity s WHERE (s.customerId= :customerId AND s.professionalId= :professionalId AND s.fulfilled=false) OR (s.customerId= :professionalId AND s.professionalId= :customerId AND s.fulfilled=false) ");
        query.setParameter("customerId", customerID);
        query.setParameter("professionalId", professionalID);
        ArrayList<ServiceEntity> services = (ArrayList<ServiceEntity>) query.getResultList();
        if (services.size() == 0) {
            flag = 0;
        } else {
            flag = services.get(0).getId();
        }
        return flag;
    }

    @Override
    @Transactional
    public ServiceEntity insertService(ServiceEntity serviceEntity) {
        em.persist(serviceEntity);
        return serviceEntity;
    }

    @Override
    public ServiceEntity getServiceByID(int serviceID) {
        return em.getReference(ServiceEntity.class, serviceID);
    }

    @Override
    public ArrayList<ServiceEntity> getAllServiceOfUser(int userID) {
        Query query = em.createQuery("SELECT s FROM ServiceEntity s WHERE s.customerId= :customerId");
        query.setParameter("customerId", userID);
        return (ArrayList<ServiceEntity>) query.getResultList();
    }

    @Override
    public ArrayList<ServiceEntity> getAllServiceOfProfessional(int profID) {
        Query query = em.createQuery("SELECT s FROM ServiceEntity s WHERE s.professionalId= :professionalId");
        query.setParameter("professionalId", profID);
        return (ArrayList<ServiceEntity>) query.getResultList();
    }

    @Override
    public long getRating(RegisterEntity user) {
        int id = user.getUserEntity().getId();
        try{
            Query query = em.createQuery("SELECT SUM(s.rating)/count(s.customerId) FROM ServiceEntity s WHERE s.professionalId = :id AND rating is not null");
            query.setParameter("id", id);
        List<Long> list = (List<Long>)query.getResultList();
        if(list.isEmpty()) return 0;
        return list.get(0);
        }catch(Exception e){
             e.printStackTrace();
             return 0;
        }
    }

    @Override
    @Transactional
    public void setRating(ServiceEntity serviceEntity, int rating) {
        serviceEntity.setRating(rating);
        em.merge(serviceEntity);
    }

    @Override
    public List<ServiceEntity> getServicesForProf(RegisterEntity user) {
        Query query = em.createQuery("SELECT s FROM ServiceEntity s WHERE s.professionalId = :id");
        query.setParameter("id", user.getUserEntity().getId());
        return (List<ServiceEntity>)query.getResultList();
    }

    @Override
    public List<ServiceEntity> getSubServicesForProf(RegisterEntity user, boolean fulfilled) {
        Query query = em.createQuery("SELECT s FROM ServiceEntity s WHERE s.professionalId = :id " +
                "AND s.fulfilled = :active");
        query.setParameter("id", user.getUserEntity().getId());
        query.setParameter("active", fulfilled);
        return (List<ServiceEntity>)query.getResultList();
    }

    @Override
    public List<ServiceEntity> getServicesForUser(RegisterEntity user) {
        Query query = em.createQuery("SELECT s FROM ServiceEntity s WHERE s.customerId = :id");
        query.setParameter("id", user.getUserEntity().getId());
        return (List<ServiceEntity>)query.getResultList();
    }

    @Override
    public List<ServiceEntity> getSubServicesForUser(RegisterEntity user, boolean fulfilled) {
        Query query = em.createQuery("SELECT s FROM ServiceEntity s WHERE s.customerId = :id " +
                "AND s.fulfilled = :active");
        query.setParameter("id", user.getUserEntity().getId());
        query.setParameter("active", fulfilled);
        return (List<ServiceEntity>)query.getResultList();
    }

    @Override
    public ServiceEntity getServiceById(int id){
        return em.find(ServiceEntity.class, id);
    }

    @Override
    @Transactional
    public void updateService(ServiceEntity s) {
        em.merge(s);
    }
}