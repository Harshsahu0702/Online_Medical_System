/* ==========================================================================
   MediCore Patient Module
   Common JavaScript
   File: patient/js/patient-common.js

   Purpose:
   - Shared patient-module interactions
   - Mobile sidebar
   - Active navigation state
   - Global search handling
   - Shared toast notifications
   - Shared modal helpers
   ========================================================================== */


/* ==========================================================================
   INITIALIZATION
   ========================================================================== */

document.addEventListener("DOMContentLoaded", function () {

    initPatientCommon();

});


function initPatientCommon() {

    setupMobileMenu();
    setupActiveNavigation();
    setupGlobalSearch();
    setupModalBehavior();

}


/* ==========================================================================
   MOBILE SIDEBAR
   ========================================================================== */

function setupMobileMenu() {

    const toggleButton =
        document.getElementById("mobileMenuToggle");

    const sidebar =
        document.getElementById("patientSidebar");

    if (!toggleButton || !sidebar) {
        return;
    }


    toggleButton.addEventListener("click", function () {

        const isOpen =
            sidebar.classList.toggle("open");

        toggleButton.setAttribute(
            "aria-expanded",
            isOpen ? "true" : "false"
        );

    });


    /*
     * Close sidebar when a navigation item is selected.
     */

    const navigationItems =
        sidebar.querySelectorAll(".sidebar-nav-item");

    navigationItems.forEach(function (item) {

        item.addEventListener("click", function () {

            sidebar.classList.remove("open");

            toggleButton.setAttribute(
                "aria-expanded",
                "false"
            );

        });

    });

}


/* ==========================================================================
   ACTIVE NAVIGATION
   ========================================================================== */

function setupActiveNavigation() {

    const currentPath =
        window.location.pathname;

    const navigationItems =
        document.querySelectorAll(".sidebar-nav-item");

    navigationItems.forEach(function (item) {

        const href =
            item.getAttribute("href");

        if (!href) {
            return;
        }


        /*
         * Compare the current page with the navigation URL.
         */

        const linkPath =
            new URL(href, window.location.origin).pathname;


        if (currentPath === linkPath) {

            item.classList.add("active");

        } else {

            item.classList.remove("active");

        }

    });

}


/* ==========================================================================
   GLOBAL SEARCH
   ========================================================================== */

function setupGlobalSearch() {

    const searchInput =
        document.getElementById("globalSearchInput");

    if (!searchInput) {
        return;
    }


    searchInput.addEventListener("keydown", function (event) {

        if (event.key !== "Enter") {
            return;
        }

        const searchValue =
            searchInput.value.trim();

        if (!searchValue) {
            return;
        }


        handleGlobalSearch(searchValue);

    });

}


/*
 * Global search routing.
 *
 * The original frontend routes doctor-related keywords toward
 * doctors and other keywords toward medicines.
 */

function handleGlobalSearch(searchValue) {

    const value =
        searchValue.toLowerCase();


    const contextPath =
        getContextPath();


    /*
     * Doctor-related searches.
     */

    if (
        value.includes("doc") ||
        value.includes("cardio") ||
        value.includes("dr")
    ) {

        window.location.href =
            contextPath +
            "/patient/doctors/find-doctor.jsp?search=" +
            encodeURIComponent(searchValue);

        return;
    }


    /*
     * Other searches are routed toward medicines,
     * following the behavior of the original frontend.
     */

    window.location.href =
        contextPath +
        "/patient/medicines/medicines.jsp?search=" +
        encodeURIComponent(searchValue);

}


/* ==========================================================================
   CONTEXT PATH
   ========================================================================== */

function getContextPath() {

    const path =
        window.location.pathname;

    const patientIndex =
        path.indexOf("/patient/");


    if (patientIndex === -1) {
        return "";
    }


    return path.substring(
        0,
        patientIndex
    );

}


/* ==========================================================================
   SHARED TOAST NOTIFICATION
   ========================================================================== */

function showPatientToast(
    title,
    message,
    type = "info"
) {

    let container =
        document.getElementById("toastContainer");


    /*
     * Create the toast container if the current
     * page does not already contain one.
     */

    if (!container) {

        container =
            document.createElement("div");

        container.id =
            "toastContainer";

        container.className =
            "toast-container";

        document.body.appendChild(container);

    }


    const toast =
        document.createElement("div");

    toast.className =
        "toast-card toast-" + type;


    const icon =
        getToastIcon(type);


    toast.innerHTML = `
        <div class="toast-icon">
            ${icon}
        </div>

        <div class="toast-content">

            <div class="toast-title">
                ${escapeHtml(title)}
            </div>

            <div class="toast-message">
                ${escapeHtml(message)}
            </div>

        </div>

        <button
            type="button"
            class="toast-close"
            aria-label="Close notification">

            &times;

        </button>
    `;


    container.appendChild(toast);


    /*
     * Allow the browser to render the toast before
     * starting the entrance transition.
     */

    requestAnimationFrame(function () {

        toast.classList.add("show");

    });


    const closeButton =
        toast.querySelector(".toast-close");


    closeButton.addEventListener(
        "click",
        function () {

            removeToast(toast);

        }
    );


    /*
     * Automatically remove the toast.
     */

    setTimeout(function () {

        removeToast(toast);

    }, 3200);

}


