/* ==========================================================================
   MediCore Patient Module
   Dashboard JavaScript
   File: patient/js/dashboard.js

   Purpose:
   - Handle dashboard-specific interactions
   - Keep dashboard logic separate from shared patient functionality
   ========================================================================== */

document.addEventListener("DOMContentLoaded", function () {

    initDashboard();

});


/* ==========================================================================
   DASHBOARD INITIALIZATION
   ========================================================================== */

function initDashboard() {

    setupConsultationButton();
    setupDashboardLinks();

}


/* ==========================================================================
   UPCOMING CONSULTATION
   ========================================================================== */

function setupConsultationButton() {

    const joinButton =
        document.getElementById("joinConsultationBtn");

    if (!joinButton) {
        return;
    }

    joinButton.addEventListener("click", function () {

        /*
         * The original frontend provides a "Join Call" action,
         * but does not define a real video-call implementation.
         *
         * Therefore, we keep this as a frontend placeholder
         * until backend/video consultation functionality is added.
         */

        if (typeof showPatientToast === "function") {

            showPatientToast(
                "Video Consultation",
                "Your video consultation will be available at the scheduled time.",
                "info"
            );

        } else {

            alert(
                "Your video consultation will be available at the scheduled time."
            );

        }

    });

}


/* ==========================================================================
   DASHBOARD QUICK LINKS
   ========================================================================== */

function setupDashboardLinks() {

    const dashboardLinks =
        document.querySelectorAll(".quick-action-btn");

    if (!dashboardLinks.length) {
        return;
    }

    dashboardLinks.forEach(function (link) {

        link.addEventListener("click", function () {

            /*
             * Navigation is intentionally handled through normal
             * JSP links rather than the original Canvas App.navigateTo()
             * routing system.
             *
             * No custom navigation logic is required here.
             */

        });

    });

}