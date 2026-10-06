package com.smarthospital.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Room Model representing hospital beds/rooms.
 */
public class Room implements Serializable {
    private static final long serialVersionUID = 1L;

    private int roomId;
    private String roomNumber;
    private String roomType; // GENERAL, SEMI_PRIVATE, PRIVATE, ICU
    private String floor;
    private BigDecimal chargesPerDay;
    private String status; // AVAILABLE, OCCUPIED, UNDER_MAINTENANCE
    private Timestamp createdAt;

    public Room() {}

    public Room(int roomId, String roomNumber, String roomType, String floor, BigDecimal chargesPerDay, String status) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.floor = floor;
        this.chargesPerDay = chargesPerDay;
        this.status = status;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getFloor() {
        return floor;
    }

    public String getFloorNumber() {
        return floor;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }

    public BigDecimal getChargesPerDay() {
        return chargesPerDay;
    }

    public BigDecimal getDailyRate() {
        return chargesPerDay;
    }

    public void setChargesPerDay(BigDecimal chargesPerDay) {
        this.chargesPerDay = chargesPerDay;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Room{" + "roomNumber='" + roomNumber + '\'' + ", roomType='" + roomType + '\'' + ", status='" + status + '\'' + '}';
    }
}
