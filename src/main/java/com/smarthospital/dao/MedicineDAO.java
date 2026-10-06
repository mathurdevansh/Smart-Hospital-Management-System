package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.Medicine;
import com.smarthospital.model.MedicineInventory;
import com.smarthospital.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Medicines and Inventory Batches.
 */
public class MedicineDAO {

    private static final Logger LOGGER = Logger.getLogger(MedicineDAO.class.getName());

    public List<Medicine> getAllMedicines() {
        List<Medicine> list = new ArrayList<>();
        String sql = "SELECT m.medicine_id, m.medicine_name, m.category, m.manufacturer, m.price, m.description, m.created_at, " +
                     "COALESCE(SUM(mi.quantity), 0) AS current_stock " +
                     "FROM medicines m " +
                     "LEFT JOIN medicine_inventory mi ON m.medicine_id = mi.medicine_id " +
                     "GROUP BY m.medicine_id, m.medicine_name, m.category, m.manufacturer, m.price, m.description, m.created_at " +
                     "ORDER BY m.medicine_name ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Medicine m = new Medicine();
                m.setMedicineId(rs.getInt("medicine_id"));
                m.setMedicineName(rs.getString("medicine_name"));
                m.setCategory(rs.getString("category"));
                m.setManufacturer(rs.getString("manufacturer"));
                m.setPrice(rs.getBigDecimal("price"));
                m.setDescription(rs.getString("description"));
                m.setCurrentStock(rs.getInt("current_stock"));
                m.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(m);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all medicines", e);
            throw new DatabaseException("Failed to fetch medicines.", e);
        }
        return list;
    }

    public Medicine getMedicineById(int id) {
        String sql = "SELECT m.medicine_id, m.medicine_name, m.category, m.manufacturer, m.price, m.description, m.created_at, " +
                     "COALESCE(SUM(mi.quantity), 0) AS current_stock " +
                     "FROM medicines m " +
                     "LEFT JOIN medicine_inventory mi ON m.medicine_id = mi.medicine_id " +
                     "WHERE m.medicine_id = ? " +
                     "GROUP BY m.medicine_id, m.medicine_name, m.category, m.manufacturer, m.price, m.description, m.created_at";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Medicine m = new Medicine();
                    m.setMedicineId(rs.getInt("medicine_id"));
                    m.setMedicineName(rs.getString("medicine_name"));
                    m.setCategory(rs.getString("category"));
                    m.setManufacturer(rs.getString("manufacturer"));
                    m.setPrice(rs.getBigDecimal("price"));
                    m.setDescription(rs.getString("description"));
                    m.setCurrentStock(rs.getInt("current_stock"));
                    m.setCreatedAt(rs.getTimestamp("created_at"));
                    return m;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching medicine ID: " + id, e);
            throw new DatabaseException("Failed to fetch medicine.", e);
        }
        return null;
    }

    public int createMedicine(Medicine med) {
        String sql = "INSERT INTO medicines (medicine_name, category, manufacturer, price, description) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, med.getMedicineName().trim());
            ps.setString(2, med.getCategory().trim());
            ps.setString(3, med.getManufacturer().trim());
            ps.setBigDecimal(4, med.getPrice());
            ps.setString(5, med.getDescription());

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    med.setMedicineId(rs.getInt(1));
                    return med.getMedicineId();
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting medicine: " + med.getMedicineName(), e);
            throw new DatabaseException("Failed to add medicine. Name may already exist.", e);
        }
        return 0;
    }

    public boolean updateMedicine(Medicine med) {
        String sql = "UPDATE medicines SET medicine_name = ?, category = ?, manufacturer = ?, price = ?, description = ? WHERE medicine_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, med.getMedicineName().trim());
            ps.setString(2, med.getCategory().trim());
            ps.setString(3, med.getManufacturer().trim());
            ps.setBigDecimal(4, med.getPrice());
            ps.setString(5, med.getDescription());
            ps.setInt(6, med.getMedicineId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating medicine ID: " + med.getMedicineId(), e);
            throw new DatabaseException("Failed to update medicine.", e);
        }
    }

    public boolean deleteMedicine(int medId) {
        String sql = "DELETE FROM medicines WHERE medicine_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, medId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting medicine ID: " + medId, e);
            throw new DatabaseException("Cannot delete medicine because it is referenced in prescriptions or inventory.", e);
        }
    }

    public List<MedicineInventory> getAllInventory() {
        List<MedicineInventory> list = new ArrayList<>();
        String sql = "SELECT mi.inventory_id, mi.medicine_id, m.medicine_name, m.category, m.price, " +
                     "mi.batch_number, mi.quantity, mi.reorder_level, mi.expiry_date, mi.last_restocked, " +
                     "(mi.quantity <= mi.reorder_level) AS is_low_stock, " +
                     "(mi.expiry_date <= DATE_ADD(CURRENT_DATE(), INTERVAL 60 DAY)) AS is_near_expiry " +
                     "FROM medicine_inventory mi " +
                     "JOIN medicines m ON mi.medicine_id = m.medicine_id " +
                     "ORDER BY mi.expiry_date ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapInventory(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching inventory", e);
            throw new DatabaseException("Failed to fetch medicine inventory.", e);
        }
        return list;
    }

    public int addStockBatch(MedicineInventory batch) {
        String sql = "INSERT INTO medicine_inventory (medicine_id, batch_number, quantity, reorder_level, expiry_date) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, batch.getMedicineId());
            ps.setString(2, batch.getBatchNumber().trim());
            ps.setInt(3, batch.getQuantity());
            ps.setInt(4, batch.getReorderLevel() > 0 ? batch.getReorderLevel() : 20);
            ps.setDate(5, batch.getExpiryDate());

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    batch.setInventoryId(rs.getInt(1));
                    return batch.getInventoryId();
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding inventory batch", e);
            throw new DatabaseException("Failed to add inventory batch.", e);
        }
        return 0;
    }

    public boolean updateBatchQuantity(int inventoryId, int newQuantity) {
        String sql = "UPDATE medicine_inventory SET quantity = ? WHERE inventory_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, newQuantity);
            ps.setInt(2, inventoryId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating batch quantity for inventory ID: " + inventoryId, e);
            throw new DatabaseException("Failed to update stock quantity.", e);
        }
    }

    public List<MedicineInventory> getLowStockItems() {
        List<MedicineInventory> list = new ArrayList<>();
        String sql = "SELECT mi.inventory_id, mi.medicine_id, m.medicine_name, m.category, m.price, " +
                     "mi.batch_number, mi.quantity, mi.reorder_level, mi.expiry_date, mi.last_restocked, " +
                     "TRUE AS is_low_stock, " +
                     "(mi.expiry_date <= DATE_ADD(CURRENT_DATE(), INTERVAL 60 DAY)) AS is_near_expiry " +
                     "FROM medicine_inventory mi " +
                     "JOIN medicines m ON mi.medicine_id = m.medicine_id " +
                     "WHERE mi.quantity <= mi.reorder_level " +
                     "ORDER BY mi.quantity ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapInventory(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching low stock medicines", e);
            throw new DatabaseException("Failed to fetch low stock warnings.", e);
        }
        return list;
    }

    public List<MedicineInventory> getExpiringItems() {
        List<MedicineInventory> list = new ArrayList<>();
        String sql = "SELECT mi.inventory_id, mi.medicine_id, m.medicine_name, m.category, m.price, " +
                     "mi.batch_number, mi.quantity, mi.reorder_level, mi.expiry_date, mi.last_restocked, " +
                     "(mi.quantity <= mi.reorder_level) AS is_low_stock, " +
                     "TRUE AS is_near_expiry " +
                     "FROM medicine_inventory mi " +
                     "JOIN medicines m ON mi.medicine_id = m.medicine_id " +
                     "WHERE mi.expiry_date <= DATE_ADD(CURRENT_DATE(), INTERVAL 60 DAY) " +
                     "ORDER BY mi.expiry_date ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapInventory(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching expiring medicines", e);
            throw new DatabaseException("Failed to fetch expiring medicine warnings.", e);
        }
        return list;
    }

    private MedicineInventory mapInventory(ResultSet rs) throws SQLException {
        MedicineInventory inv = new MedicineInventory();
        inv.setInventoryId(rs.getInt("inventory_id"));
        inv.setMedicineId(rs.getInt("medicine_id"));
        inv.setMedicineName(rs.getString("medicine_name"));
        inv.setCategory(rs.getString("category"));
        inv.setPrice(rs.getBigDecimal("price"));
        inv.setBatchNumber(rs.getString("batch_number"));
        inv.setQuantity(rs.getInt("quantity"));
        inv.setReorderLevel(rs.getInt("reorder_level"));
        inv.setExpiryDate(rs.getDate("expiry_date"));
        inv.setLastRestocked(rs.getTimestamp("last_restocked"));
        inv.setLowStock(rs.getBoolean("is_low_stock"));
        inv.setNearExpiry(rs.getBoolean("is_near_expiry"));
        return inv;
    }
}
