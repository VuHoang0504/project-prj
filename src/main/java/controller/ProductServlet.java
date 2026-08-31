package controller;

import business.Product;
import business.User;
import data.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "ProductServlet", urlPatterns = {
    "/products",
    "/product-detail",
    "/product-add",
    "/product-edit",
    "/product-delete"
})
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            User currentUser = (User) session.getAttribute("currentUser");
            return currentUser.isAdmin();
        }
        return false;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        
        // Public action: product detail
        if ("/product-detail".equals(path)) {
            showProductDetail(request, response);
            return;
        }

        // Admin-only actions: /products, /product-add, /product-edit, /product-delete
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login?error=unauthorized");
            return;
        }

        switch (path) {
            case "/products":
                listProducts(request, response);
                break;
            case "/product-add":
                showAddForm(request, response);
                break;
            case "/product-edit":
                showEditForm(request, response);
                break;
            case "/product-delete":
                deleteProduct(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/home");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        
        // Admin-only actions
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login?error=unauthorized");
            return;
        }

        switch (path) {
            case "/product-add":
                addProduct(request, response);
                break;
            case "/product-edit":
                updateProduct(request, response);
                break;
            case "/product-delete":
                deleteProduct(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/home");
                break;
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/admin/productManagement.jsp").forward(request, response);
    }

    private void showProductDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            idStr = request.getParameter("productID");
        }
        
        if (idStr != null) {
            try {
                long id = Long.parseLong(idStr);
                Product product = productDAO.getProductById(id);
                if (product != null) {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("/product/productDetail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // handle format error or fall through
            }
        }
        response.sendRedirect(request.getContextPath() + "/home");
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("action", "add");
        request.getRequestDispatcher("/product/productForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            idStr = request.getParameter("productID");
        }
        
        if (idStr != null) {
            try {
                long id = Long.parseLong(idStr);
                Product product = productDAO.getProductById(id);
                if (product != null) {
                    request.setAttribute("product", product);
                    request.setAttribute("action", "edit");
                    request.getRequestDispatcher("/product/productForm.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // handle error
            }
        }
        response.sendRedirect(request.getContextPath() + "/products");
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        String productType = request.getParameter("productType");
        String priceStr = request.getParameter("price");
        String imageURL = request.getParameter("imageURL");
        
        double price = 0.0;
        try {
            price = Double.parseDouble(priceStr);
        } catch (NumberFormatException e) {
            // handle error
        }
        
        Product p = new Product(0, productName, description, productType, price, imageURL);
        productDAO.insertProduct(p);
        response.sendRedirect(request.getContextPath() + "/products");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("productID");
        if (idStr == null) {
            idStr = request.getParameter("id");
        }
        
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        String productType = request.getParameter("productType");
        String priceStr = request.getParameter("price");
        String imageURL = request.getParameter("imageURL");
        
        long id = 0;
        double price = 0.0;
        try {
            id = Long.parseLong(idStr);
            price = Double.parseDouble(priceStr);
        } catch (NumberFormatException e) {
            // handle error
        }
        
        Product p = new Product(id, productName, description, productType, price, imageURL);
        productDAO.updateProduct(p);
        response.sendRedirect(request.getContextPath() + "/products");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            idStr = request.getParameter("productID");
        }
        
        if (idStr != null) {
            try {
                long id = Long.parseLong(idStr);
                productDAO.deleteProduct(id);
            } catch (NumberFormatException e) {
                // handle error
            }
        }
        response.sendRedirect(request.getContextPath() + "/products");
    }
}
