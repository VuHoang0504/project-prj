package data;

import business.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CustomerDAO {

    public int insertCustomer(Customer c) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        int generatedId = -1;

        String query = "INSERT INTO Customers (CustomerName, Email, CustomerAddress, CustomerPhone, Note) " +
                       "VALUES (?, ?, ?, ?, ?)";
        try {
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, c.getCustomerName());
            ps.setString(2, c.getEmail());
            ps.setString(3, c.getCustomerAddress());
            ps.setString(4, c.getCustomerPhone());
            ps.setString(5, c.getNote());

            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error in insertCustomer: " + e.getMessage());
        } finally {
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (ps != null) {
                try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            pool.freeConnection(connection);
        }
        return generatedId;
    }
}
