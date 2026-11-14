package com.example.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private DBConnection() {
    }

    public static Connection getConnection() throws SQLException {
        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");

        if (url == null || url.isBlank()
                || user == null || user.isBlank()
                || password == null || password.isBlank()) {
            throw new IllegalStateException(
                    "Database configuration is missing. Set DB_URL, DB_USER, and DB_PASSWORD."
            );
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC driver is unavailable.", e);
        }

        return DriverManager.getConnection(url, user, password);
    }
}