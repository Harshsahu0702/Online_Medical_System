package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db?sslMode=REQUIRED";
    private static final String USER = "avnadmin";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println(e);
        }

        String password = System.getenv("DB_PASSWORD");
        return DriverManager.getConnection(URL, USER, password);
    }
}
