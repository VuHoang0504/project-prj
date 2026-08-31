package data;

import business.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductDAO {

    public ArrayList<Product> getAllProducts() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<Product> products = new ArrayList<>();
        
        // Sorting ascending by price as required for the Home page
        String query = "SELECT ProductID, ProductName, Description, ProductType, Price, ImageURL " +
                       "FROM Products ORDER BY Price ASC";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                    rs.getLong("ProductID"),
                    rs.getString("ProductName"),
                    rs.getString("Description"),
                    rs.getString("ProductType"),
                    rs.getDouble("Price"),
                    rs.getString("ImageURL")
                );
                products.add(p);
            }
        } catch (SQLException e) {
            System.err.println("Error in getAllProducts: " + e.getMessage());
        } finally {
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (ps != null) {
                try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            pool.freeConnection(connection);
        }
        return products;
    }

    public Product getProductById(long id) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Product product = null;
        
        String query = "SELECT ProductID, ProductName, Description, ProductType, Price, ImageURL " +
                       "FROM Products WHERE ProductID = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setLong(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                product = new Product(
                    rs.getLong("ProductID"),
                    rs.getString("ProductName"),
                    rs.getString("Description"),
                    rs.getString("ProductType"),
                    rs.getDouble("Price"),
                    rs.getString("ImageURL")
                );
            }
        } catch (SQLException e) {
            System.err.println("Error in getProductById: " + e.getMessage());
        } finally {
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (ps != null) {
                try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            pool.freeConnection(connection);
        }
        return product;
    }

    public ArrayList<Product> searchProducts(String keyword) {
        return filterProducts(null, null, null, null, keyword);
    }

    public ArrayList<Product> filterProducts(String category, Double minPrice, Double maxPrice, String sortBy, String keyword) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<Product> products = new ArrayList<>();
        
        StringBuilder query = new StringBuilder("SELECT ProductID, ProductName, Description, ProductType, Price, ImageURL FROM Products WHERE 1=1 ");
        List<Object> params = new ArrayList<>();
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append(" AND (ProductName LIKE ? OR Description LIKE ? OR ProductType LIKE ?)");
            String pattern = "%" + keyword.trim() + "%";
            params.add(pattern);
            params.add(pattern);
            params.add(pattern);
        }
        
        if (category != null && !category.trim().isEmpty() && !"ALL".equalsIgnoreCase(category)) {
            query.append(" AND ProductType = ?");
            params.add(category.trim());
        }
        
        if (minPrice != null && minPrice >= 0) {
            query.append(" AND Price >= ?");
            params.add(minPrice);
        }
        
        if (maxPrice != null && maxPrice > 0) {
            query.append(" AND Price <= ?");
            params.add(maxPrice);
        }
        
        if ("price_desc".equalsIgnoreCase(sortBy)) {
            query.append(" ORDER BY Price DESC");
        } else if ("name_asc".equalsIgnoreCase(sortBy)) {
            query.append(" ORDER BY ProductName ASC");
        } else if ("name_desc".equalsIgnoreCase(sortBy)) {
            query.append(" ORDER BY ProductName DESC");
        } else {
            query.append(" ORDER BY Price ASC"); // default
        }
        
        try {
            ps = connection.prepareStatement(query.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                    rs.getLong("ProductID"),
                    rs.getString("ProductName"),
                    rs.getString("Description"),
                    rs.getString("ProductType"),
                    rs.getDouble("Price"),
                    rs.getString("ImageURL")
                );
                products.add(p);
            }
        } catch (SQLException e) {
            System.err.println("Error in filterProducts: " + e.getMessage());
        } finally {
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (ps != null) {
                try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            pool.freeConnection(connection);
        }
        return products;
    }

    public Map<String, Integer> getCategoryCounts() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Map<String, Integer> counts = new HashMap<>();
        
        String query = "SELECT ProductType, COUNT(*) as count FROM Products GROUP BY ProductType";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                counts.put(rs.getString("ProductType"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            System.err.println("Error in getCategoryCounts: " + e.getMessage());
        } finally {
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (ps != null) {
                try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            pool.freeConnection(connection);
        }
        return counts;
    }

    public boolean insertProduct(Product p) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        
        String query = "INSERT INTO Products (ProductName, Description, ProductType, Price, ImageURL) " +
                       "VALUES (?, ?, ?, ?, ?)";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setString(3, p.getProductType());
            ps.setDouble(4, p.getPrice());
            ps.setString(5, p.getImageURL());
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error in insertProduct: " + e.getMessage());
            return false;
        } finally {
            if (ps != null) {
                try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            pool.freeConnection(connection);
        }
    }

    public boolean updateProduct(Product p) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        
        String query = "UPDATE Products SET ProductName = ?, Description = ?, ProductType = ?, Price = ?, ImageURL = ? " +
                       "WHERE ProductID = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setString(3, p.getProductType());
            ps.setDouble(4, p.getPrice());
            ps.setString(5, p.getImageURL());
            ps.setLong(6, p.getProductID());
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error in updateProduct: " + e.getMessage());
            return false;
        } finally {
            if (ps != null) {
                try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            pool.freeConnection(connection);
        }
    }

    public boolean deleteProduct(long id) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        
        String query = "DELETE FROM Products WHERE ProductID = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setLong(1, id);
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error in deleteProduct: " + e.getMessage());
            return false;
        } finally {
            if (ps != null) {
                try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            pool.freeConnection(connection);
        }
    }
}
