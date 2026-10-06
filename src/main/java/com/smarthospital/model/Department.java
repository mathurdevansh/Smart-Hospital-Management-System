package com.smarthospital.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Department Model representing clinical and operational departments.
 */
public class Department implements Serializable {
    private static final long serialVersionUID = 1L;

    private int departmentId;
    private String name;
    private String description;
    private String status;
    private Timestamp createdAt;

    public Department() {}

    public Department(int departmentId, String name, String description, String status) {
        this.departmentId = departmentId;
        this.name = name;
        this.description = description;
        this.status = status;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
        return "Department{" + "departmentId=" + departmentId + ", name='" + name + '\'' + ", status='" + status + '\'' + '}';
    }
}
