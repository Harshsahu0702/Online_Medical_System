/**
 * MediCore Patient Module - Medical Assistant
 * File: patient/js/medical-assistant.js
 */

document.addEventListener("DOMContentLoaded", function () {
    initMedicalAssistant();
});

function initMedicalAssistant() {
    // If on symptoms page
    if (document.getElementById("symptomChipsContainer")) {
        setupSymptomSelection();
        setupGuidanceGeneration();
        restoreSelectedSymptoms();
    }
    // If on recommendation page
    if (document.getElementById("recommendationContent")) {
        renderRecommendation();
    }
}

/* ==========================================================================
   SYMPTOM SELECTION (symptoms.jsp)
   ========================================================================== */

function setupSymptomSelection() {
    const symptomChips = document.querySelectorAll(".symptom-chip");
    if (!symptomChips.length) return;

    symptomChips.forEach(function (chip) {
        chip.addEventListener("click", function () {
            chip.classList.toggle("selected");
            updateSelectedSymptoms();
        });
    });
}

function getSelectedSymptoms() {
    const selectedChips = document.querySelectorAll(".symptom-chip.selected");
    const symptoms = [];
    selectedChips.forEach(function (chip) {
        const symptom = chip.getAttribute("data-symptom");
        if (symptom) symptoms.push(symptom);
    });
    return symptoms;
}

function updateSelectedSymptoms() {
    const symptoms = getSelectedSymptoms();
    const selectedCard = document.getElementById("selectedSymptomsCard");
    const selectedList = document.getElementById("selectedSymptomsList");

    if (!selectedCard || !selectedList) return;

    selectedList.innerHTML = "";
    if (!symptoms.length) {
        selectedCard.hidden = true;
        return;
    }

    symptoms.forEach(function (symptom) {
        const item = document.createElement("span");
        item.className = "selected-symptom";
        item.textContent = symptom;
        selectedList.appendChild(item);
    });

    selectedCard.hidden = false;
}

function restoreSelectedSymptoms() {
    const stored = sessionStorage.getItem("medicoreSymptomAssessment");
    if (!stored) return;

    let assessment;
    try {
        assessment = JSON.parse(stored);
    } catch (e) {
        sessionStorage.removeItem("medicoreSymptomAssessment");
        return;
    }

    if (!assessment || !Array.isArray(assessment.symptoms)) return;

    const symptomChips = document.querySelectorAll(".symptom-chip");
    symptomChips.forEach(function (chip) {
        const symptom = chip.getAttribute("data-symptom");
        if (symptom && assessment.symptoms.includes(symptom)) {
            chip.classList.add("selected");
        }
    });

    updateSelectedSymptoms();

    const durationElement = document.getElementById("symptomDuration");
    const notesElement = document.getElementById("symptomNotes");
    if (durationElement && assessment.duration) {
        durationElement.value = assessment.duration;
    }
    if (notesElement && assessment.notes) {
        notesElement.value = assessment.notes;
    }
}

/* ==========================================================================
   GUIDANCE GENERATION (symptoms.jsp -> recommendation.jsp)
   ========================================================================== */

function setupGuidanceGeneration() {
    const generateButton = document.getElementById("generateGuidanceBtn");
    if (!generateButton) return;

    generateButton.addEventListener("click", function () {
        generateGuidanceReport();
    });
}

function generateGuidanceReport() {
    const symptoms = getSelectedSymptoms();
    if (!symptoms.length) {
        if (typeof showPatientToast === "function") {
            showPatientToast("Symptom Assessment", "Please select at least one symptom first.", "warning");
        } else {
            alert("Please select at least one symptom first.");
        }
        return;
    }

    const durationElement = document.getElementById("symptomDuration");
    const notesElement = document.getElementById("symptomNotes");
    const duration = durationElement ? durationElement.value : "3";
    const notes = notesElement ? notesElement.value.trim() : "";

    const recommendation = determineRecommendation(symptoms, duration);

    const assessment = {
        symptoms: symptoms,
        duration: duration,
        notes: notes,
        specialty: recommendation.specialty,
        title: recommendation.title,
        guidance: recommendation.guidance,
        tips: recommendation.tips,
        createdAt: new Date().toISOString()
    };

    sessionStorage.setItem("medicoreSymptomAssessment", JSON.stringify(assessment));

    window.location.href = getMedicalAssistantContextPath() + "/patient/medical-assistant/recommendation.jsp";
}

