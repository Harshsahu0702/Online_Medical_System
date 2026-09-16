/* ==========================================================================
   MediCore Patient Module
   Profile JavaScript
   File: patient/js/profile.js

   Purpose:
   - Profile page interactions
   - Edit profile validation
   - Profile form submission handling
   - Shared success/error feedback
   ========================================================================== */

document.addEventListener("DOMContentLoaded", function () {

    initProfile();

});


/* ==========================================================================
   PROFILE INITIALIZATION
   ========================================================================== */

function initProfile() {

    setupProfileForm();

}


/* ==========================================================================
   PROFILE FORM
   ========================================================================== */

function setupProfileForm() {

    const form =
        document.getElementById("patientProfileForm");

    if (!form) {
        return;
    }


    form.addEventListener("submit", function (event) {

        if (!validateProfileForm(form)) {

            event.preventDefault();

            return;
        }


        /*
         * At this stage the form can submit normally to the
         * configured JSP/Servlet endpoint.
         *
         * Backend persistence will be connected later.
         */

    });

}


/* ==========================================================================
   PROFILE VALIDATION
   ========================================================================== */

function validateProfileForm(form) {

    let isValid = true;


    const fullName =
        document.getElementById("profFullName");

    const dateOfBirth =
        document.getElementById("profDob");

    const emergencyName =
        document.getElementById("profEmName");

    const emergencyRelationship =
        document.getElementById("profEmRel");

    const emergencyPhone =
        document.getElementById("profEmPhone");


    /*
     * Clear previous validation states.
     */

    clearValidationState(form);


    /* ----------------------------------------------------------------------
       Full Name
       ---------------------------------------------------------------------- */

    if (
        fullName &&
        fullName.value.trim().length < 2
    ) {

        setInvalid(
            fullName,
            "Please enter your full legal name."
        );

        isValid = false;

    }


    /* ----------------------------------------------------------------------
       Date of Birth
       ---------------------------------------------------------------------- */

    if (
        dateOfBirth &&
        !dateOfBirth.value
    ) {

        setInvalid(
            dateOfBirth,
            "Please select your date of birth."
        );

        isValid = false;

    }


    /* ----------------------------------------------------------------------
       Emergency Contact Name
       ---------------------------------------------------------------------- */

    if (
        emergencyName &&
        emergencyName.value.trim().length < 2
    ) {

        setInvalid(
            emergencyName,
            "Please enter an emergency contact name."
        );

        isValid = false;

    }


    /* ----------------------------------------------------------------------
       Emergency Contact Relationship
       ---------------------------------------------------------------------- */

    if (
        emergencyRelationship &&
        emergencyRelationship.value.trim().length < 2
    ) {

        setInvalid(
            emergencyRelationship,
            "Please enter the relationship."
        );

        isValid = false;

    }


    /* ----------------------------------------------------------------------
       Emergency Contact Phone
       ---------------------------------------------------------------------- */

    if (
        emergencyPhone &&
        !isValidPhone(
            emergencyPhone.value.trim()
        )
    ) {

        setInvalid(
            emergencyPhone,
            "Please enter a valid phone number."
        );

        isValid = false;

    }


    if (!isValid) {

        const firstInvalid =
            form.querySelector(".profile-field-invalid");

        if (firstInvalid) {

            firstInvalid.focus();

        }


        if (
            typeof showPatientToast === "function"
        ) {

            showPatientToast(
                "Profile",
                "Please correct the highlighted fields.",
                "warning"
            );

        }

    }


    return isValid;

}


/* ==========================================================================
   VALIDATION HELPERS
   ========================================================================== */

function clearValidationState(form) {

    const fields =
        form.querySelectorAll(
            ".profile-field-invalid"
        );


    fields.forEach(function (field) {

        field.classList.remove(
            "profile-field-invalid"
        );

        field.removeAttribute(
            "aria-invalid"
        );

    });


    const messages =
        form.querySelectorAll(
            ".profile-validation-message"
        );


    messages.forEach(function (message) {

        message.remove();

    });

}


function setInvalid(field, message) {

    if (!field) {
        return;
    }


    field.classList.add(
        "profile-field-invalid"
    );

    field.setAttribute(
        "aria-invalid",
        "true"
    );


    const validationMessage =
        document.createElement("span");

    validationMessage.className =
        "profile-validation-message";

    validationMessage.textContent =
        message;


    field.parentElement.appendChild(
        validationMessage
    );

}


/* ==========================================================================
   PHONE VALIDATION
   ========================================================================== */

function isValidPhone(phone) {

    /*
     * Accepts common phone formats while requiring
     * at least 7 digits.
     */

    const digits =
        phone.replace(/\D/g, "");

    return digits.length >= 7;

}
