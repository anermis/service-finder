package dao;

import model.*;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * @author tsamo
 */
@Repository
public class UserDAO implements UserDAOInterface {

    @PersistenceContext
    private EntityManager em;

    @Override
    @Transactional
    public void insertUser(UserEntity u) {
        int length = 20;
        boolean useLetters = true;
        boolean useNumbers = true;
        String originalPassword = u.getPasswordHash();
        String passwordsalt = RandomStringUtils.random(length, useLetters, useNumbers);
        String preHashPassword = originalPassword + passwordsalt;
        String hashedPassword = DigestUtils.sha512Hex(preHashPassword);
        u.setPasswordSalt(passwordsalt);
        u.setPasswordHash(hashedPassword);
        em.persist(u);
    }

    @Override
    @Transactional
    public void insertAddress(AddressEntity a, int userid) {
        a.setUserId(userid);
        em.persist(a);
    }

    @Override
    @Transactional
    public void insertPhone(PhoneEntity p, int userid) {
        p.setUserId(userid);
        em.persist(p);
    }

    @Override
    public UserEntity findUserByEmail(String email) {
        Query query = em.createQuery("SELECT u FROM UserEntity u WHERE u.email= :email");
        query.setParameter("email", email);
        return (UserEntity) query.getSingleResult();
    }

    @Override
    public boolean userExists(String email) {
        boolean flag;
        Query query = em.createQuery("SELECT u FROM UserEntity u WHERE u.email='" + email + "'");
        ArrayList<UserEntity> users = (ArrayList<UserEntity>) query.getResultList();
        flag = users.size() != 0;
        return flag;
    }

    @Override
    public boolean userExistsId(int userID) {
        boolean flag;
        Query query = em.createQuery("SELECT u FROM UserEntity u WHERE u.id=" + userID);
        ArrayList<UserEntity> users = (ArrayList<UserEntity>) query.getResultList();
        flag = users.size() != 0;
        return flag;
    }

    @Override
    @Transactional
    public void enableUser(UserEntity u) {
        u.setEnabled(true);
        em.merge(u);
    }

    @Override
    public int getUserid(UserEntity user) {
        Query query = em.createQuery("SELECT u.id FROM UserEntity u WHERE u.email= :email");
        query.setParameter("email", user.getEmail());
        return (Integer) query.getSingleResult();
    }

    @Override
    public String getSalt(String email) {
        Query query = em.createQuery("SELECT u.passwordSalt FROM UserEntity u WHERE u.email= :email");
        query.setParameter("email", email);
        return (String) query.getSingleResult();
    }

    @Override
    public boolean isUserActivated(String email) {
        Query query = em.createQuery("SELECT u.enabled FROM UserEntity u WHERE u.email= :email");
        query.setParameter("email", email);
        return (boolean) query.getSingleResult();
    }

    @Override
    @Transactional
    public void changePasswordOfUser(String email, String newPassword) {
        Query query = em.createQuery("SELECT u FROM UserEntity u WHERE u.email= :email");
        query.setParameter("email", email);
        UserEntity u = (UserEntity) query.getSingleResult();
        int length = 20;
        boolean useLetters = true;
        boolean useNumbers = true;
        String passwordsalt = RandomStringUtils.random(length, useLetters, useNumbers);
        String preHashPassword = newPassword + passwordsalt;
        String hashedPassword = DigestUtils.sha512Hex(preHashPassword);
        u.setPasswordSalt(passwordsalt);
        u.setPasswordHash(hashedPassword);
        em.merge(u);
    }