/* ==========================================================================
   TOAST ICON
   ========================================================================== */

function getToastIcon(type) {

    if (type === "success") {

        return `
            <svg
                class="icon icon-sm"
                viewBox="0 0 24 24"
                aria-hidden="true">

                <circle
                    cx="12"
                    cy="12"
                    r="10"/>

                <path d="m9 12 2 2 4-4"/>

            </svg>
        `;

    }


    if (type === "danger") {

        return `
            <svg
                class="icon icon-sm"
                viewBox="0 0 24 24"
                aria-hidden="true">

                <circle
                    cx="12"
                    cy="12"
                    r="10"/>

                <line
                    x1="15"
                    x2="9"
                    y1="9"
                    y2="15"/>

                <line
                    x1="9"
                    x2="15"
                    y1="9"
                    y2="15"/>

            </svg>
        `;

    }


    if (type === "warning") {

        return `
            <svg
                class="icon icon-sm"
                viewBox="0 0 24 24"
                aria-hidden="true">

                <path
                    d="M10.3 3.9 2.4 18a2 2 0 0 0 1.7 3h15.8a2 2 0 0 0 1.7-3L13.7 3.9a2 2 0 0 0-3.4 0Z"/>

                <path d="M12 9v4"/>
                <path d="M12 17h.01"/>

            </svg>
        `;

    }


    return `
        <svg
            class="icon icon-sm"
            viewBox="0 0 24 24"
            aria-hidden="true">

            <circle
                cx="12"
                cy="12"
                r="10"/>

            <line
                x1="12"
                x2="12"
                y1="8"
                y2="12"/>

            <line
                x1="12"
                x2="12.01"
                y1="16"
                y2="16"/>

        </svg>
    `;

}


/* ==========================================================================
   REMOVE TOAST
   ========================================================================== */

function removeToast(toast) {

    if (!toast) {
        return;
    }

    toast.classList.remove("show");

    setTimeout(function () {

        if (toast.parentNode) {

            toast.parentNode.removeChild(toast);

        }

    }, 250);

}


/* ==========================================================================
   MODAL HELPERS
   ========================================================================== */

function openPatientModal(modalId) {

    const modal =
        document.getElementById(modalId);

    if (!modal) {
        return;
    }

    modal.classList.add("open");

    document.body.classList.add("modal-open");

}


function closePatientModal(modalId) {

    const modal =
        document.getElementById(modalId);

    if (!modal) {
        return;
    }

    modal.classList.remove("open");

    document.body.classList.remove("modal-open");

}


/* ==========================================================================
   MODAL BEHAVIOR
   ========================================================================== */

function setupModalBehavior() {

    const modals =
        document.querySelectorAll(".modal-backdrop");


    modals.forEach(function (modal) {

        modal.addEventListener(
            "click",
            function (event) {

                /*
                 * Clicking the backdrop closes the modal.
                 * Clicking inside the dialog does not.
                 */

                if (event.target === modal) {

                    modal.classList.remove("open");

                    document.body.classList.remove(
                        "modal-open"
                    );

                }

            }
        );

    });


    /*
     * ESC closes the currently open modal.
     */

    document.addEventListener(
        "keydown",
        function (event) {

            if (event.key !== "Escape") {
                return;
            }


            const openModal =
                document.querySelector(
                    ".modal-backdrop.open"
                );


            if (openModal) {

                openModal.classList.remove("open");

                document.body.classList.remove(
                    "modal-open"
                );

            }

        }
    );

}


/* ==========================================================================
   HTML ESCAPING
   ========================================================================== */

function escapeHtml(value) {

    const element =
        document.createElement("div");

    element.textContent =
        value == null ? "" : String(value);

    return element.innerHTML;

}


/* ==========================================================================
   BACKWARD-COMPATIBLE GLOBAL HELPERS
   ========================================================================== */

/*
 * These aliases make it easier for module-specific JavaScript
 * to call the shared functions without recreating them.
 */

window.PatientCommon = {

    showToast: showPatientToast,

    openModal: openPatientModal,

    closeModal: closePatientModal,

    getContextPath: getContextPath

};