/* ==========================================================================
   RECOMMENDATION LOGIC
   ========================================================================== */

function determineRecommendation(symptoms, duration) {
    let specialty = "General Physician";
    let title = "General Viral or Health Pattern";
    let guidance = "Your reported symptoms suggest a common viral or respiratory pattern. Most mild cases improve with rest and hydration.";
    let tips = [
        "Ensure adequate rest and at least 7 to 8 hours of sleep.",
        "Stay well-hydrated with water, electrolyte drinks, or warm broths.",
        "Monitor your body temperature and symptoms over the next 48 hours."
    ];

    if (symptoms.includes("Stomach Acid / Heartburn")) {
        specialty = "Gastroenterologist";
        title = "Digestive & Acidity Discomfort";
        guidance = "Your symptoms may indicate gastroesophageal reflux, gastric acidity, or dietary discomfort.";
        tips = [
            "Avoid spicy, greasy, citrus, or heavily caffeinated foods and beverages.",
            "Eat smaller, more frequent meals rather than large heavy portions.",
            "Remain upright for at least 2 hours after eating; avoid lying down immediately.",
            "Drink plenty of water between meals rather than large gulps during meals."
        ];
    } else if (symptoms.includes("Skin Itchiness")) {
        specialty = "Dermatologist";
        title = "Skin Irritation or Allergic Response";
        guidance = "Your symptoms suggest cutaneous sensitivity, mild dermatitis, or an allergic reaction.";
        tips = [
            "Avoid scratching the affected area to prevent secondary skin irritation or infection.",
            "Apply a gentle, fragrance-free moisturizer or cold compress to soothe the skin.",
            "Avoid hot showers, harsh soaps, and synthetic tight-fitting clothing.",
            "Note any newly introduced foods, laundry detergents, or cosmetic products."
        ];
    } else if (symptoms.includes("Joint Pain")) {
        specialty = "Orthopedic / Rheumatologist";
        title = "Musculoskeletal or Joint Strain";
        guidance = "Your symptoms indicate joint or body aches that may be due to physical strain or mild inflammation.";
        tips = [
            "Give the affected joints adequate rest and avoid strenuous movements.",
            "Apply a cold pack for acute swelling or a warm heating pad for muscle stiffness.",
            "Engage in gentle stretching if comfortable, without forcing range of motion.",
            "Ensure good hydration and ergonomic posture while working and resting."
        ];
    } else if (symptoms.includes("Dry Cough") || symptoms.includes("Throat Irritation") || symptoms.includes("Nasal Congestion")) {
        specialty = "ENT Specialist / General Physician";
        title = "Upper Respiratory Tract Irritation";
        guidance = "Your symptoms indicate an upper respiratory tract infection or seasonal viral irritation.";
        tips = [
            "Perform warm saline water gargles 2 to 3 times a day for throat soothing.",
            "Inhale steam or use a cool-mist humidifier to ease nasal and throat congestion.",
            "Drink warm fluids like herbal tea with honey and clear soups.",
            "Avoid cold drinks, smoking, and exposure to airborne irritants."
        ];
    } else if (symptoms.includes("Headache") && !symptoms.includes("Mild Fever")) {
        specialty = "General Physician / Neurologist";
        title = "Tension or Dehydration Headache";
        guidance = "Your symptoms appear consistent with a tension headache, dehydration, or eye strain.";
        tips = [
            "Rest in a quiet, dimly lit room and take a screen break.",
            "Drink 1 to 2 glasses of water immediately to check for dehydration.",
            "Apply a gentle cool or warm compress across your forehead or back of the neck.",
            "Practice slow, deep breathing to relieve neck and shoulder tension."
        ];
    }

    if (duration === "7" || duration === "14") {
        const durText = duration === "14" ? "more than two weeks" : "about a week";
        tips.push("Since symptoms have persisted for " + durText + ", an in-person medical evaluation is strongly recommended.");
    }

    return {
        specialty: specialty,
        title: title,
        guidance: guidance,
        tips: tips
    };
}

/* ==========================================================================
   RENDER RECOMMENDATION (recommendation.jsp)
   ========================================================================== */

