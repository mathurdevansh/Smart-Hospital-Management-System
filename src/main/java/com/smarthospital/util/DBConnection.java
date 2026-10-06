package com.smarthospital.util;

import com.smarthospital.exception.DatabaseException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Centralized JDBC Database Connection Utility.
 * Loads connection configuration from db.properties and provides
 * safe Connection instances and resource cleanup utilities.
 */
public class DBConnection {

    private static final Logger LOGGER = Logger.getLogger(DBConnection.class.getName());
    private static final Properties PROPERTIES = new Properties();

    private static String dbUrl;
    private static String dbUser;
    private static String dbPassword;
    private static String dbDriver;

    static {
        loadProperties();
    }

    private DBConnection() {
        // Prevent instantiation
    }

    private static synchronized void loadProperties() {
        try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                LOGGER.log(Level.WARNING, "db.properties not found on classpath, using default connection fallback settings.");
                dbDriver = "com.mysql.cj.jdbc.Driver";
                dbUrl = "jdbc:mysql://localhost:3306/smart_hospital?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                dbUser = "root";
                dbPassword = "";
            } else {
                PROPERTIES.load(input);
                dbDriver = PROPERTIES.getProperty("db.driver", "com.mysql.cj.jdbc.Driver");
                dbUrl = PROPERTIES.getProperty("db.url");
                dbUser = PROPERTIES.getProperty("db.user");
                dbPassword = PROPERTIES.getProperty("db.password");
            }

            // Register JDBC driver
            Class.forName(dbDriver);
            LOGGER.info("MySQL JDBC Driver registered successfully: " + dbDriver);
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Failed to load db.properties", e);
            throw new DatabaseException("Failed to read database configuration.", e);
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "MySQL JDBC Driver not found on classpath", e);
            throw new DatabaseException("MySQL JDBC Driver could not be loaded.", e);
        }
    }

    /**
     * Obtains a new database connection.
     * @return active java.sql.Connection
     * @throws SQLException if a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        if (dbUrl == null || dbUser == null) {
            loadProperties();
        }
        return DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    }

    /**
     * Safely closes Statement and ResultSet instances.
     */
    public static void close(ResultSet rs, Statement stmt) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error closing ResultSet", e);
            }
        }
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error closing Statement", e);
            }
        }
    }

    /**
     * Safely closes Connection, Statement and ResultSet instances.
     */
    public static void close(ResultSet rs, Statement stmt, Connection conn) {
        close(rs, stmt);
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error closing Connection", e);
            }
        }
    }
}
