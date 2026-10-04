package util;

import java.sql.Connection;

public class TestConnection {

    public static void main(String[] args) {

        Connection con = DBConnection.getConnection();

        if (con != null) {

            System.out.println("SUCCESS!");
            System.out.println("Java is connected to MySQL.");

        } else {

            System.out.println("FAILED!");
            System.out.println("Could not connect to MySQL.");
        }
    }
}