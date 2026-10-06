/**
 * SmartCare Hospital Management System - Front-end Helpers
 */

document.addEventListener("DOMContentLoaded", function () {
    initBillingCalculator();
    initDemoLoginFiller();
    initPrintButtons();
});

/**
 * Automatically calculates bill totals as inputs are modified.
 */
function initBillingCalculator() {
    const fields = [
        "consultationCharges",
        "medicineCharges",
        "labCharges",
        "roomCharges",
        "otherCharges",
        "discount",
        "tax"
    ];

    const totalEl = document.getElementById("totalAmountDisplay");
    if (!totalEl) return;

    function recalculate() {
        let subtotal = 0;
        const consult = parseFloat(document.getElementById("consultationCharges")?.value) || 0;
        const med = parseFloat(document.getElementById("medicineCharges")?.value) || 0;
        const lab = parseFloat(document.getElementById("labCharges")?.value) || 0;
        const room = parseFloat(document.getElementById("roomCharges")?.value) || 0;
        const other = parseFloat(document.getElementById("otherCharges")?.value) || 0;
        const discount = parseFloat(document.getElementById("discount")?.value) || 0;
        const tax = parseFloat(document.getElementById("tax")?.value) || 0;

        subtotal = consult + med + lab + room + other - discount;
        if (subtotal < 0) subtotal = 0;
        const total = subtotal + tax;

        totalEl.innerText = "₹" + total.toFixed(2);
    }

    fields.forEach(id => {
        const el = document.getElementById(id);
        if (el) {
            el.addEventListener("input", recalculate);
        }
    });
    recalculate();
}

/**
 * Provides single-click credentials autofill for PBL evaluation and testing.
 */
function initDemoLoginFiller() {
    window.fillDemoCredentials = function (email, password, role) {
        const emailInput = document.getElementById("emailInput");
        const passwordInput = document.getElementById("passwordInput");
        const roleSelect = document.getElementById("roleSelect");

        if (emailInput) emailInput.value = email;
        if (passwordInput) passwordInput.value = password;
        if (roleSelect) roleSelect.value = role;
    };
}

/**
 * Printable invoice trigger.
 */
function initPrintButtons() {
    const printBtns = document.querySelectorAll(".btn-print");
    printBtns.forEach(btn => {
        btn.addEventListener("click", function (e) {
            e.preventDefault();
            window.print();
        });
    });
}

/**
 * Dynamic row addition for doctor prescription items.
 */
function addPrescriptionRow() {
    const tableBody = document.getElementById("prescriptionItemsBody");
    if (!tableBody) return;

    const rowCount = tableBody.rows.length;
    const firstRow = tableBody.rows[0];
    if (!firstRow) return;

    const newRow = firstRow.cloneNode(true);
    // Clear inputs in cloned row
    const inputs = newRow.querySelectorAll("input, select");
    inputs.forEach(input => {
        input.value = "";
    });

    tableBody.appendChild(newRow);
}

function removePrescriptionRow(button) {
    const tableBody = document.getElementById("prescriptionItemsBody");
    if (!tableBody || tableBody.rows.length <= 1) return;
    const row = button.closest("tr");
    if (row) {
        row.remove();
    }
}
