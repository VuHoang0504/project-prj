package controller;

import business.Product;
import data.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category");
        if (category == null) {
            category = request.getParameter("type");
        }
        String priceRange = request.getParameter("priceRange");
        String sortBy = request.getParameter("sortBy");
        String keyword = request.getParameter("keyword");
        
        Double minPrice = null;
        Double maxPrice = null;

        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
            try { minPrice = Double.parseDouble(minPriceStr); } catch (Exception e) {}
        }
        if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
            try { maxPrice = Double.parseDouble(maxPriceStr); } catch (Exception e) {}
        }

        if (priceRange != null && !priceRange.trim().isEmpty()) {
            switch (priceRange) {
                case "0-500":
                    minPrice = 0.0;
                    maxPrice = 500.0;
                    break;
                case "500-1000":
                    minPrice = 500.0;
                    maxPrice = 1000.0;
                    break;
                case "1000-2000":
                    minPrice = 1000.0;
                    maxPrice = 2000.0;
                    break;
                case "2000-up":
                    minPrice = 2000.0;
                    maxPrice = null;
                    break;
            }
        }

        ArrayList<Product> products = productDAO.filterProducts(category, minPrice, maxPrice, sortBy, keyword);
        Map<String, Integer> categoryCounts = productDAO.getCategoryCounts();

        request.setAttribute("products", products);
        request.setAttribute("categoryCounts", categoryCounts);
        request.setAttribute("selectedCategory", category != null ? category : "");
        request.setAttribute("selectedPriceRange", priceRange != null ? priceRange : "");
        request.setAttribute("selectedSortBy", sortBy != null ? sortBy : "price_asc");
        request.setAttribute("minPrice", minPriceStr);
        request.setAttribute("maxPrice", maxPriceStr);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("/product/productList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
