package dao;


import model.ProfessionsEntity;
import model.RegisterEntity;

import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author Nah
 */


public interface ProfessionsDAOInterface {
    List<ProfessionsEntity> getAllProfessions();
    List<RegisterEntity> getProfs(int id);
    List<RegisterEntity> getProfsByLocation(int id, BigDecimal lng, BigDecimal lat, double distance);
    ProfessionsEntity getProfession(int id);
}
