<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title != null ? param.title : "VCLShop Electronics"}</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom Style -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

    <!-- Premium Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top shadow-sm">
        <div class="container">
            <!-- Brand / Logo -->
            <a class="navbar-brand d-flex align-items-center gap-2 fw-bold fs-4" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-cpu-fill text-primary fs-3"></i>
                <span><span>VCL</span>Shop</span>
            </a>

            <!-- Mobile Toggle Button -->
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navbar Links & Controls -->
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 align-items-lg-center">
                    <!-- Home -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="bi bi-house-door-fill me-1"></i> Home
                        </a>
                    </li>

                    <!-- Categories Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="categoriesDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-grid-fill me-1"></i> Categories
                        </a>
                        <ul class="dropdown-menu shadow border-0" aria-labelledby="categoriesDropdown">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/home"><i class="bi bi-collection me-2"></i> All Products</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/search?keyword=Laptop"><i class="bi bi-laptop me-2"></i> Laptops</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/search?keyword=Smartphone"><i class="bi bi-phone me-2"></i> Smartphones</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/search?keyword=Tablet"><i class="bi bi-tablet me-2"></i> Tablets</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/search?keyword=Headphones"><i class="bi bi-headphones me-2"></i> Headphones</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/search?keyword=Smartwatch"><i class="bi bi-smartwatch me-2"></i> Smartwatches</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/search?keyword=Accessories"><i class="bi bi-plug me-2"></i> Accessories</a></li>
                        </ul>
                    </li>

                    <!-- Admin Portal (Only visible to ADMIN role) -->
                    <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.role == 'ADMIN'}">
                        <li class="nav-item">
                            <a class="nav-link text-warning fw-semibold" href="${pageContext.request.contextPath}/products">
                                <i class="bi bi-gear-fill me-1"></i> Admin Portal
                            </a>
                        </li>
                    </c:if>
                </ul>

                <!-- Product Search Form -->
                <form class="d-flex me-lg-3 mb-2 mb-lg-0" action="${pageContext.request.contextPath}/search" method="get">
                    <div class="input-group">
                        <input class="form-control search-input" type="search" name="keyword" placeholder="Search products..." aria-label="Search" value="${keyword}" required>
                        <button class="btn btn-primary-custom search-btn" type="submit" title="Search">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </form>

                <!-- Right Actions: Cart, Facebook & User Account -->
                <ul class="navbar-nav align-items-lg-center gap-2">
                    <!-- Facebook Fanpage Link -->
                    <li class="nav-item">
                        <a class="nav-link text-primary-gradient d-flex align-items-center me-1" href="https://www.facebook.com/profile.php?id=61592204678747" target="_blank" rel="noopener noreferrer" title="Fanpage Facebook Shop">
                            <i class="bi bi-facebook fs-5 text-primary"></i>
                        </a>
                    </li>

                    <!-- Cart Link -->
                    <li class="nav-item">
                        <a class="nav-link position-relative d-flex align-items-center" href="${pageContext.request.contextPath}/cart">
                            <i class="bi bi-cart3 fs-5 me-1"></i> Cart
                            <c:if test="${sessionScope.cart != null && sessionScope.cart.count > 0}">
                                <span class="cart-badge">${sessionScope.cart.count}</span>
                            </c:if>
                        </a>
                    </li>

                    <!-- Account Controls -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.currentUser}">
                            <!-- Logged In User Profile Dropdown -->
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle d-flex align-items-center text-white gap-2" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-person-circle fs-5"></i>
                                    <span>${sessionScope.currentUser.username}</span>
                                    <span class="badge ${sessionScope.currentUser.role == 'ADMIN' ? 'bg-danger' : 'bg-secondary'} ms-1">
                                        ${sessionScope.currentUser.role}
                                    </span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0" aria-labelledby="userDropdown">
                                    <li class="dropdown-header text-muted small">Logged in as <strong>${sessionScope.currentUser.fullName != null ? sessionScope.currentUser.fullName : sessionScope.currentUser.username}</strong></li>
                                    <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products"><i class="bi bi-box-seam me-2"></i> Product Management</a></li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i> Logout</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <!-- Guest User Login / Register Buttons -->
                            <li class="nav-item d-flex gap-2">
                                <a class="btn btn-outline-light btn-sm px-3" href="${pageContext.request.contextPath}/login">
                                    <i class="bi bi-box-arrow-in-right me-1"></i> Login
                                </a>
                                <a class="btn btn-primary-custom btn-sm px-3" href="${pageContext.request.contextPath}/register">
                                    <i class="bi bi-person-plus-fill me-1"></i> Register
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
