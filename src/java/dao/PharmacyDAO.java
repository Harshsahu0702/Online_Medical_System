package dao;

import model.Pharmacy;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PharmacyDAO {

    public Pharmacy getPharmacyById(int pharmacyId) {

        Pharmacy pharmacy = null;

        String sql = "SELECT * FROM pharmacies WHERE pharmacy_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, pharmacyId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                pharmacy = new Pharmacy();

                pharmacy.setPharmacyId(rs.getInt("pharmacy_id"));
                pharmacy.setPharmacyName(rs.getString("pharmacy_name"));
                pharmacy.setEmail(rs.getString("email"));
                pharmacy.setPhone(rs.getString("phone"));
                pharmacy.setAddress(rs.getString("address"));
                pharmacy.setLicenseNumber(rs.getString("license_number"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return pharmacy;
    }
    public boolean updatePharmacy(Pharmacy pharmacy) {

    String sql =
            "UPDATE pharmacies SET " +
            "pharmacy_name = ?, " +
            "email = ?, " +
            "phone = ?, " +
            "address = ?, " +
            "license_number = ? " +
            "WHERE pharmacy_id = ?";

    try (
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)
    ) {

        ps.setString(1, pharmacy.getPharmacyName());
        ps.setString(2, pharmacy.getEmail());
        ps.setString(3, pharmacy.getPhone());
        ps.setString(4, pharmacy.getAddress());
        ps.setString(5, pharmacy.getLicenseNumber());
        ps.setInt(6, pharmacy.getPharmacyId());

        return ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return false;
}
    
}