package dao;

import model.UserEntity;
import model.VerificationTokenEntity;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

/**
 * @author tsamo
 */
@Repository
public class VerificationTokenDAO implements VerificationTokenDAOInterface {

    @PersistenceContext
    private EntityManager em;

    @Override
    public UserEntity getUserFromToken(VerificationTokenEntity v) {
        return em.find(UserEntity.class, v.getUserId());
    }

    @Override
    public boolean checkIfTokenExists(String token) {
        Query query = em.createQuery("SELECT v FROM VerificationTokenEntity v WHERE v.token= :token");
        query.setParameter("token", token);
        ArrayList<VerificationTokenEntity> tokenEntities = (ArrayList<VerificationTokenEntity>) query.getResultList();
        boolean flag;
        flag = tokenEntities.size() != 0;
        return flag;
    }

    @Override
    public VerificationTokenEntity getTokenEntityFromToken(String token) {
        Query query = em.createQuery("SELECT v FROM VerificationTokenEntity v WHERE v.token= :token");
        query.setParameter("token", token);
        return (VerificationTokenEntity) query.getSingleResult();
    }

    @Override
    public boolean checkIfTimeLessThan24Hours(Timestamp timestamp) {
        boolean flag;
        Timestamp timestamp2 = new Timestamp(new Date().getTime());
        long now = timestamp2.getTime();
        long then = timestamp.getTime();
        flag = now - then <= 86400000;
        return flag;
    }

    @Override
    public Timestamp getTimestampOfTokenCreation(String token) {
        Query query = em.createQuery("SELECT v.generatedTokenDateTime FROM VerificationTokenEntity v WHERE v.token= :token");
        query.setParameter("token", token);
        return (Timestamp) query.getSingleResult();
    }

    @Override
    @Transactional
    public void createTokenForUser(int userId) {
        if (tokenForUserExists(userId)) {
            String originaltoken = getTokenOfUser(userId);
            VerificationTokenEntity v = getTokenEntityFromToken(originaltoken);
            v.setGeneratedTokenDateTime(new Timestamp(new Date().getTime()));
            int length = 20;
            boolean useLetters = true;
            boolean useNumbers = true;
            String token = RandomStringUtils.random(length, useLetters, useNumbers);
            v.setToken(token);
            em.merge(v);
        } else {
            VerificationTokenEntity v = new VerificationTokenEntity();
            v.setUserId(userId);
            v.setGeneratedTokenDateTime(new Timestamp(new Date().getTime()));
            int length = 20;
            boolean useLetters = true;
            boolean useNumbers = true;
            String token = RandomStringUtils.random(length, useLetters, useNumbers);
            v.setToken(token);
            em.persist(v);
        }
    }

    @Override
    public boolean tokenForUserExists(int userId) {
        boolean flag;
        Query query = em.createQuery("SELECT v FROM VerificationTokenEntity v WHERE v.userId= :userId");
        query.setParameter("userId", userId);
        ArrayList<VerificationTokenEntity> tokenEntities = (ArrayList<VerificationTokenEntity>) query.getResultList();
        flag = tokenEntities.size() != 0;
        return flag;
    }

    @Override
    public String getTokenOfUser(int userId) {
        Query query = em.createQuery("SELECT v.token FROM VerificationTokenEntity v WHERE v.userId= :userId");
        query.setParameter("userId", userId);
        return (String) query.getSingleResult();
    }

    @Override
    @Modifying
    @Transactional
    public int removeTokenByUserId(int userId) {
        Query query = em.createQuery("DELETE FROM VerificationTokenEntity v WHERE v.userId= :userId");
        query.setParameter("userId", userId);
        return query.executeUpdate();
    }
}