<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.doctor.DoctorAvailability" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Availability - Doctor Portal</title>
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    List<DoctorAvailability> availabilities = (List<DoctorAvailability>) request.getAttribute("availabilities");
    String successParam = request.getParameter("success");
%>

<main class="app-container">

    <% if ("1".equals(successParam)) { %>
        <div class="alert alert-success">Availability slot saved successfully!</div>
    <% } %>

    <div style="display: grid; grid-template-columns: 360px 1fr; gap: 24px;">
        
        <!-- ADD AVAILABILITY FORM -->
        <div class="card">
            <div class="card-title">
                <span>Add Time Slot</span>
            </div>

            <form action="<%= request.getContextPath() %>/DoctorAvailabilityServlet" method="POST">
                <div class="form-group">
                    <label class="form-label">Day of the Week</label>
                    <select name="dayOfWeek" class="form-control" required>
                        <option value="Monday">Monday</option>
                        <option value="Tuesday">Tuesday</option>
                        <option value="Wednesday">Wednesday</option>
                        <option value="Thursday">Thursday</option>
                        <option value="Friday">Friday</option>
                        <option value="Saturday">Saturday</option>
                        <option value="Sunday">Sunday</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label">Start Time</label>
                    <input type="time" name="startTime" class="form-control" required>
                </div>

                <div class="form-group">
                    <label class="form-label">End Time</label>
                    <input type="time" name="endTime" class="form-control" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Consultation Mode</label>
                    <select name="consultationType" class="form-control" required>
                        <option value="Online">Online Video Consultation</option>
                        <option value="Offline">In-Clinic Visit</option>
                        <option value="Both">Both (Online / In-Clinic)</option>
                    </select>
                </div>

                <div class="form-group" style="margin-top: 15px;">
                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; font-size: 14px;">
                        <input type="checkbox" name="isAvailable" value="true" checked style="width: auto;">
                        <span>Mark slot active immediately</span>
                    </label>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 10px;">Add Availability Slot</button>
            </form>
        </div>

        <!-- AVAILABILITY LIST -->
        <div class="card">
            <div class="card-title">
                <span>Current Weekly Schedule</span>
                <span style="font-size: 13px; font-weight: normal; color: #64748b;">
                    Patients can book appointments during these active slots
                </span>
            </div>

            <% if (availabilities == null || availabilities.isEmpty()) { %>
                <div style="text-align: center; padding: 40px 20px; color: #94a3b8;">
                    <div style="font-size: 36px; margin-bottom: 8px;">⏰</div>
                    <p style="margin: 0; font-size: 15px;">No availability slots configured yet.</p>
                    <p style="margin-top: 4px; font-size: 13px;">Add your working days and hours using the form on the left.</p>
                </div>
            <% } else { %>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Day</th>
                            <th>Time Window</th>
                            <th>Mode</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (DoctorAvailability slot : availabilities) { %>
                            <tr>
                                <td><strong><%= slot.getDayOfWeek() %></strong></td>
                                <td><%= slot.getStartTime() %> - <%= slot.getEndTime() %></td>
                                <td>
                                    <span class="badge" style="background:#f1f5f9; color:#334155;"><%= slot.getConsultationType() %></span>
                                </td>
                                <td>
                                    <% if (slot.isIsAvailable()) { %>
                                        <span class="badge badge-accepted">Active</span>
                                    <% } else { %>
                                        <span class="badge badge-rejected">Disabled</span>
                                    <% } %>
                                </td>
                                <td>
                                    <div style="display: flex; gap: 6px;">
                                        <% if (slot.isIsAvailable()) { %>
                                            <a href="<%= request.getContextPath() %>/DoctorAvailabilityServlet?action=toggle&id=<%= slot.getAvailabilityId() %>&status=false" class="btn btn-secondary btn-sm">Disable</a>
                                        <% } else { %>
                                            <a href="<%= request.getContextPath() %>/DoctorAvailabilityServlet?action=toggle&id=<%= slot.getAvailabilityId() %>&status=true" class="btn btn-success btn-sm">Enable</a>
                                        <% } %>
                                        <a href="<%= request.getContextPath() %>/DoctorAvailabilityServlet?action=delete&id=<%= slot.getAvailabilityId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Delete this slot?');">Delete</a>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>

    </div>

</main>

</body>
</html>
