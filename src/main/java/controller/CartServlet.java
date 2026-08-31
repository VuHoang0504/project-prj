package controller;

import business.Cart;
import business.LineItem;
import business.Product;
import data.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Retrieve or create the Cart in session
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }
        
        String productIDStr = request.getParameter("productID");
        if (productIDStr == null) {
            productIDStr = request.getParameter("id");
        }
        
        switch (action) {
            case "add":
                if (productIDStr != null) {
                    try {
                        long productID = Long.parseLong(productIDStr);
                        Product product = productDAO.getProductById(productID);
                        if (product != null) {
                            int quantity = 1;
                            String quantityStr = request.getParameter("quantity");
                            if (quantityStr != null) {
                                quantity = Integer.parseInt(quantityStr);
                            }
                            LineItem item = new LineItem(product, quantity);
                            cart.addItem(item);
                        }
                    } catch (NumberFormatException e) {
                        // ignore format error
                    }
                }
                response.sendRedirect(request.getContextPath() + "/cart");
                break;
                
            case "update":
                String quantityStr = request.getParameter("quantity");
                if (productIDStr != null && quantityStr != null) {
                    try {
                        long productID = Long.parseLong(productIDStr);
                        int quantity = Integer.parseInt(quantityStr);
                        cart.updateQuantity(productID, quantity);
                    } catch (NumberFormatException e) {
                        // ignore
                    }
                }
                response.sendRedirect(request.getContextPath() + "/cart");
                break;
                
            case "remove":
                if (productIDStr != null) {
                    try {
                        long productID = Long.parseLong(productIDStr);
                        cart.removeItem(productID);
                    } catch (NumberFormatException e) {
                        // ignore
                    }
                }
                response.sendRedirect(request.getContextPath() + "/cart");
                break;
                
            case "view":
            default:
                request.getRequestDispatcher("/cart/cart.jsp").forward(request, response);
                break;
        }
    }
}
