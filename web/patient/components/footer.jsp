<footer class="patient-footer">

    <div class="patient-footer-content">

        <!-- Footer Brand -->
        <div class="patient-footer-brand">
            <a href="${pageContext.request.contextPath}/patient/dashboard.jsp"
               class="patient-footer-logo">
                MediCore
            </a>

            <p class="patient-footer-description">
                Your trusted digital healthcare companion.
            </p>
        </div>


        <!-- Quick Links -->
        <div class="patient-footer-links">

            <a href="${pageContext.request.contextPath}/patient/dashboard.jsp">
                Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/patient/doctors/find-doctor.jsp">
                Find a Doctor
            </a>

            <a href="${pageContext.request.contextPath}/patient/appointments/appointments.jsp">
                Appointments
            </a>

            <a href="${pageContext.request.contextPath}/patient/emergency/emergency.jsp">
                Emergency
            </a>

        </div>

    </div>


    <!-- Copyright -->
    <div class="patient-footer-bottom">

        <p>
            &copy; <%= java.time.Year.now() %> MediCore.
            All rights reserved.
        </p>

    </div>

</footer>