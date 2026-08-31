package data;

import business.Order;
import business.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class OrderDAO {

    public int insertOrder(Order o) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        int generatedId = -1;

        String query = "INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status) " +
                       "VALUES (?, ?, ?, ?)";
        try {
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, o.getCustomerID());
            ps.setTimestamp(2, new java.sql.Timestamp(o.getOrderDate().getTime()));
            ps.setDouble(3, o.getTotalAmount());
            ps.setString(4, o.getStatus());

            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error in insertOrder: " + e.getMessage());
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

    public boolean insertOrderDetail(OrderDetail od) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;

        String query = "INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) " +
                       "VALUES (?, ?, ?, ?)";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, od.getOrderID());
            ps.setLong(2, od.getProductID());
            ps.setInt(3, od.getQuantity());
            ps.setDouble(4, od.getUnitPrice());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error in insertOrderDetail: " + e.getMessage());
            return false;
        } finally {
            if (ps != null) {
                try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            pool.freeConnection(connection);
        }
    }
}
