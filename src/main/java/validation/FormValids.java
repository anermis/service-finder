package validation;

import model.RegisterEntity;
import org.hazlewood.connor.bottema.emailaddress.EmailAddressCriteria;
import org.hazlewood.connor.bottema.emailaddress.EmailAddressValidator;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 *
 * @author matina
 */
@Component
public class FormValids implements Validator{

    @Override
    public boolean supports(Class type) {
        return RegisterEntity.class.equals(type);
    }

    @Override
    public void validate(Object o, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userEntity.firstName", "first_name.empty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userEntity.lastName", "last_name.empty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userEntity.email", "email.empty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userEntity.passwordHash", "password_salt.empty");
        RegisterEntity r = (RegisterEntity) o;
        String patternName = "^[a-zA-Z]{2,}+$";
        String patternNameGreek = "^\\p{InGreek}{2,}+$";
        String patternEmail = "^([A-Za-z0-9_](\\.[A-Za-z0-9_])*){4,30}@[A-Za-z0-9_]+(\\.[A-Za-z0-9_]+)*(\\.[A-Za-z_]{2,})$";
        String patternPass = "[A-Za-z0-9#@$_]{6,30}";
        String patternPhone = "^([+]*)[0-9]{10,16}$";
        if(!r.getUserEntity().getFirstName().matches(patternName)&&!r.getUserEntity().getFirstName().matches(patternNameGreek)){
            errors.rejectValue("userEntity.firstName", "first_name.onlylettersallowed");
        }
        if(!r.getUserEntity().getLastName().matches(patternName)&&!r.getUserEntity().getLastName().matches(patternNameGreek)){
            errors.rejectValue("userEntity.lastName", "last_name.onlylettersallowed");
        }
        if(!r.getUserEntity().getEmail().matches(patternEmail)){
            errors.rejectValue("userEntity.email", "email.notvalid");
        }
        if (!EmailAddressValidator.isValid(r.getUserEntity().getEmail(), EmailAddressCriteria.RFC_COMPLIANT)) {
            errors.rejectValue("email", "email.notvalidformat");
        }
        if(!r.getUserEntity().getPasswordHash().matches(patternPass)){
            errors.rejectValue("userEntity.passwordHash", "password_salt.notvalid");
        }
        if(!r.getPhoneEntity().getLandline().matches(patternPhone)&&!r.getPhoneEntity().getLandline().isEmpty()){
            errors.rejectValue("phoneEntity.landline", "landline.notvalid");
        }
        if(!r.getPhoneEntity().getMobile().matches(patternPhone)){
            errors.rejectValue("phoneEntity.mobile", "mobile.notvalid");
        }
    }
}