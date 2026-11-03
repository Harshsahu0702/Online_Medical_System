package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Universal Database Connection Utility
 * Supports environment variables, Aiven cloud database, and localhost fallback.
 */
public class DBConnection {

    private static final String DEFAULT_CLOUD_URL =
            "jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db?sslMode=REQUIRED";
    private static final String DEFAULT_LOCAL_URL =
            "jdbc:mysql://localhost:3306/online_medical_db?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String DEFAULT_USER = "avnadmin";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException ex) {
                System.err.println("MySQL JDBC Driver not found in classpath: " + ex.getMessage());
            }
        }
    }

    public static Connection getConnection() throws SQLException {
        String envUrl = System.getenv("DB_URL");
        String envUser = System.getenv("DB_USER");
        String envPass = System.getenv("DB_PASSWORD");

        String url = (envUrl != null && !envUrl.trim().isEmpty()) ? envUrl : DEFAULT_CLOUD_URL;
        String user = (envUser != null && !envUser.trim().isEmpty()) ? envUser : DEFAULT_USER;
        String password = (envPass != null && !envPass.trim().isEmpty()) ? envPass : getFallbackPassword();

        try {
            return DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            // If cloud connection fails (e.g., DNS/network unreachable), attempt local fallback
            System.err.println("Could not connect to primary database at " + url + ": " + e.getMessage());
            System.err.println("Attempting fallback to localhost database...");
            try {
                return DriverManager.getConnection(DEFAULT_LOCAL_URL, "root", "ADMIN");
            } catch (SQLException fallbackErr) {
                try {
                    return DriverManager.getConnection(DEFAULT_LOCAL_URL, "root", "");
                } catch (SQLException ex) {
                    // Re-throw original primary exception with detailed diagnosis
                    throw new SQLException("Failed to connect to primary DB and local fallbacks: " + e.getMessage(), e);
                }
            }
        }
    }

    private static String getFallbackPassword() {
        try {
            return new String(java.util.Base64.getDecoder().decode("QVZOU19MR0tPc2dZMTRVWlkwUzh4NVV6"));
        } catch (Exception e) {
            return "";
        }
    }
}