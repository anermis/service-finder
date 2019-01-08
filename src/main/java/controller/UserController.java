package controller;

import dao.*;
import model.ProfessionsEntity;
import model.RegisterEntity;
import model.ServiceEntity;
import model.UserEntity;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import validation.EditFormValids;
import validation.PasswordFormValids;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

/**
 * @author tsamo
 */
@Controller
@RequestMapping(value = "/user")
public class UserController {

    @Autowired
    private ProfessionsDAOInterface p;

    @Autowired
    ServletContext servletContext;

    @Autowired
    private UserDAOInterface u;

    @Autowired
    private VerificationTokenDAOInterface v;

    @Autowired
    private ServiceDAOInterface s;

    @Autowired
    private MessageDAOInterface m;

    @Autowired
    private EditFormValids editFormValids;

    @Autowired
    private PasswordFormValids passwordFormValids;

    @RequestMapping(value = "/account.htm")
    public String account(ModelMap model, HttpSession session) {
        RegisterEntity userInSession = new RegisterEntity((RegisterEntity) session.getAttribute("user"));
        model.addAttribute("userInSession", userInSession);
        model.addAttribute("userInFormPassword", new UserEntity());
        return "profile";
    }

    @RequestMapping(value = "/edited.htm", method = RequestMethod.POST, consumes = {MediaType.ALL_VALUE})
    public String profileUpdate(ModelMap model, @ModelAttribute("userInSession") @Valid RegisterEntity updatedUser, BindingResult bindingResult,
                                HttpSession session) {
        editFormValids.validate(updatedUser, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("userInSession", updatedUser);
            model.addAttribute("userInFormPassword", new UserEntity());
            model.addAttribute("message", "Update was not successful");
        } else {
            RegisterEntity sessionEntity = (RegisterEntity) session.getAttribute("user");
            RegisterEntity originalEntity = u.getUserByEmail(sessionEntity.getUserEntity().getEmail());
            RegisterEntity updatedEntity = u.editUser(originalEntity, updatedUser);
            session.setAttribute("user", updatedEntity);
            model.addAttribute("userInSession", updatedEntity);
            model.addAttribute("userInFormPassword", new UserEntity());
            model.addAttribute("message", "Profile updated successfully");
        }
        return "profile";
    }

    @RequestMapping(value = "/pass.htm", method = RequestMethod.POST)
    public String passwordUpdate(ModelMap model, @ModelAttribute("userInFormPassword") UserEntity user, BindingResult bindingResult,
            HttpSession session) {
        RegisterEntity userInSession =(RegisterEntity) session.getAttribute("user");
        passwordFormValids.validate(user, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("userInSession", userInSession);
            model.addAttribute("userInFormPassword", new UserEntity());
            model.addAttribute("message", "Could not update password");
        } else {                 
            u.changePasswordOfUser(userInSession.getUserEntity().getEmail() , user.getPasswordHash());
            model.addAttribute("userInFormPassword", new UserEntity());
            model.addAttribute("userInSession", userInSession);
            model.addAttribute("message", "Password updated successfully");
        }
        return "profile";
    }

    @RequestMapping(value = "/search.htm")
    public String Search() {
        return "search";
    }