function renderRecommendation() {
    const container = document.getElementById("recommendationContent");
    if (!container) return;

    const stored = sessionStorage.getItem("medicoreSymptomAssessment");
    const contextPath = getMedicalAssistantContextPath();

    if (!stored) {
        container.innerHTML =
            '<div class="rec-empty-state">' +
                '<p>No symptom assessment found. Please select your symptoms first.</p>' +
                '<a href="' + contextPath + '/patient/medical-assistant/symptoms.jsp" class="btn btn-primary">' +
                    'Start Symptom Assessment' +
                '</a>' +
            '</div>';
        return;
    }

    let assessment;
    try {
        assessment = JSON.parse(stored);
    } catch (e) {
        container.innerHTML =
            '<div class="rec-empty-state">' +
                '<p>Could not read previous assessment. Please start over.</p>' +
                '<a href="' + contextPath + '/patient/medical-assistant/symptoms.jsp" class="btn btn-primary">' +
                    'Start Symptom Assessment' +
                '</a>' +
            '</div>';
        return;
    }

    const durationMap = {
        "1": "Started Today (< 24 hours)",
        "3": "2 to 3 Days",
        "7": "About 1 Week",
        "14": "More than 2 Weeks"
    };
    const durationText = durationMap[assessment.duration] || "2 to 3 Days";

    // Build symptom chips HTML
    let symptomsHtml = "";
    if (Array.isArray(assessment.symptoms)) {
        assessment.symptoms.forEach(function (s) {
            symptomsHtml += '<span class="selected-symptom">' + escapeHtml(s) + '</span> ';
        });
    }

    // Build tips list HTML
    let tipsHtml = "";
    if (Array.isArray(assessment.tips)) {
        assessment.tips.forEach(function (tip) {
            tipsHtml += '<li>' + escapeHtml(tip) + '</li>';
        });
    }

    const findDoctorUrl = contextPath + "/patient/doctors/find-doctor.jsp";

    const html =
        '<div class="rec-result-container">' +
            '<div class="rec-specialist-box">' +
                '<div>' +
                    '<span class="rec-badge">Recommended Specialist</span>' +
                    '<h3 class="rec-specialist-title">' + escapeHtml(assessment.specialty || "General Physician") + '</h3>' +
                    '<p class="rec-specialist-desc">' + escapeHtml(assessment.title || "Health Assessment") + '</p>' +
                '</div>' +
                '<a href="' + findDoctorUrl + '" class="btn btn-primary btn-sm">Find ' + escapeHtml(assessment.specialty || "Doctor") + '</a>' +
            '</div>' +

            '<div>' +
                '<h4 class="rec-section-title">Your Reported Assessment</h4>' +
                '<div class="selected-symptoms-list" style="margin-bottom: 8px;">' +
                    symptomsHtml +
                '</div>' +
                '<div class="rec-meta-row">' +
                    '<span class="rec-meta-item"><strong>Duration:</strong> ' + escapeHtml(durationText) + '</span>' +
                    (assessment.notes ? '<span class="rec-meta-item"><strong>Notes:</strong> ' + escapeHtml(assessment.notes) + '</span>' : '') +
                '</div>' +
            '</div>' +

            '<div class="rec-guidance-box">' +
                '<h4 class="rec-section-title">Educational Care Guidance</h4>' +
                '<p class="rec-guidance-text">' + escapeHtml(assessment.guidance || "") + '</p>' +
                (tipsHtml ? '<h5 style="font-size: 0.88rem; font-weight: 700; margin: 12px 0 6px 0; color: var(--text-main);">Recommended Self-Care Steps:</h5><ul class="rec-tips-list">' + tipsHtml + '</ul>' : '') +
            '</div>' +

            '<div class="rec-urgent-box">' +
                '<strong>When to Seek Immediate Medical Attention:</strong>' +
                'If you experience shortness of breath, severe chest discomfort, high unyielding fever, or any sudden neurological symptoms, do not wait. Contact emergency services or visit an emergency room immediately.' +
            '</div>' +
        '</div>';

    container.innerHTML = html;
}

/* ==========================================================================
   HELPERS
   ========================================================================== */

function escapeHtml(str) {
    if (!str) return "";
    return String(str)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

function getMedicalAssistantContextPath() {
    if (typeof PatientCommon !== "undefined" && typeof PatientCommon.getContextPath === "function") {
        return PatientCommon.getContextPath();
    }
    const path = window.location.pathname;
    const patientIndex = path.indexOf("/patient/");
    if (patientIndex === -1) return "";
    return path.substring(0, patientIndex);
}