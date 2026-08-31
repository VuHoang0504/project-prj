package data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ConnectionPool {
    private static ConnectionPool pool = null;
    private final List<Connection> freeConnections;
    
    // Configurable URL, username, and password
    private final String url = "jdbc:sqlserver://localhost:1433;databaseName=EcommerceDB;encrypt=true;trustServerCertificate=true";
    private final String username = "sa";
    private final String password = "123";

    private ConnectionPool() {
        freeConnections = new ArrayList<>();
        try {
            // Load the Microsoft SQL Server JDBC Driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            System.err.println("SQL Server JDBC Driver not found: " + e.getMessage());
        }
    }

    public static synchronized ConnectionPool getInstance() {
        if (pool == null) {
            pool = new ConnectionPool();
        }
        return pool;
    }

    public synchronized Connection getConnection() {
        Connection c = null;
        if (!freeConnections.isEmpty()) {
            c = freeConnections.remove(freeConnections.size() - 1);
            try {
                if (c.isClosed()) {
                    c = getConnection(); // recursively get another connection if this one is closed
                }
            } catch (SQLException e) {
                c = getConnection();
            }
        } else {
            try {
                c = DriverManager.getConnection(url, username, password);
            } catch (SQLException e) {
                System.err.println("Error creating database connection: " + e.getMessage());
                try {
                    String fallbackUrl = "jdbc:sqlserver://localhost;databaseName=EcommerceDB;encrypt=true;trustServerCertificate=true";
                    c = DriverManager.getConnection(fallbackUrl, username, password);
                } catch (SQLException ex) {
                    System.err.println("Fallback database connection failed: " + ex.getMessage());
                }
            }
        }
        return c;
    }

    public synchronized void freeConnection(Connection c) {
        if (c != null) {
            try {
                if (!c.isClosed()) {
                    freeConnections.add(c);
                }
            } catch (SQLException e) {
                System.err.println("Error freeing connection: " + e.getMessage());
            }
        }
    }
}