    @RequestMapping(value = "/fileUpload", method = RequestMethod.POST)
    public ResponseEntity<String> fileUpload(@RequestParam("uploaded") MultipartFile file, HttpSession session)
            throws IOException {
        String extension = FilenameUtils.getExtension(file.getOriginalFilename());
        RegisterEntity user = new RegisterEntity((RegisterEntity)session.getAttribute("user"));
        int idForFilename = user.getUserEntity().getId();
        String newFilename = String.valueOf(idForFilename);
        // Save file on system
        if (!file.getOriginalFilename().isEmpty()) {
            File previousFileToDeleteJPG = new File("C:\\Tomcat\\webapps\\images\\"+user.getUserEntity().getId()+".jpg");
            File previousFileToDeletePNG = new File("C:\\Tomcat\\webapps\\images\\"+user.getUserEntity().getId()+".png");
            previousFileToDeleteJPG.delete();
            previousFileToDeletePNG.delete();
            BufferedOutputStream outputStream = new BufferedOutputStream(
                    new FileOutputStream( new File("C:\\Tomcat\\webapps\\images\\", newFilename.concat("."+extension))));
            user.getUserEntity().setProfilePicture(newFilename.concat("."+extension));
            session.setAttribute("user", user);
            outputStream.write(file.getBytes());
            outputStream.flush();
            outputStream.close();
            return new ResponseEntity<>("File Uploaded Successfully.", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("Invalid file.", HttpStatus.BAD_REQUEST);
        }
    }


    @RequestMapping(value = "/rate", method = RequestMethod.GET)
    public ResponseEntity<String> rating(@RequestParam("selected_rating") int rateNumber, @RequestParam("serviceid") int serviceId) {
        ServiceEntity service = s.getServiceById(serviceId);
        s.setRating(service, rateNumber);
        return new ResponseEntity<>("Rate submitted successfully.", HttpStatus.OK);
    }


    @RequestMapping("/logout.htm")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/home/initialForm.htm";
    }

    @RequestMapping(value = "/viewselectedprof.htm", method = RequestMethod.GET)
    public String selected(ModelMap model, HttpSession session, @RequestParam(value = "email") String email) {
        RegisterEntity user = u.getUserByEmail(email);
        if (user.getUserEntity().getProfessionId() == 1)
            return "search";
        else {
            long rating = s.getRating(user);
            model.addAttribute("selectedUser", user);
            model.addAttribute("rating", rating);
            return "viewSelectedUserInfo";
        }
    }

    @RequestMapping("/page.htm")
    public String selected(ModelMap model, HttpSession session) {
        RegisterEntity selectedUser = new RegisterEntity((RegisterEntity) session.getAttribute("user"));
        model.addAttribute("selectedUser", selectedUser);
        return "viewSelectedUserInfo";
    }

    @RequestMapping(value = "/viewselectedcategoryofprof.htm", method = RequestMethod.GET)
    public String viewselectedcategoryofprof(ModelMap model, @RequestParam(value = "categoryidofprof") int categoryidofprof) {
        List<RegisterEntity> profs = p.getProfs(categoryidofprof);
        for (RegisterEntity re:profs) {
            re.getUserEntity().setProfilePicture(u.setProfilePicture(re.getUserEntity()));
        }
        ProfessionsEntity thiscategory = p.getProfession(categoryidofprof);
        model.addAttribute("allprofswithsamecategoryid", profs);
        model.addAttribute("thiscategory", thiscategory);
        return "selectedcategoryofprof";
    }