    @Override
    @Transactional
    public RegisterEntity getUserByEmail(String email) {
        Query query = em.createQuery("SELECT u, p, a, ph FROM UserEntity u " +
                "LEFT JOIN ProfessionsEntity p ON u.professionId = p.id " +
                "LEFT JOIN AddressEntity a ON u.id = a.userId " +
                "LEFT JOIN PhoneEntity ph ON u.id = ph.userId " +
                "WHERE u.email='" + email + "'");
        List<Object[]> objs = query.getResultList();
        if (objs.size()==0) return null;
        Object[] result = objs.get(0);
        RegisterEntity user = new RegisterEntity();
        user.setUserEntity((UserEntity)result[0]);
        user.setProfessionsEntity((ProfessionsEntity)result[1]);
        user.setAddressEntity((AddressEntity)result[2]);
        user.setPhoneEntity((PhoneEntity)result[3]);
        user.getUserEntity().setProfilePicture(setProfilePicture(user.getUserEntity())); //call method for setting profile Picture
        return user;
    }

    @Override
    @Transactional
    public RegisterEntity getUserByID(int userID) {
        Query query = em.createQuery("SELECT u, p, a, ph FROM UserEntity u " +
                "LEFT JOIN ProfessionsEntity p ON u.professionId = p.id " +
                "LEFT JOIN AddressEntity a ON u.id = a.userId " +
                "LEFT JOIN PhoneEntity ph ON u.id = ph.userId " +
                "WHERE u.id=" + userID);
        List<Object[]> objs = query.getResultList();
        if (objs.size()==0) return null;
        Object[] result = objs.get(0);
        RegisterEntity user = new RegisterEntity();
        user.setUserEntity((UserEntity)result[0]);
        user.setProfessionsEntity((ProfessionsEntity)result[1]);
        user.setAddressEntity((AddressEntity)result[2]);
        user.setPhoneEntity((PhoneEntity)result[3]);
        user.getUserEntity().setProfilePicture(setProfilePicture(user.getUserEntity())); //call method for setting profile Picture
        return user;
    }

    @Override
    @Transactional
    public RegisterEntity editUser(RegisterEntity originalEntity, RegisterEntity updatedUser) {
        if (!(originalEntity.getUserEntity().getFirstName().equals(updatedUser.getUserEntity().getFirstName()))) {
            originalEntity.getUserEntity().setFirstName(updatedUser.getUserEntity().getFirstName());
        }
        if (!(originalEntity.getUserEntity().getLastName().equals(updatedUser.getUserEntity().getLastName()))) {
            originalEntity.getUserEntity().setLastName(updatedUser.getUserEntity().getLastName());
        }
        if (!(originalEntity.getUserEntity().getEmail().equals(updatedUser.getUserEntity().getEmail()))) {
            originalEntity.getUserEntity().setEmail(updatedUser.getUserEntity().getEmail());
        }
        if (!(originalEntity.getPhoneEntity().getMobile().equals(updatedUser.getPhoneEntity().getMobile()))) {
            originalEntity.getPhoneEntity().setMobile(updatedUser.getPhoneEntity().getMobile());
        }
        if (!(originalEntity.getPhoneEntity().getLandline().equals(updatedUser.getPhoneEntity().getLandline()))) {
            originalEntity.getPhoneEntity().setLandline(updatedUser.getPhoneEntity().getLandline());
        }
        em.merge(originalEntity.getUserEntity());
        em.merge(originalEntity.getAddressEntity());
        em.merge(originalEntity.getPhoneEntity());

        return originalEntity;
    }

    //set profile Picture
    @Override
    public String setProfilePicture(UserEntity userEntity) {
        int id = userEntity.getId();
        String pathJPG = "C:\\Tomcat\\webapps\\images\\"+id+".jpg";
        String pathPNG = "C:\\Tomcat\\webapps\\images\\"+id+".jpg";
        File filenameJPG = new File(pathJPG);
        File filenamePNG = new File(pathPNG);
        if ((filenameJPG.exists() && !filenameJPG.isDirectory())) {
            return id + ".jpg";
        } else if ((filenamePNG.exists() && !filenamePNG.isDirectory())) {
            return id + ".png";
        } else {
            return "dmng.png";
        }
    }
}