package dao.doctor;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db?sslMode=REQUIRED";
    private static final String USER = "avnadmin";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String password = System.getenv("DB_PASSWORD");
        if (password == null) {
            password = ""; // fallback if not set
        }
        return DriverManager.getConnection(URL, USER, password);
    }
}
