package controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import dao.ProfessionsDAOInterface;
import dao.UserDAOInterface;
import model.RegisterEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.math.BigDecimal;
import java.util.List;
import java.util.function.Consumer;

/**
 * @author tsamo
 */
@RestController
public class SpringRest {

    @Autowired
    UserDAOInterface userDAOInterface;

    @Autowired
    ProfessionsDAOInterface professionsDAOInterface;

    @RequestMapping(value = "/mailREST.htm", method = RequestMethod.GET, headers = "Accept=*/*", produces = "application/json")
    public @ResponseBody
    String getAllUsersByRest(@RequestParam("email") String email) {
        boolean exists = userDAOInterface.userExists(email);
        return "{ \"exists\":" + exists + "}";
    }

    @RequestMapping(value = "/restProfs.htm", method = RequestMethod.POST, headers = "Accept=*/*", produces = "application/json")
    public @ResponseBody
    String getProfsByRest(@RequestParam("pro") int id, @RequestParam("long") BigDecimal lng, @RequestParam("lat") BigDecimal lat,
                          @RequestParam("distance") double distance) {
        List<RegisterEntity> profs = professionsDAOInterface.getProfsByLocation(id, lng, lat, distance);
        profs.stream().forEach(new Consumer<RegisterEntity>() {
            @Override
            public void accept(RegisterEntity re) {
                String picture = userDAOInterface.setProfilePicture(re.getUserEntity());
                re.getUserEntity().setProfilePicture(picture);
            }
        });
        ObjectMapper mapper = new ObjectMapper();
        String profsJSON = null;
        try {
            profsJSON = mapper.writeValueAsString(profs);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return profsJSON;
    }
}