package dao;

import model.UserEntity;
import model.VerificationTokenEntity;

import java.sql.Timestamp;

/**
 * @author tsamo
 */
public interface VerificationTokenDAOInterface {

    UserEntity getUserFromToken(VerificationTokenEntity v);
    boolean checkIfTokenExists(String token);
    VerificationTokenEntity getTokenEntityFromToken(String token);
    boolean checkIfTimeLessThan24Hours(Timestamp timestamp);
    Timestamp getTimestampOfTokenCreation(String token);
    void createTokenForUser(int userId);
    String getTokenOfUser(int userId);
    int removeTokenByUserId(int userId);
    boolean tokenForUserExists(int userId);
}
