package controller;

import business.User;
import data.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser.isAdmin()) {
                response.sendRedirect(request.getContextPath() + "/products");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
            return;
        }

        // Check if error parameter exists
        String error = request.getParameter("error");
        String redirect = request.getParameter("redirect");
        
        if ("unauthorized".equals(error)) {
            request.setAttribute("errorMessage", "Access Denied: You must be logged in as an Admin to manage products.");
        } else if ("checkout".equals(error)) {
            request.setAttribute("errorMessage", "Vui lòng đăng nhập tài khoản để tiến hành thanh toán và đặt hàng.");
        }

        request.setAttribute("redirect", redirect);
        request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String redirect = request.getParameter("redirect");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please provide both username and password.");
            request.setAttribute("redirect", redirect);
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
            return;
        }

        User user = userDAO.authenticate(username.trim(), password.trim());

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            if ("checkout".equalsIgnoreCase(redirect)) {
                response.sendRedirect(request.getContextPath() + "/checkout");
            } else if (user.isAdmin()) {
                response.sendRedirect(request.getContextPath() + "/products");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid username or password. Please try again.");
            request.setAttribute("username", username);
            request.setAttribute("redirect", redirect);
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
        }
    }
}
