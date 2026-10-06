<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Pharmacy Inventory & Formulary" />
<c:set var="activePage" value="inventory" />
<c:set var="pageHeading" value="Pharmacy & Medication Formulary" />
<c:set var="pageSubheading" value="Pharmaceutical inventory control, batch tracking, reorder thresholds, and expiration alerts" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <!-- Flash Messages -->
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success alert-dismissible fade show small" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Action completed: ${param.msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- KPI Metrics Grid -->
        <div class="row g-3 mb-4">
            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Total Medicines</p>
                        <h3>${medicines.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-blue">
                        <i class="bi bi-capsule"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Active Batches in Store</p>
                        <h3>${inventory.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-teal">
                        <i class="bi bi-boxes"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Low Stock Warnings</p>
                        <h3 class="text-danger">${lowStock.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-red">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Near Expiry Batches</p>
                        <h3 class="text-warning">${expiring.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-orange">
                        <i class="bi bi-calendar-x"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <ul class="nav nav-pills" id="inventoryTabs" role="tablist">
                <li class="nav nav-item" role="presentation">
                    <button class="nav-link active" id="stock-tab" data-bs-toggle="pill" data-bs-target="#stockContent" type="button" role="tab">
                        <i class="bi bi-box-seam me-1"></i> Stock Batches (${inventory.size()})
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="catalog-tab" data-bs-toggle="pill" data-bs-target="#catalogContent" type="button" role="tab">
                        <i class="bi bi-card-checklist me-1"></i> Drug Formulary (${medicines.size()})
                    </button>
                </li>
            </ul>

            <div class="d-flex gap-2">
                <button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addBatchModal">
                    <i class="bi bi-plus-lg me-1"></i> Add Stock Batch
                </button>
                <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addMedicineModal">
                    <i class="bi bi-capsule me-1"></i> Add New Medicine
                </button>
            </div>
        </div>

        <!-- Tab Contents -->
        <div class="tab-content" id="inventoryTabContent">
            
            <!-- Tab 1: Current Stock Batches -->
            <div class="tab-pane fade show active" id="stockContent" role="tabpanel">
                <div class="content-panel">
                    <div class="panel-header">
                        <h5><i class="bi bi-boxes me-2 text-primary"></i> Pharmacy Stock by Batch</h5>
                        <input type="text" id="batchSearch" class="form-control form-control-sm w-auto" placeholder="Filter batch or medicine..." onkeyup="filterStockBatches()">
                    </div>
                    <div class="table-responsive">
                        <table class="table table-custom" id="stockTable">
                            <thead>
                                <tr>
                                    <th>Medicine Name</th>
                                    <th>Category</th>
                                    <th>Batch #</th>
                                    <th>Available Qty</th>
                                    <th>Reorder Alert</th>
                                    <th>Expiry Date</th>
                                    <th>Unit Price</th>
                                    <th class="text-end">Update</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty inventory}">
                                        <tr>
                                            <td colspan="8" class="text-center text-muted py-4">No pharmacy batches currently stocked.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="item" items="${inventory}">
                                            <tr class="batch-row" data-search="${item.medicineName} ${item.batchNumber} ${item.category}">
                                                <td>
                                                    <div class="fw-bold text-dark">${item.medicineName}</div>
                                                </td>
                                                <td><span class="badge bg-light text-secondary border">${item.category}</span></td>
                                                <td><code class="fw-bold">${item.batchNumber}</code></td>
                                                <td>
                                                    <span class="fw-bold ${item.quantity <= item.reorderLevel ? 'text-danger' : 'text-success'} fs-6">
                                                        ${item.quantity}
                                                    </span>
                                                    <c:if test="${item.quantity <= item.reorderLevel}">
                                                        <span class="badge bg-danger-subtle text-danger ms-1">Low</span>
                                                    </c:if>
                                                </td>
                                                <td>${item.reorderLevel} units</td>
                                                <td>
                                                    <span class="text-dark"><fmt:formatDate value="${item.expiryDate}" pattern="dd MMM yyyy" /></span>
                                                </td>
                                                <td>₹${item.price}</td>
                                                <td class="text-end">
                                                    <button type="button" class="btn btn-sm btn-outline-secondary"
                                                            data-bs-toggle="modal" data-bs-target="#updateQtyModal"
                                                            data-invid="${item.inventoryId}"
                                                            data-medname="${item.medicineName}"
                                                            data-batch="${item.batchNumber}"
                                                            data-qty="${item.quantity}"
                                                            onclick="openUpdateQty(this)">
                                                        <i class="bi bi-pencil me-1"></i> Qty
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Tab 2: Drug Formulary Master -->
            <div class="tab-pane fade" id="catalogContent" role="tabpanel">
                <div class="content-panel">
                    <div class="panel-header">
                        <h5><i class="bi bi-card-checklist me-2 text-primary"></i> Master Medicine Directory</h5>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-custom">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Medicine Name</th>
                                    <th>Category</th>
                                    <th>Manufacturer</th>
                                    <th>Unit Price</th>
                                    <th>Description / Notes</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty medicines}">
                                        <tr>
                                            <td colspan="6" class="text-center text-muted py-4">No master drugs registered.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="m" items="${medicines}">
                                            <tr>
                                                <td>#${m.medicineId}</td>
                                                <td class="fw-bold text-dark">${m.medicineName}</td>
                                                <td><span class="badge bg-light text-dark border">${m.category}</span></td>
                                                <td>${m.manufacturer}</td>
                                                <td class="text-primary fw-bold">₹${m.price}</td>
                                                <td class="text-muted small">${m.description}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>

    </div>

    <!-- Modal: Add New Medicine -->
    <div class="modal fade" id="addMedicineModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/inventory" method="POST">
                    <input type="hidden" name="action" value="addMedicine">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold"><i class="bi bi-capsule me-2 text-primary"></i> Register New Medicine</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Medicine / Drug Name <span class="text-danger">*</span></label>
                            <input type="text" name="medicineName" class="form-control" placeholder="e.g. Amoxicillin 500mg" required>
                        </div>
                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <label class="form-label fw-semibold">Category</label>
                                <select name="category" class="form-select" required>
                                    <option value="Antibiotic">Antibiotic</option>
                                    <option value="Analgesic">Analgesic</option>
                                    <option value="Antihypertensive">Antihypertensive</option>
                                    <option value="Antidiabetic">Antidiabetic</option>
                                    <option value="Antihistamine">Antihistamine</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <label class="form-label fw-semibold">Price per Unit (₹) <span class="text-danger">*</span></label>
                                <input type="number" step="0.01" min="0" name="price" class="form-control" placeholder="0.00" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Manufacturer / Pharmaceutical Lab</label>
                            <input type="text" name="manufacturer" class="form-control" placeholder="e.g. Cipla / Sun Pharma">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Description / Composition</label>
                            <textarea name="description" class="form-control" rows="2" placeholder="Brief formulation details..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Create Drug Entry</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal: Add Stock Batch -->
    <div class="modal fade" id="addBatchModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/inventory" method="POST">
                    <input type="hidden" name="action" value="addBatch">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold"><i class="bi bi-box-seam me-2 text-primary"></i> Receive Stock Batch</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Select Medicine <span class="text-danger">*</span></label>
                            <select name="medicineId" class="form-select" required>
                                <option value="">-- Choose Medicine --</option>
                                <c:forEach var="m" items="${medicines}">
                                    <option value="${m.medicineId}">${m.medicineName} (${m.category})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Batch Number <span class="text-danger">*</span></label>
                            <input type="text" name="batchNumber" class="form-control" placeholder="e.g. BT-2026-9021" required>
                        </div>
                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <label class="form-label fw-semibold">Quantity Received <span class="text-danger">*</span></label>
                                <input type="number" min="1" name="quantity" class="form-control" placeholder="e.g. 500" required>
                            </div>
                            <div class="col-6">
                                <label class="form-label fw-semibold">Reorder Alert Level <span class="text-danger">*</span></label>
                                <input type="number" min="1" name="reorderLevel" class="form-control" value="50" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Expiration Date <span class="text-danger">*</span></label>
                            <input type="date" name="expiryDate" class="form-control" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Batch to Stock</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal: Update Batch Quantity -->
    <div class="modal fade" id="updateQtyModal" tabindex="-1">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/inventory" method="POST">
                    <input type="hidden" name="action" value="updateQuantity">
                    <input type="hidden" name="inventoryId" id="updateInvId">
                    <div class="modal-header">
                        <h6 class="modal-title fw-bold">Update Stock Qty</h6>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="small text-muted mb-2" id="updateBatchTitle"></div>
                        <label class="form-label fw-semibold">Total Current Quantity</label>
                        <input type="number" min="0" name="quantity" id="updateQtyVal" class="form-control" required>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-sm btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-sm btn-primary">Save Qty</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />
</main>

<script>
function openUpdateQty(btn) {
    document.getElementById("updateInvId").value = btn.getAttribute("data-invid");
    document.getElementById("updateBatchTitle").textContent = btn.getAttribute("data-medname") + " (" + btn.getAttribute("data-batch") + ")";
    document.getElementById("updateQtyVal").value = btn.getAttribute("data-qty");
}

function filterStockBatches() {
    let q = document.getElementById("batchSearch").value.toLowerCase();
    document.querySelectorAll(".batch-row").forEach(row => {
        let t = row.getAttribute("data-search").toLowerCase();
        row.style.display = t.includes(q) ? "" : "none";
    });
}
</script>
</body>
</html>
