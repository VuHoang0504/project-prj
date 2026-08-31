<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/common/header.jsp">
    <jsp:param name="title" value="Shopping Cart - VCLShop" />
</jsp:include>

<div class="container my-5">
    <h1 class="fw-bold mb-4"><i class="bi bi-cart3 text-primary"></i> Shopping Cart</h1>

    <c:choose>
        <c:when test="${empty sessionScope.cart || empty sessionScope.cart.itemList}">
            <div class="card border-0 shadow-sm p-5 text-center bg-white rounded-lg">
                <div class="py-4">
                    <i class="bi bi-cart-x text-muted" style="font-size: 5rem;"></i>
                    <h3 class="mt-4 fw-bold">Your cart is empty</h3>
                    <p class="text-muted">It looks like you haven't added any products to your cart yet.</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary-custom px-4 py-2 mt-2">
                        <i class="bi bi-arrow-left"></i> Browse Catalog
                    </a>
                </div>
            </div>
        </c:when>
        
        <c:otherwise>
            <div class="row g-4">
                <!-- Cart Items Table -->
                <div class="col-lg-8">
                    <div class="table-responsive">
                        <table class="table table-custom table-hover">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th style="width: 150px;">Quantity</th>
                                    <th>Total</th>
                                    <th style="width: 80px;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${sessionScope.cart.itemList}">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="bg-light rounded p-1 me-3" style="width: 60px; height: 60px; overflow: hidden; display: flex; align-items: center; justify-content: center;">
                                                    <c:choose>
                                                        <c:when test="${not empty item.product.imageURL}">
                                                            <img src="${item.product.imageURL}" class="img-fluid rounded" alt="${item.product.productName}" style="object-fit: cover; max-height: 100%;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="bi bi-image text-muted"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div>
                                                    <a href="${pageContext.request.contextPath}/product-detail?id=${item.product.productID}" class="text-decoration-none text-dark fw-bold">${item.product.productName}</a>
                                                    <span class="d-block text-muted small">${item.product.productType}</span>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="$" maxFractionDigits="0" />
                                        </td>
                                        <td>
                                            <!-- Update Quantity Form -->
                                            <form action="${pageContext.request.contextPath}/cart" method="post" class="d-flex align-items-center">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="productID" value="${item.product.productID}">
                                                <input type="number" name="quantity" class="form-control form-control-sm me-2" value="${item.quantity}" min="1" required style="width: 65px;">
                                                <button type="submit" class="btn btn-outline-primary btn-sm" title="Update Quantity">
                                                    <i class="bi bi-check-lg"></i>
                                                </button>
                                            </form>
                                        </td>
                                        <td class="fw-bold">
                                            <fmt:formatNumber value="${item.total}" type="currency" currencySymbol="$" maxFractionDigits="0" />
                                        </td>
                                        <td>
                                            <!-- Remove Item -->
                                            <a href="${pageContext.request.contextPath}/cart?action=remove&productID=${item.product.productID}" class="btn btn-outline-danger btn-sm" title="Remove Item">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left"></i> Continue Shopping
                        </a>
                    </div>
                </div>

                <!-- Summary Panel -->
                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm p-4 bg-white rounded-lg">
                        <h4 class="fw-bold mb-4 text-dark border-bottom pb-2">Order Summary</h4>
                        
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Total Items</span>
                            <span class="fw-bold">${sessionScope.cart.count}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-4 border-bottom pb-3">
                            <span class="text-muted">Shipping</span>
                            <span class="text-success fw-bold">FREE</span>
                        </div>
                        <div class="d-flex justify-content-between mb-4">
                            <span class="h5 fw-bold text-dark">Estimated Total</span>
                            <span class="h4 fw-bold text-primary">
                                <fmt:formatNumber value="${sessionScope.cart.total}" type="currency" currencySymbol="$" maxFractionDigits="0" />
                            </span>
                        </div>

                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser}">
                                <div class="d-grid">
                                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary-custom py-2.5 fs-5">
                                        Proceed to Checkout <i class="bi bi-arrow-right"></i>
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="d-grid">
                                    <a href="${pageContext.request.contextPath}/login?error=checkout&redirect=checkout" class="btn btn-warning py-2.5 fs-6 fw-bold text-dark mb-1">
                                        <i class="bi bi-lock-fill me-1"></i> Đăng nhập để đặt hàng
                                    </a>
                                    <span class="text-muted small text-center">Bạn cần đăng nhập tài khoản trước khi đặt hàng</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/common/footer.jsp" />
