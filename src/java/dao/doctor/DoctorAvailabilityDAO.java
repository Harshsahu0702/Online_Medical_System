package dao.doctor;

import model.doctor.DoctorAvailability;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DoctorAvailabilityDAO {

    public List<DoctorAvailability> getAvailabilityByDoctor(int doctorId) {
        List<DoctorAvailability> list = new ArrayList<DoctorAvailability>();
        String sql = "SELECT availability_id, doctor_id, day_of_week, "
                + "TIME_FORMAT(start_time, '%h:%i %p') AS formatted_start, "
                + "TIME_FORMAT(end_time, '%h:%i %p') AS formatted_end, "
                + "start_time, end_time, consultation_type, is_available "
                + "FROM doctor_availability "
                + "WHERE doctor_id = ? "
                + "ORDER BY FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'), start_time";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, doctorId);
            rs = ps.executeQuery();

            while (rs.next()) {
                DoctorAvailability da = new DoctorAvailability();
                da.setAvailabilityId(rs.getInt("availability_id"));
                da.setDoctorId(rs.getInt("doctor_id"));
                da.setDayOfWeek(rs.getString("day_of_week"));
                da.setStartTime(rs.getString("formatted_start") != null ? rs.getString("formatted_start") : rs.getString("start_time"));
                da.setEndTime(rs.getString("formatted_end") != null ? rs.getString("formatted_end") : rs.getString("end_time"));
                da.setConsultationType(rs.getString("consultation_type"));
                da.setIsAvailable(rs.getBoolean("is_available"));
                list.add(da);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return list;
    }

    public boolean addAvailability(DoctorAvailability da) {
        String sql = "INSERT INTO doctor_availability (doctor_id, day_of_week, start_time, end_time, consultation_type, is_available) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, da.getDoctorId());
            ps.setString(2, da.getDayOfWeek());
            ps.setString(3, da.getStartTime());
            ps.setString(4, da.getEndTime());
            ps.setString(5, da.getConsultationType());
            ps.setBoolean(6, da.isIsAvailable());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            close(con, ps, null);
        }
    }

    public boolean deleteAvailability(int availabilityId, int doctorId) {
        String sql = "DELETE FROM doctor_availability WHERE availability_id = ? AND doctor_id = ?";
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, availabilityId);
            ps.setInt(2, doctorId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            close(con, ps, null);
        }
    }

    public boolean toggleAvailability(int availabilityId, int doctorId, boolean isAvailable) {
        String sql = "UPDATE doctor_availability SET is_available = ? WHERE availability_id = ? AND doctor_id = ?";
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setBoolean(1, isAvailable);
            ps.setInt(2, availabilityId);
            ps.setInt(3, doctorId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            close(con, ps, null);
        }
    }

    private void close(Connection con, PreparedStatement ps, ResultSet rs) {
        if (rs != null) {
            try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (ps != null) {
            try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (con != null) {
            try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
