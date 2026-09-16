/* ==========================================================================
   MediCore Patient Module
   Medical Assistant JavaScript
   File: patient/js/medical-assistant.js

   Purpose:
   - Handle symptom selection
   - Collect symptom duration
   - Collect additional notes
   - Generate the educational guidance request
   - Pass assessment data to recommendation.jsp
   ========================================================================== */


document.addEventListener("DOMContentLoaded", function () {

    initMedicalAssistant();

});


/* ==========================================================================
   INITIALIZATION
   ========================================================================== */

function initMedicalAssistant() {

    setupSymptomSelection();
    setupGuidanceGeneration();
    restoreSelectedSymptoms();

}


/* ==========================================================================
   SYMPTOM SELECTION
   ========================================================================== */

function setupSymptomSelection() {

    const symptomChips =
        document.querySelectorAll(".symptom-chip");

    if (!symptomChips.length) {
        return;
    }

    symptomChips.forEach(function (chip) {

        chip.addEventListener("click", function () {

            chip.classList.toggle("selected");

            updateSelectedSymptoms();

        });
    });
}


/* ==========================================================================
   SELECTED SYMPTOMS
   ========================================================================== */

function getSelectedSymptoms() {

    const selectedChips =
        document.querySelectorAll(
            ".symptom-chip.selected"
        );

    const symptoms = [];

    selectedChips.forEach(function (chip) {

        const symptom = chip.getAttribute("data-symptom");

        if (symptom) {
            symptoms.push(symptom);
        }
    });
    
    return symptoms;
}


function updateSelectedSymptoms() {

    const symptoms = getSelectedSymptoms();

    const selectedCard =
        document.getElementById(
            "selectedSymptomsCard"
        );

    const selectedList =
        document.getElementById(
            "selectedSymptomsList"
        );

    if (!selectedCard || !selectedList) {
        return;
    }

    selectedList.innerHTML = "";

    if (!symptoms.length) {
        selectedCard.hidden = true;
        return;
    }

    symptoms.forEach(function (symptom) {
        const item =
            document.createElement("span");

        item.className =
            "selected-symptom";

        item.textContent =
            symptom;


        selectedList.appendChild(item);

    });


    selectedCard.hidden = false;

}


/* ==========================================================================
   GUIDANCE GENERATION
   ========================================================================== */

function setupGuidanceGeneration() {

    const generateButton =
        document.getElementById(
            "generateGuidanceBtn"
        );


    if (!generateButton) {
        return;
    }


    generateButton.addEventListener(
        "click",
        function () {

            generateGuidanceReport();

        }
    );

}


/* ==========================================================================
   GENERATE REPORT
   ========================================================================== */

function generateGuidanceReport() {

    const symptoms =
        getSelectedSymptoms();


    const durationElement =
        document.getElementById(
            "symptomDuration"
        );


    const notesElement =
        document.getElementById(
            "symptomNotes"
        );


    const duration =
        durationElement
            ? durationElement.value
            : "3";


    const notes =
        notesElement
            ? notesElement.value.trim()
            : "";


    /*
     * The source requires at least one symptom
     * before generating the report.
     */

    if (!symptoms.length) {

        if (
            typeof showPatientToast === "function"
        ) {

            showPatientToast(
                "Symptom Assessment",
                "Please select at least one symptom first.",
                "warning"
            );

        } else {

            alert(
                "Please select at least one symptom first."
            );

        }

        return;

    }


    /*
     * Determine the educational specialty guidance
     * using the same symptom categories supported
     * by the original source.
     */

    const recommendation =
        determineRecommendation(symptoms);


    /*
     * Store the assessment temporarily so the
     * recommendation page can read it.
     *
     * This is frontend-only storage for now.
     * Backend persistence can be added later.
     */

    const assessment = {

        symptoms: symptoms,

        duration: duration,

        notes: notes,

        specialty:
            recommendation.specialty,

        guidance:
            recommendation.guidance,

        createdAt:
            new Date().toISOString()

    };


    sessionStorage.setItem(
        "medicoreSymptomAssessment",
        JSON.stringify(assessment)
    );


    /*
     * Navigate to the separate JSP page.
     */

    window.location.href =
        getMedicalAssistantContextPath() +
        "/patient/medical-assistant/recommendation.jsp";

}


/* ==========================================================================
   RECOMMENDATION LOGIC
   ========================================================================== */

function determineRecommendation(symptoms) {

    /*
     * Default guidance from the original source.
     */

    let specialty =
        "General Practitioner";

    let guidance =
        "Your symptoms suggest a common respiratory or viral pattern. " +
        "Consider rest, adequate hydration, and monitoring your symptoms. " +
        "If symptoms worsen or persist, consult a medical professional.";


    /*
     * Heartburn / acidity
     */

    if (
        symptoms.includes(
            "Stomach Acid / Heartburn"
        )
    ) {

        specialty =
            "Gastroenterologist";

        guidance =
            "Your symptoms may be related to digestive discomfort. " +
            "Avoid heavy meals, remain upright after eating, and " +
            "consider discussing persistent symptoms with a healthcare professional.";

    }


    /*
     * Joint pain
     */

    else if (
        symptoms.includes("Joint Pain")
    ) {

        specialty =
            "Orthopedic / Rheumatology";

        guidance =
            "For joint or body aches, consider gentle movement, " +
            "adequate hydration, and appropriate rest. " +
            "Persistent or worsening pain should be evaluated by a healthcare professional.";

    }


    /*
     * Skin itchiness
     */

    else if (
        symptoms.includes("Skin Itchiness")
    ) {

        specialty =
            "Dermatologist";

        guidance =
            "For skin irritation or itching, avoid known irritants " +
            "and monitor the affected area. " +
            "Persistent or worsening symptoms may require evaluation by a dermatologist.";

    }


    return {

        specialty: specialty,

        guidance: guidance

    };

}


/* ==========================================================================
   RESTORE SELECTED SYMPTOMS
   ========================================================================== */

function restoreSelectedSymptoms() {

    const stored =
        sessionStorage.getItem(
            "medicoreSymptomAssessment"
        );


    if (!stored) {
        return;
    }


    let assessment;


    try {

        assessment =
            JSON.parse(stored);

    } catch (error) {

        sessionStorage.removeItem(
            "medicoreSymptomAssessment"
        );

        return;

    }


    if (
        !assessment ||
        !Array.isArray(assessment.symptoms)
    ) {

        return;

    }


    const symptomChips =
        document.querySelectorAll(
            ".symptom-chip"
        );


    symptomChips.forEach(function (chip) {

        const symptom =
            chip.getAttribute("data-symptom");


        if (
            symptom &&
            assessment.symptoms.includes(symptom)
        ) {

            chip.classList.add("selected");

        }

    });


    updateSelectedSymptoms();


    /*
     * Restore duration and notes when returning
     * to the symptom page.
     */

    const durationElement =
        document.getElementById(
            "symptomDuration"
        );

    const notesElement =
        document.getElementById(
            "symptomNotes"
        );


    if (
        durationElement &&
        assessment.duration
    ) {

        durationElement.value =
            assessment.duration;

    }


    if (
        notesElement &&
        assessment.notes
    ) {

        notesElement.value =
            assessment.notes;

    }

}


/* ==========================================================================
   CONTEXT PATH
   ========================================================================== */

function getMedicalAssistantContextPath() {

    if (
        typeof PatientCommon !== "undefined" &&
        typeof PatientCommon.getContextPath === "function"
    ) {

        return PatientCommon.getContextPath();

    }


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