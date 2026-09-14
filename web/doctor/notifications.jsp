<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.doctor.Notification" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Notifications - Online Medical System</title>
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    List<Notification> notifications = (List<Notification>) request.getAttribute("notifications");
    Integer unreadCount = (Integer) request.getAttribute("unreadCount");
    if (unreadCount == null) unreadCount = 0;
%>

<main class="app-container">

    <div class="card">
        <div class="card-title">
            <span>Notification Center</span>
            <div>
                <% if (unreadCount > 0) { %>
                    <a href="<%= request.getContextPath() %>/DoctorNotificationServlet?action=readAll" class="btn btn-secondary btn-sm">Mark All as Read</a>
                <% } %>
            </div>
        </div>

        <% if (notifications == null || notifications.isEmpty()) { %>
            <div style="text-align: center; padding: 50px 20px; color: #94a3b8;">
                <div style="font-size: 40px; margin-bottom: 8px;">🔔</div>
                <p style="margin: 0; font-size: 15px;">You have no notifications at this time.</p>
            </div>
        <% } else { %>
            <div style="display: flex; flex-direction: column; gap: 12px;">
                <% for (Notification n : notifications) { %>
                    <div style="padding: 16px; border-radius: 8px; border: 1px solid #e2e8f0; background: <%= n.isIsRead() ? "#ffffff" : "#f0f9ff" %>; border-left: 5px solid <%= n.isIsRead() ? "#94a3b8" : "#0284c7" %>; display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 4px;">
                                <strong style="font-size: 15px; color: #1e293b;"><%= n.getTitle() %></strong>
                                <% if (!n.isIsRead()) { %>
                                    <span class="badge" style="background:#0284c7; color:white; font-size:10px;">NEW</span>
                                <% } %>
                                <span style="font-size: 12px; color: #64748b;"><%= n.getCreatedAt() %></span>
                            </div>
                            <p style="margin: 0; color: #475569; font-size: 14px;"><%= n.getMessage() %></p>
                        </div>
                        <div>
                            <% if (!n.isIsRead()) { %>
                                <a href="<%= request.getContextPath() %>/DoctorNotificationServlet?action=read&id=<%= n.getNotificationId() %>" class="btn btn-sm btn-secondary">Mark Read</a>
                            <% } %>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>

</main>

</body>
</html>
