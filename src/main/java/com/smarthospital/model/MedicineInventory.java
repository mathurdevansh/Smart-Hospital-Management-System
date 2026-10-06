package com.smarthospital.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * MedicineInventory Model representing pharmaceutical batches and stock levels.
 */
public class MedicineInventory implements Serializable {
    private static final long serialVersionUID = 1L;

    private int inventoryId;
    private int medicineId;
    private String medicineName;
    private String category;
    private BigDecimal price;
    private String batchNumber;
    private int quantity;
    private int reorderLevel;
    private Date expiryDate;
    private Timestamp lastRestocked;
    private boolean lowStock;
    private boolean nearExpiry;

    public MedicineInventory() {}

    public int getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(int inventoryId) {
        this.inventoryId = inventoryId;
    }

    public int getMedicineId() {
        return medicineId;
    }

    public void setMedicineId(int medicineId) {
        this.medicineId = medicineId;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getBatchNumber() {
        return batchNumber;
    }

    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getReorderLevel() {
        return reorderLevel;
    }

    public void setReorderLevel(int reorderLevel) {
        this.reorderLevel = reorderLevel;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public Timestamp getLastRestocked() {
        return lastRestocked;
    }

    public void setLastRestocked(Timestamp lastRestocked) {
        this.lastRestocked = lastRestocked;
    }

    public boolean isLowStock() {
        return lowStock || (quantity <= reorderLevel);
    }

    public void setLowStock(boolean lowStock) {
        this.lowStock = lowStock;
    }

    public boolean isNearExpiry() {
        return nearExpiry;
    }

    public void setNearExpiry(boolean nearExpiry) {
        this.nearExpiry = nearExpiry;
    }
}
