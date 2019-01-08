package utils;


import model.MessageEntity;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import javax.sql.DataSource;
import javax.sql.rowset.serial.SerialException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author tsamo
 */
public class DBUtils {

    public static Connection getConnection() {
        Connection conn = null;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/dmng");
            conn = ds.getConnection();
        } catch (NamingException ex) {
            Logger.getLogger(DBUtils.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DBUtils.class.getName()).log(Level.SEVERE, null, ex);
        }
        return conn;
    }

    public static boolean isNullOrBlank(String s) {
        return (s == null || s.trim().equals(""));
    }


    public static void insertIntoDB(MessageEntity message) {

        try {
            DBUtils db = new DBUtils();
            Connection conncection = db.getConnection();
            String sql = "INSERT INTO message VALUES (NULL,?,?,?,?,?)";
            PreparedStatement pstm = null;

            pstm = conncection.prepareStatement(sql);
            pstm.setInt(1, message.getSenderId());
            pstm.setInt(2, message.getReceiverId());
            pstm.setString(3, message.getData());
            pstm.setTimestamp(4, message.getTimeSent());
            pstm.setInt(5, message.getServiceId());


            pstm.executeUpdate();

            pstm.close();
            conncection.close();
        } catch (SerialException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}