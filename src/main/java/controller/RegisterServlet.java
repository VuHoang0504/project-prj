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

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

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
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Retain entered values in form if error occurs
        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("username", username);

        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Full name, username, and password are required.");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            return;
        }

        username = username.trim();

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match. Please re-enter.");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("errorMessage", "Username '" + username + "' is already taken. Please choose another.");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            return;
        }

        User newUser = new User(0, username, password, fullName.trim(), email != null ? email.trim() : "", "USER");
        boolean success = userDAO.registerUser(newUser);

        if (success) {
            // Auto login after registration
            User authenticatedUser = userDAO.authenticate(username, password);
            if (authenticatedUser != null) {
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", authenticatedUser);
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                response.sendRedirect(request.getContextPath() + "/login?registered=true");
            }
        } else {
            request.setAttribute("errorMessage", "Registration failed due to a database error. Please try again.");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
        }
    }
}
