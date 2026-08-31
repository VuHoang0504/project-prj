package controller;

import business.Cart;
import business.Customer;
import business.LineItem;
import business.Order;
import business.OrderDetail;
import business.User;
import data.CustomerDAO;
import data.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {
    private CustomerDAO customerDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Login enforcement: Only logged-in users can proceed to checkout
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=checkout&redirect=checkout");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItemList().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Auto-fill user information if available
        request.setAttribute("currentUser", currentUser);
        request.getRequestDispatcher("/checkout/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Login enforcement
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=checkout&redirect=checkout");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItemList().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Retrieve customer details from form parameters
        String name = request.getParameter("CustomerName");
        String email = request.getParameter("Email");
        String phone = request.getParameter("CustomerPhone");
        String address = request.getParameter("CustomerAddress");
        String note = request.getParameter("Note");
        
        // Step 1: Insert Customer and get CustomerID
        Customer customer = new Customer(0, name, email, address, phone, note);
        int customerID = customerDAO.insertCustomer(customer);
        
        if (customerID > 0) {
            // Step 2: Insert Order and get OrderID
            double totalAmount = cart.getTotal();
            Order order = new Order(0, customerID, new Date(), totalAmount, "Pending");
            int orderID = orderDAO.insertOrder(order);
            
            if (orderID > 0) {
                // Step 3: Insert OrderDetails
                for (LineItem item : cart.getItemList()) {
                    OrderDetail od = new OrderDetail(
                        orderID,
                        item.getProduct().getProductID(),
                        item.getQuantity(),
                        item.getProduct().getPrice()
                    );
                    orderDAO.insertOrderDetail(od);
                }
                
                // Step 4: Clear Session Cart
                session.removeAttribute("cart");
                
                // Step 5: Redirect to orderSuccess.jsp
                response.sendRedirect(request.getContextPath() + "/checkout/orderSuccess.jsp");
            } else {
                request.setAttribute("errorMessage", "Failed to place order. Please try again.");
                request.getRequestDispatcher("/checkout/checkout.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Failed to register customer information. Please try again.");
            request.getRequestDispatcher("/checkout/checkout.jsp").forward(request, response);
        }
    }
}
