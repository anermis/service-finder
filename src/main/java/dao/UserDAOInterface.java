package dao;

import model.AddressEntity;
import model.PhoneEntity;
import model.RegisterEntity;
import model.UserEntity;


/**
 * @author tsamo
 */
public interface UserDAOInterface {
    void insertUser(UserEntity u);
    void insertAddress(AddressEntity a, int userid);
    void insertPhone(PhoneEntity p, int userid);
    UserEntity findUserByEmail(String email);
    boolean userExists(String email);
    boolean userExistsId(int userID);
    void enableUser(UserEntity u);
    int getUserid(UserEntity u);
    String getSalt(String email);
    boolean isUserActivated(String email);
    void changePasswordOfUser(String email, String newPassword);
    RegisterEntity getUserByID (int userID);
    RegisterEntity getUserByEmail(String email);
    RegisterEntity editUser(RegisterEntity editUser , RegisterEntity user);
    String setProfilePicture(UserEntity userEntity);
}