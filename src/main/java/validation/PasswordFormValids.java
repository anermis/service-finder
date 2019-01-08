package validation;

import model.UserEntity;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 *
 * @author Nah
 */
@Component
public class PasswordFormValids implements Validator{

    @Override
    public boolean supports(Class type) {
        return UserEntity.class.equals(type);
    }

    @Override
    public void validate(Object o, Errors errors) {        
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "passwordHash", "password_salt.empty");
        UserEntity r = (UserEntity) o;       
        String patternPass = "[A-Za-z0-9#@$_]{6,30}";
        
        if(!r.getPasswordHash().matches(patternPass)){
            errors.rejectValue("passwordHash", "password_salt.notvalid");
        }     
    }
}