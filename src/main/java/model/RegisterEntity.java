package model;

import javax.validation.Valid;


/**
 * @author tsamo
 */
public class RegisterEntity {
    @Valid
    private UserEntity userEntity;

    @Valid
    private PhoneEntity phoneEntity;

    @Valid
    private AddressEntity addressEntity;
    
    @Valid
    private ProfessionsEntity professionsEntity;

    public RegisterEntity() {
    }

    public RegisterEntity(RegisterEntity r){
        this.userEntity = new UserEntity(r.getUserEntity());
        this.phoneEntity = new PhoneEntity(r.getPhoneEntity());
        this.addressEntity = new AddressEntity(r.getAddressEntity());
        this.professionsEntity = new ProfessionsEntity(r.getProfessionsEntity());
    }

    @Valid
    public UserEntity getUserEntity() {
        return userEntity;
    }

    public void setUserEntity(UserEntity userEntity) {
        this.userEntity = userEntity;
    }

    @Valid
    public PhoneEntity getPhoneEntity() {
        return phoneEntity;
    }

    public void setPhoneEntity(PhoneEntity phoneEntity) {
        this.phoneEntity = phoneEntity;
    }

    @Valid
    public AddressEntity getAddressEntity() {
        return addressEntity;
    }

    public void setAddressEntity(AddressEntity addressEntity) {
        this.addressEntity = addressEntity;
    }

    @Valid
    public ProfessionsEntity getProfessionsEntity() {
        return professionsEntity;
    }

    public void setProfessionsEntity(ProfessionsEntity professionsEntity) {
        this.professionsEntity = professionsEntity;
    }

}
