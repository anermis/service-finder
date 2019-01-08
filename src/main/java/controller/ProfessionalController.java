package controller;

import dao.MessageDAOInterface;
import dao.ServiceDAOInterface;
import dao.UserDAOInterface;
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

@Controller
@RequestMapping("/prof")
public class ProfessionalController {

    @Autowired
    private ServiceDAOInterface serviceDAO;

    @Autowired
    private UserDAOInterface userDAO;

    @Autowired
    private MessageDAOInterface messageDAO;

    @Autowired
    private EditFormValids editFormValids;

    @RequestMapping("/services.htm")
    public String services(ModelMap map, HttpSession session) {
        RegisterEntity user = (RegisterEntity) session.getAttribute("user");
        List<ServiceEntity> services = serviceDAO.getServicesForProf(user);
        for (ServiceEntity service: services) service.setOtherUser(userDAO.getUserByID(service.getCustomerId()));
        map.addAttribute("services", services);
        map.addAttribute("message", "My Services");
        return "sessions";
    }

    @RequestMapping(value = "/editService.htm", method = RequestMethod.POST)
    public String editService(ModelMap map, @ModelAttribute("service") @Valid ServiceEntity service, HttpSession session) {
        ServiceEntity serviceEntity = (ServiceEntity) session.getAttribute("service");
        serviceEntity.setCost(service.getCost());
        serviceEntity.setTopic(service.getTopic());
        serviceDAO.updateService(serviceEntity);
        session.setAttribute("service", serviceEntity);
        map.addAttribute("service", serviceEntity);
        return "serviceSession";
    }

    @RequestMapping(value = "/closedServices.htm")
    public String activeServices(ModelMap map, HttpSession session) {
        RegisterEntity user = (RegisterEntity) session.getAttribute("user");
        List<ServiceEntity> services = serviceDAO.getSubServicesForProf(user, true);
        for (ServiceEntity service: services) service.setOtherUser(userDAO.getUserByID(service.getCustomerId()));
        map.addAttribute("services", services);
        map.addAttribute("message", "Closed Services");
        return "sessions";
    }

    @RequestMapping(value = "/activeServices.htm")
    public String closedServices(ModelMap map, HttpSession session) {
        RegisterEntity user = (RegisterEntity) session.getAttribute("user");
        List<ServiceEntity> services = serviceDAO.getSubServicesForProf(user, false);
        for (ServiceEntity service: services) service.setOtherUser(userDAO.getUserByID(service.getCustomerId()));
        map.addAttribute("services", services);
        map.addAttribute("message", "Active Services");
        return "sessions";
    }

