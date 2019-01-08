package dao;


import model.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nah
 */

@Repository
public class ProfessionsDAO implements ProfessionsDAOInterface {

    @PersistenceContext
    private EntityManager em;

    @Override
    @Transactional
    public List<ProfessionsEntity> getAllProfessions() {
        Query query = em.createQuery("SELECT p FROM ProfessionsEntity p WHERE p.id<>1");
        return (List<ProfessionsEntity>) query.getResultList();
    }

    @Override
    @Transactional
    public ProfessionsEntity getProfession(int id) {
        Query query = em.createQuery("SELECT p FROM ProfessionsEntity p WHERE p.id= :pId");
        query.setParameter("pId", id);
        return (ProfessionsEntity) query.getSingleResult();
    }

    @Override
    @Transactional
    public List<RegisterEntity> getProfs(int id) {
        List<RegisterEntity> profs = new ArrayList<>();
        Query query = em.createQuery("SELECT u, p, a, ph FROM UserEntity u " +
                "LEFT JOIN ProfessionsEntity p ON u.professionId = p.id " +
                "LEFT JOIN AddressEntity a ON u.id = a.userId " +
                "LEFT JOIN PhoneEntity ph ON u.id = ph.userId " +
                "WHERE p.id = :id");
        query.setParameter("id", id);
        return getRegisterEntities(profs, query);
    }

    @Override
    @Transactional
    public List<RegisterEntity> getProfsByLocation(int id, BigDecimal lng, BigDecimal lat, double distance) {
        List<RegisterEntity> profs = new ArrayList<>();
        Query query = em.createQuery("SELECT u, p, a, ph FROM UserEntity u " +
                "LEFT JOIN ProfessionsEntity p ON u.professionId = p.id " +
                "LEFT JOIN AddressEntity a ON u.id = a.userId " +
                "LEFT JOIN PhoneEntity ph ON u.id = ph.userId " +
                "WHERE p.id = :id AND ABS(a.longit - :longit)<(0.01*:dist) AND ABS(a.latit - :latit )<(0.01*:dist)");
        query.setParameter("id", id);
        query.setParameter("longit", lng);
        query.setParameter("latit", lat);
        query.setParameter("dist", distance);

        return getRegisterEntities(profs, query);
    }


    private List<RegisterEntity> getRegisterEntities(List<RegisterEntity> profs, Query query) {
        List<Object[]> objs = query.getResultList();
        if (objs.size()==0) return null;
        for (Object[] result: objs){
            RegisterEntity prof = new RegisterEntity();
            prof.setUserEntity((UserEntity)result[0]);
            prof.setProfessionsEntity((ProfessionsEntity)result[1]);
            prof.setAddressEntity((AddressEntity)result[2]);
            prof.setPhoneEntity((PhoneEntity)result[3]);
            profs.add(prof);
        }
        return profs;
    }
}
