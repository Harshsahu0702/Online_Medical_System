package admin.model;

import java.io.Serializable;

public class SystemOverview implements Serializable {

    private int totalDoctors;
    private int verifiedDoctors;
    private int pendingDoctors;
    private int totalPatients;
    private int totalPharmacies;
    private int totalMedicines;
    private int totalOrders;
    private int pendingOrders;
    private int totalEmergencies;
    private int activeEmergencies;
    private int totalAppointments;

    public SystemOverview() {
    }

    public int getTotalDoctors() {
        return totalDoctors;
    }

    public void setTotalDoctors(int totalDoctors) {
        this.totalDoctors = totalDoctors;
    }

    public int getVerifiedDoctors() {
        return verifiedDoctors;
    }

    public void setVerifiedDoctors(int verifiedDoctors) {
        this.verifiedDoctors = verifiedDoctors;
    }

    public int getPendingDoctors() {
        return pendingDoctors;
    }

    public void setPendingDoctors(int pendingDoctors) {
        this.pendingDoctors = pendingDoctors;
    }

    public int getTotalPatients() {
        return totalPatients;
    }

    public void setTotalPatients(int totalPatients) {
        this.totalPatients = totalPatients;
    }

    public int getTotalPharmacies() {
        return totalPharmacies;
    }

    public void setTotalPharmacies(int totalPharmacies) {
        this.totalPharmacies = totalPharmacies;
    }

    public int getTotalMedicines() {
        return totalMedicines;
    }

    public void setTotalMedicines(int totalMedicines) {
        this.totalMedicines = totalMedicines;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public int getPendingOrders() {
        return pendingOrders;
    }

    public void setPendingOrders(int pendingOrders) {
        this.pendingOrders = pendingOrders;
    }

    public int getTotalEmergencies() {
        return totalEmergencies;
    }

    public void setTotalEmergencies(int totalEmergencies) {
        this.totalEmergencies = totalEmergencies;
    }

    public int getActiveEmergencies() {
        return activeEmergencies;
    }

    public void setActiveEmergencies(int activeEmergencies) {
        this.activeEmergencies = activeEmergencies;
    }

    public int getTotalAppointments() {
        return totalAppointments;
    }

    public void setTotalAppointments(int totalAppointments) {
        this.totalAppointments = totalAppointments;
    }
}