    @RequestMapping(value = "/chat/{userIDString}")
    public String handleForm(@PathVariable String userIDString, HttpSession session, ModelMap modelMap) {
        RegisterEntity sessionUser = new RegisterEntity((RegisterEntity) session.getAttribute("user"));
        int user1ID = Integer.parseInt(userIDString);
        if (userDAO.userExistsId(user1ID)) {
            session.setAttribute("user1ID", user1ID);
            session.setAttribute("user2ID", sessionUser.getUserEntity().getId());
            session.setAttribute("user1Name", userDAO.getUserByID(user1ID).getUserEntity().getFirstName());
            session.setAttribute("user2Name", sessionUser.getUserEntity().getFirstName());
            int id = serviceDAO.returnIfServiceExists(user1ID, sessionUser.getUserEntity().getId());
            if (id == 0) {
                ServiceEntity se = new ServiceEntity();
                se.setProfessionalId(user1ID);
                se.setCustomerId(sessionUser.getUserEntity().getId());
                se.setStartDate(Timestamp.from(Instant.now()));
                id = serviceDAO.insertService(se).getId();
            }
            ArrayList<ServiceEntity> servicesOfcurrentUser;
            ArrayList<UserEntity> currentConnectedUsersOrProfs = new ArrayList<>();
            if (sessionUser.getUserEntity().getProfessionId() == 1) {
                servicesOfcurrentUser = serviceDAO.getAllServiceOfUser(sessionUser.getUserEntity().getId());
                for (ServiceEntity sa : servicesOfcurrentUser) {
                    UserEntity u = userDAO.getUserByID(sa.getCustomerId()).getUserEntity();
                    if (!currentConnectedUsersOrProfs.contains(u)) {
                        currentConnectedUsersOrProfs.add(u);
                    }
                }
            } else {
                servicesOfcurrentUser = serviceDAO.getAllServiceOfProfessional(sessionUser.getUserEntity().getId());
                for (ServiceEntity sa : servicesOfcurrentUser) {
                    UserEntity u = userDAO.getUserByID(sa.getCustomerId()).getUserEntity();
                    if (!currentConnectedUsersOrProfs.contains(u)) {
                        currentConnectedUsersOrProfs.add(u);
                    }
                }
            }
            modelMap.addAttribute("sessionUser", sessionUser);
            modelMap.addAttribute("usersSessionChats", servicesOfcurrentUser);
            modelMap.addAttribute("profs", currentConnectedUsersOrProfs);
            modelMap.addAttribute("currentSessionsMessages", messageDAO.getServicesMessages(id));
            modelMap.addAttribute("currentSession", serviceDAO.getServiceByID(id));
            modelMap.addAttribute("currentSessionRecipient", userDAO.getUserByID(user1ID));
            session.setAttribute("serviceID", id);
            return "chatPageTest";
        } else {
            return "404";
        }
    }

    @RequestMapping(value = "/logout.htm")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/home/initialForm.htm";
    }

    @RequestMapping(value = "/account.htm")
    public String account(ModelMap model, HttpSession session) {
        RegisterEntity userInSession = new RegisterEntity((RegisterEntity) session.getAttribute("user"));

        if (userInSession.getUserEntity().getProfessionId() == 1)
            return "redirect:/home/initialForm.htm";
        else {
            model.addAttribute("userInSession", userInSession);
            model.addAttribute("userInFormPassword", new UserEntity());
            long rating = serviceDAO.getRating(userInSession);
            model.addAttribute("rating", rating);
            return "profileProfessional";
        }
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

    @RequestMapping(value = "/edited.htm", method = RequestMethod.POST, consumes = {MediaType.ALL_VALUE})
    public String profileUpdate(ModelMap model, @ModelAttribute("userInSession") @Valid RegisterEntity updatedUser, BindingResult bindingResult,
                                HttpSession session) {
        editFormValids.validate(updatedUser, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("userInSession", updatedUser);
            model.addAttribute("userInFormPassword", new UserEntity());
            long rating = serviceDAO.getRating(updatedUser);
            model.addAttribute("rating", rating);
            model.addAttribute("message", "Update was not successful");
        } else {
            RegisterEntity sessionEntity = (RegisterEntity) session.getAttribute("user");
            RegisterEntity originalEntity = userDAO.getUserByEmail(sessionEntity.getUserEntity().getEmail());
            RegisterEntity updatedEntity = userDAO.editUser(originalEntity, updatedUser);
            session.setAttribute("user", updatedEntity);
            model.addAttribute("userInSession", updatedEntity);
            model.addAttribute("userInFormPassword", new UserEntity());
            long rating = serviceDAO.getRating(updatedEntity);
            model.addAttribute("rating", rating);
            model.addAttribute("message", "Profile updated successfully");
        }
        return "profileProfessional";
    }

    @RequestMapping(value = "/servicesession.htm")
    public String serviceSession(@RequestParam("sessionId") int sessionId, ModelMap map, HttpSession session) {
        ServiceEntity service = serviceDAO.getServiceById(sessionId);
        service.setOtherUser(userDAO.getUserByID(service.getCustomerId()));
        map.addAttribute("service", service);
        session.setAttribute("service", service);
        return "serviceSession";
    }

}
