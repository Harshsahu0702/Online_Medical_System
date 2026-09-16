<aside class="patient-sidebar" id="patientSidebar">

    <!-- Sidebar Header -->
    <div class="sidebar-header">

        <a href="${pageContext.request.contextPath}/patient/dashboard.jsp"
           class="sidebar-brand">

            <span class="sidebar-brand-icon">
                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M12 2a10 10 0 1 0 10 10A10 10 0 0 0 12 2Z"/>
                    <path d="M12 7v10"/>
                    <path d="M7 12h10"/>
                </svg>
            </span>

            <span class="sidebar-brand-text">MediCore</span>

        </a>

    </div>


    <!-- Main Navigation -->
    <nav class="sidebar-navigation" aria-label="Patient navigation">

        <!-- Main -->
        <div class="sidebar-section">

            <p class="sidebar-section-title">Main</p>

            <a href="${pageContext.request.contextPath}/patient/dashboard.jsp"
               class="sidebar-nav-item"
               data-page="dashboard">

                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M3 3h7v7H3z"/>
                    <path d="M14 3h7v7h-7z"/>
                    <path d="M3 14h7v7H3z"/>
                    <path d="M14 14h7v7h-7z"/>
                </svg>

                <span>Dashboard</span>

            </a>


            <a href="${pageContext.request.contextPath}/patient/profile/profile.jsp"
               class="sidebar-nav-item"
               data-page="profile">

                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                    <circle cx="12" cy="8" r="4"/>
                    <path d="M4 21a8 8 0 0 1 16 0"/>
                </svg>

                <span>My Profile</span>

            </a>

        </div>


        <!-- Healthcare -->
        <div class="sidebar-section">

            <p class="sidebar-section-title">Healthcare</p>

            <a href="${pageContext.request.contextPath}/patient/medical-assistant/medical-assistant.jsp"
               class="sidebar-nav-item"
               data-page="medical-assistant">

                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M12 2a10 10 0 1 0 10 10"/>
                    <path d="M12 6v6l4 2"/>
                    <path d="M18 2v6"/>
                    <path d="M15 5h6"/>
                </svg>

                <span>Medical Assistant</span>

            </a>


            <a href="${pageContext.request.contextPath}/patient/doctors/find-doctor.jsp"
               class="sidebar-nav-item"
               data-page="doctors">

                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                    <circle cx="10" cy="8" r="4"/>
                    <path d="M3 21a7 7 0 0 1 14 0"/>
                    <path d="M19 8v6"/>
                    <path d="M16 11h6"/>
                </svg>

                <span>Find a Doctor</span>

            </a>


            <a href="${pageContext.request.contextPath}/patient/appointments/appointments.jsp"
               class="sidebar-nav-item"
               data-page="appointments">

                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                    <rect x="3" y="4" width="18" height="17" rx="2"/>
                    <path d="M16 2v4"/>
                    <path d="M8 2v4"/>
                    <path d="M3 10h18"/>
                </svg>

                <span>Appointments</span>

            </a>


            <a href="${pageContext.request.contextPath}/patient/prescriptions/prescriptions.jsp"
               class="sidebar-nav-item"
               data-page="prescriptions">

                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                    <path d="M14 2v6h6"/>
                    <path d="M8 13h8"/>
                    <path d="M8 17h5"/>
                </svg>

                <span>Prescriptions</span>

            </a>

        </div>


        <!-- Pharmacy -->
        <div class="sidebar-section">

            <p class="sidebar-section-title">Pharmacy</p>

            <a href="${pageContext.request.contextPath}/patient/medicines/medicines.jsp"
               class="sidebar-nav-item"
               data-page="medicines">

                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                    <circle cx="9" cy="20" r="1"/>
                    <circle cx="19" cy="20" r="1"/>
                    <path d="M1 1h4l2.7 12.4a2 2 0 0 0 2 1.6h8.9a2 2 0 0 0 2-1.6L23 6H6"/>
                </svg>

                <span>Medicines</span>

            </a>


            <a href="${pageContext.request.contextPath}/patient/medicines/orders.jsp"
               class="sidebar-nav-item"
               data-page="orders">

                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M6 2h12v20H6z"/>
                    <path d="M9 6h6"/>
                    <path d="M9 10h6"/>
                    <path d="M9 14h4"/>
                </svg>

                <span>My Orders</span>

            </a>

        </div>


        <!-- Support -->
        <div class="sidebar-section">

            <p class="sidebar-section-title">Support</p>

            <a href="${pageContext.request.contextPath}/patient/notifications/notifications.jsp"
               class="sidebar-nav-item"
               data-page="notifications">

                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M18 8a6 6 0 0 0-12 0c0 7-3 9-3 9h18s-3-2-3-9"/>
                    <path d="M10 21h4"/>
                </svg>

                <span>Notifications</span>

                <span class="sidebar-nav-badge"
                      id="sidebarNotificationBadge"
                      style="display: none;">
                    0
                </span>

            </a>


            <a href="${pageContext.request.contextPath}/patient/emergency/emergency.jsp"
               class="sidebar-nav-item sidebar-emergency-item"
               data-page="emergency">

                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M12 2v20"/>
                    <path d="M2 12h20"/>
                </svg>

                <span>Emergency</span>

            </a>

        </div>

    </nav>


    <!-- Sidebar Footer -->
    <div class="sidebar-footer">

        <div class="sidebar-user">

            <div class="sidebar-user-avatar">
                P
            </div>

            <div class="sidebar-user-info">
                <span class="sidebar-user-name">Patient</span>
                <span class="sidebar-user-role">Patient Account</span>
            </div>

        </div>

    </div>

</aside>
