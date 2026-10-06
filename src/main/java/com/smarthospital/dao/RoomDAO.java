package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.Room;
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
 * Data Access Object for Room / Ward bed management.
 */
public class RoomDAO {

    private static final Logger LOGGER = Logger.getLogger(RoomDAO.class.getName());

    public List<Room> getAllRooms() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT room_id, room_number, room_type, floor, charges_per_day, status, created_at FROM rooms ORDER BY room_number ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRoom(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching rooms", e);
            throw new DatabaseException("Failed to fetch rooms.", e);
        }
        return list;
    }

    public List<Room> getAvailableRooms() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT room_id, room_number, room_type, floor, charges_per_day, status, created_at FROM rooms WHERE status = 'AVAILABLE' ORDER BY room_number ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRoom(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching available rooms", e);
            throw new DatabaseException("Failed to fetch available rooms.", e);
        }
        return list;
    }

    public Room getRoomById(int roomId) {
        String sql = "SELECT room_id, room_number, room_type, floor, charges_per_day, status, created_at FROM rooms WHERE room_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRoom(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching room ID: " + roomId, e);
            throw new DatabaseException("Failed to retrieve room details.", e);
        }
        return null;
    }

    public int createRoom(Room room) {
        String sql = "INSERT INTO rooms (room_number, room_type, floor, charges_per_day, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, room.getRoomNumber().trim().toUpperCase());
            ps.setString(2, room.getRoomType());
            ps.setString(3, room.getFloor());
            ps.setBigDecimal(4, room.getChargesPerDay());
            ps.setString(5, room.getStatus() != null ? room.getStatus() : "AVAILABLE");

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    room.setRoomId(rs.getInt(1));
                    return room.getRoomId();
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating room: " + room.getRoomNumber(), e);
            throw new DatabaseException("Failed to add room. Room number may already exist.", e);
        }
        return 0;
    }

    public boolean updateRoom(Room room) {
        String sql = "UPDATE rooms SET room_type = ?, floor = ?, charges_per_day = ?, status = ? WHERE room_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, room.getRoomType());
            ps.setString(2, room.getFloor());
            ps.setBigDecimal(3, room.getChargesPerDay());
            ps.setString(4, room.getStatus());
            ps.setInt(5, room.getRoomId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating room ID: " + room.getRoomId(), e);
            throw new DatabaseException("Failed to update room.", e);
        }
    }

    public boolean updateRoomStatus(int roomId, String status) {
        String sql = "UPDATE rooms SET status = ? WHERE room_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status.trim().toUpperCase());
            ps.setInt(2, roomId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating status for room ID: " + roomId, e);
            throw new DatabaseException("Failed to update room status.", e);
        }
    }

    private Room mapRoom(ResultSet rs) throws SQLException {
        Room r = new Room();
        r.setRoomId(rs.getInt("room_id"));
        r.setRoomNumber(rs.getString("room_number"));
        r.setRoomType(rs.getString("room_type"));
        r.setFloor(rs.getString("floor"));
        r.setChargesPerDay(rs.getBigDecimal("charges_per_day"));
        r.setStatus(rs.getString("status"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        return r;
    }
}
