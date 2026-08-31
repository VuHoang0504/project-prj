<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/common/header.jsp">
    <jsp:param name="title" value="${product.productName} - VCLShop" />
</jsp:include>

<div class="container my-5">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Catalog</a></li>
            <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
        </ol>
    </nav>

    <!-- Product Detail Card -->
    <div class="card border-0 shadow-sm p-4 rounded-lg bg-white">
        <div class="row g-5">
            <!-- Product Image -->
            <div class="col-md-6">
                <div class="bg-light rounded-lg overflow-hidden d-flex align-items-center justify-content-center p-4" style="min-height: 400px; border-radius: 12px;">
                    <c:choose>
                        <c:when test="${not empty product.imageURL}">
                            <img src="${product.imageURL}" class="img-fluid rounded" alt="${product.productName}" style="max-height: 450px; object-fit: contain;">
                        </c:when>
                        <c:otherwise>
                            <div class="text-center text-muted">
                                <i class="bi bi-image" style="font-size: 5rem;"></i>
                                <p class="mt-2">No image available</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Product Specs / Form -->
            <div class="col-md-6 d-flex flex-column justify-content-between">
                <div>
                    <!-- Product Type -->
                    <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-3 py-2 rounded-pill uppercase fw-bold mb-3">
                        <i class="bi bi-tag-fill"></i> ${product.productType}
                    </span>
                    
                    <!-- Product Title -->
                    <h1 class="display-5 fw-bold mb-3 text-dark">${product.productName}</h1>
                    
                    <!-- Price -->
                    <div class="h2 fw-bold text-primary mb-4">
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$" maxFractionDigits="0" />
                    </div>
                    
                    <!-- Description -->
                    <div class="mb-4">
                        <h5 class="fw-bold text-secondary">Description</h5>
                        <p class="text-muted" style="line-height: 1.6; white-space: pre-line;">${product.description}</p>
                    </div>
                </div>

                <!-- Add to Cart Form -->
                <div class="border-top pt-4 mt-4">
                    <form action="${pageContext.request.contextPath}/cart" method="post" class="row g-3 align-items-center">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productID" value="${product.productID}">
                        
                        <div class="col-auto">
                            <label for="quantity" class="form-label mb-0 fw-bold">Qty:</label>
                        </div>
                        <div class="col-4 col-sm-3 col-md-4 col-lg-3">
                            <input type="number" id="quantity" name="quantity" class="form-control" value="1" min="1" required>
                        </div>
                        <div class="col-auto flex-grow-1">
                            <button type="submit" class="btn btn-primary-custom w-100 py-2.5">
                                <i class="bi bi-cart-plus-fill"></i> Add To Cart
                            </button>
                        </div>
                    </form>
                    
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-link text-muted p-0 text-decoration-none">
                            <i class="bi bi-arrow-left"></i> Continue Shopping
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />
