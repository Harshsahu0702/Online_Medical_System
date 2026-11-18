/**
 * MediCore Patient Module - Medical Assistant
 * File: patient/js/medical-assistant.js
 */

document.addEventListener("DOMContentLoaded", function () {

    // Symptoms Page (symptoms.jsp)
    const chipsContainer = document.getElementById("symptomChipsContainer");
    const generateBtn = document.getElementById("generateGuidanceBtn");

    if (chipsContainer && generateBtn) {
        const chips = chipsContainer.querySelectorAll(".symptom-chip");

        chips.forEach(function (chip) {
            chip.addEventListener("click", function () {
                chip.classList.toggle("selected");
            });
        });

        generateBtn.addEventListener("click", function () {
            const selectedChips = chipsContainer.querySelectorAll(".symptom-chip.selected");
            const symptoms = [];

            selectedChips.forEach(function (chip) {
                symptoms.push(chip.getAttribute("data-symptom"));
            });

            if (symptoms.length === 0) {
                alert("Please select at least one symptom first.");
                return;
            }

            const durationSelect = document.getElementById("symptomDuration");
            const duration = durationSelect
                ? durationSelect.options[durationSelect.selectedIndex].text.trim()
                : "2 to 3 Days";

            let specialty = "";
            let recommendation = "";

            if (symptoms.includes("Mild Fever") && (symptoms.includes("Dry Cough") || symptoms.includes("Throat Irritation") || symptoms.includes("Nasal Congestion"))) {
                specialty = "General Physician / ENT Specialist";
                recommendation = "Your symptoms suggest a common viral flu or upper respiratory infection. Get plenty of rest, drink warm fluids, and consult a doctor if the fever continues.";
            } else if (symptoms.includes("Stomach Acid / Heartburn")) {
                specialty = "Gastroenterologist";
                recommendation = "Your symptoms suggest acidity or acid reflux. Avoid spicy and oily foods, eat smaller meals, and avoid lying down immediately after eating.";
            } else if (symptoms.includes("Skin Itchiness")) {
                specialty = "Dermatologist";
                recommendation = "Your symptoms suggest a skin allergy or irritation. Avoid scratching, apply a mild fragrance-free moisturizer, and consult a dermatologist if it spreads.";
            } else if (symptoms.includes("Joint Pain")) {
                specialty = "Orthopedic Specialist";
                recommendation = "Your symptoms suggest joint or muscle strain. Rest the affected area, use a cold or warm compress, and consult an orthopedic specialist if the pain persists.";
            } else if (symptoms.includes("Dry Cough") || symptoms.includes("Throat Irritation") || symptoms.includes("Nasal Congestion")) {
                specialty = "ENT Specialist";
                recommendation = "Your symptoms suggest throat or nasal irritation. Try warm salt-water gargles, steam inhalation, and warm liquids.";
            } else if (symptoms.includes("Headache")) {
                specialty = "General Physician / Neurologist";
                recommendation = "Your headache may be due to stress, dehydration, or eye strain. Drink water, rest in a quiet room, and take a break from screens.";
            } else if (symptoms.includes("Mild Fever")) {
                specialty = "General Physician";
                recommendation = "You are experiencing a mild fever. Stay hydrated, take proper rest, and monitor your temperature regularly.";
            } else if (symptoms.includes("Fatigue")) {
                specialty = "General Physician";
                recommendation = "Fatigue and weakness can be caused by poor sleep, dehydration, or low nutrition. Get adequate rest, stay hydrated, and consider a routine checkup if it lasts.";
            } else {
                specialty = "General Physician";
                recommendation = "Rest well, stay hydrated, and consult a General Physician for a proper checkup.";
            }

            if (duration === "About 1 Week" || duration === "More than 2 Weeks") {
                recommendation += " Since your symptoms have lasted " + duration.toLowerCase() + ", an in-person doctor consultation is recommended.";
            }

            sessionStorage.setItem("medicoreRecommendation", JSON.stringify({
                symptoms: symptoms,
                duration: duration,
                specialty: specialty,
                recommendation: recommendation
            }));

            window.location.href = "recommendation.jsp";
        });
    }

    // Recommendation Page (recommendation.jsp)
    const recommendationContent = document.getElementById("recommendationContent");

    if (recommendationContent) {
        const stored = sessionStorage.getItem("medicoreRecommendation");

        if (!stored) {
            recommendationContent.innerHTML =
                '<div class="rec-empty-state">' +
                    '<p>No symptom assessment found. Please select your symptoms first.</p>' +
                    '<a href="symptoms.jsp" class="btn btn-primary">Start Symptom Assessment</a>' +
                '</div>';
            return;
        }

        const data = JSON.parse(stored);

        let symptomsHtml = "";
        data.symptoms.forEach(function (symptom) {
            symptomsHtml += '<span class="selected-symptom">' + symptom + '</span> ';
        });

        recommendationContent.innerHTML =
            '<div class="rec-result-container">' +
                '<div class="rec-specialist-box">' +
                    '<div>' +
                        '<span class="rec-badge">Recommended Specialist</span>' +
                        '<h3 class="rec-specialist-title">' + data.specialty + '</h3>' +
                    '</div>' +
                    '<a href="../find-doctor" class="btn btn-primary btn-sm">Find ' + data.specialty + '</a>' +
                '</div>' +

                '<div>' +
                    '<h4 class="rec-section-title">Reported Symptoms</h4>' +
                    '<div class="selected-symptoms-list" style="margin-bottom: 8px;">' +
                        symptomsHtml +
                    '</div>' +
                    '<div class="rec-meta-row">' +
                        '<span class="rec-meta-item"><strong>Duration:</strong> ' + data.duration + '</span>' +
                    '</div>' +
                '</div>' +

                '<div class="rec-guidance-box">' +
                    '<h4 class="rec-section-title">Recommendation</h4>' +
                    '<p class="rec-guidance-text">' + data.recommendation + '</p>' +
                '</div>' +

                '<div class="rec-urgent-box">' +
                    '<strong>When to Seek Immediate Medical Attention:</strong>' +
                    'If you experience shortness of breath, severe chest pain, or high fever, contact emergency services immediately.' +
                '</div>' +
            '</div>';
    }

});