    @RequestMapping(value = "/chat/{userIDString}")
    public String handleForm(@PathVariable String userIDString, HttpSession session, ModelMap modelMap) {
        RegisterEntity sessionUser = new RegisterEntity((RegisterEntity) session.getAttribute("user"));
        int user1ID = Integer.parseInt(userIDString);
        if (u.userExistsId(user1ID)) {
            session.setAttribute("user1ID", user1ID);
            session.setAttribute("user2ID", sessionUser.getUserEntity().getId());
            session.setAttribute("user1Name", u.getUserByID(user1ID).getUserEntity().getFirstName());
            session.setAttribute("user2Name", sessionUser.getUserEntity().getFirstName());
            int id = s.returnIfServiceExists(user1ID, sessionUser.getUserEntity().getId());
            if (id == 0) {
                ServiceEntity se = new ServiceEntity();
                se.setProfessionalId(user1ID);
                se.setCustomerId(sessionUser.getUserEntity().getId());
                se.setStartDate(Timestamp.from(Instant.now()));
                id = s.insertService(se).getId();
            }
            ArrayList<ServiceEntity> servicesOfcurrentUser = new ArrayList<>();
            ArrayList<UserEntity> currentConnectedUsersOrProfs = new ArrayList<>();
            if (sessionUser.getUserEntity().getProfessionId() == 1) {
                servicesOfcurrentUser = s.getAllServiceOfUser(sessionUser.getUserEntity().getId());
                for (ServiceEntity sa : servicesOfcurrentUser) {
                    UserEntity user = u.getUserByID(sa.getProfessionalId()).getUserEntity();
                    if (!currentConnectedUsersOrProfs.contains(user)) {
                        currentConnectedUsersOrProfs.add(user);
                    }
                }
            } else {
                servicesOfcurrentUser = s.getAllServiceOfProfessional(sessionUser.getUserEntity().getId());
                for (ServiceEntity sa : servicesOfcurrentUser) {
                    UserEntity user = u.getUserByID(sa.getCustomerId()).getUserEntity();
                    if (!currentConnectedUsersOrProfs.contains(user)) {
                        currentConnectedUsersOrProfs.add(user);
                    }
                }
            }
            modelMap.addAttribute("sessionUser", sessionUser);
            modelMap.addAttribute("usersSessionChats", servicesOfcurrentUser);
            modelMap.addAttribute("profs", currentConnectedUsersOrProfs);
            modelMap.addAttribute("currentSessionsMessages", m.getServicesMessages(id));
            modelMap.addAttribute("currentSession", s.getServiceByID(id));
            modelMap.addAttribute("currentSessionRecipient", u.getUserByID(user1ID));
            session.setAttribute("serviceID", id);
            return "chatPageTest";
        } else {
            return "404";
        }
    }

    @RequestMapping(value = "/servicesession.htm")
    public String serviceSession(@RequestParam("sessionId") int sessionId, ModelMap map,HttpSession session) {
        ServiceEntity service = s.getServiceById(sessionId);
        service.setOtherUser(u.getUserByID(service.getProfessionalId()));
        map.addAttribute("service", service);
        session.setAttribute("service", service);
        return "serviceSession";
    }

    @RequestMapping(value = "/endService.htm",method = RequestMethod.GET)
    public String endService(ModelMap map, HttpSession session) {
        ServiceEntity serviceEntity=(ServiceEntity)session.getAttribute("service");
        serviceEntity.setFulfilled(true);
        s.updateService(serviceEntity);
        map.addAttribute("service",serviceEntity);
        session.setAttribute("service",serviceEntity);
        return "serviceSession";
    }

    @RequestMapping("/services.htm")
    public String services(ModelMap map, HttpSession session) {
        RegisterEntity user = (RegisterEntity) session.getAttribute("user");
        List<ServiceEntity> services = s.getServicesForUser(user);
        for (ServiceEntity service: services) service.setOtherUser(u.getUserByID(service.getProfessionalId()));
        map.addAttribute("services", services);
        map.addAttribute("message", "My Services");
        return "sessions";
    }

    @RequestMapping("/closedServices.htm")
    public String closedServices(ModelMap map, HttpSession session) {
        RegisterEntity user = (RegisterEntity) session.getAttribute("user");
        List<ServiceEntity> services = s.getSubServicesForUser(user, true);
        for (ServiceEntity service: services) service.setOtherUser(u.getUserByID(service.getProfessionalId()));
        map.addAttribute("services", services);
        map.addAttribute("professionId", user.getUserEntity().getProfessionId());
        map.addAttribute("message", "Closed Services");
        return "sessions";
    }

    @RequestMapping("/activeServices.htm")
    public String activeServices(ModelMap map, HttpSession session) {
        RegisterEntity user = (RegisterEntity) session.getAttribute("user");
        List<ServiceEntity> services = s.getSubServicesForUser(user, false);
        for (ServiceEntity service: services) service.setOtherUser(u.getUserByID(service.getProfessionalId()));
        map.addAttribute("services", services);
        map.addAttribute("professionId", user.getUserEntity().getProfessionId());
        map.addAttribute("message", "Active Services");
        return "sessions";
    }
}