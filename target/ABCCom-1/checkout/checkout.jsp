<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/common/header.jsp">
    <jsp:param name="title" value="Checkout - VCLShop" />
</jsp:include>

<div class="container my-5">
    <h1 class="fw-bold mb-4"><i class="bi bi-credit-card-2-front text-primary"></i> Checkout</h1>

    <!-- Alert for error messages if any -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row g-4">
        <!-- Billing Details Form -->
        <div class="col-lg-7">
            <div class="form-card bg-white p-4 rounded-lg shadow-sm border border-0">
                <h4 class="fw-bold mb-4"><i class="bi bi-person-lines-fill text-secondary"></i> Shipping & Billing Details</h4>
                
                <form action="${pageContext.request.contextPath}/checkout" method="post">
                    <div class="row g-3">
                        <!-- Customer Name -->
                        <div class="col-12">
                            <label for="CustomerName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="CustomerName" name="CustomerName" placeholder="John Doe" required>
                        </div>

                        <!-- Email -->
                        <div class="col-md-6">
                            <label for="Email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="Email" name="Email" placeholder="johndoe@example.com" required>
                        </div>

                        <!-- Phone -->
                        <div class="col-md-6">
                            <label for="CustomerPhone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="CustomerPhone" name="CustomerPhone" placeholder="e.g. 0912345678" required>
                        </div>

                        <!-- Address -->
                        <div class="col-12">
                            <label for="CustomerAddress" class="form-label">Delivery Address</label>
                            <input type="text" class="form-control" id="CustomerAddress" name="CustomerAddress" placeholder="123 Main St, City, Country" required>
                        </div>

                        <!-- Note -->
                        <div class="col-12">
                            <label for="Note" class="form-label">Order Notes (Optional)</label>
                            <textarea class="form-control" id="Note" name="Note" rows="4" placeholder="Special instructions for delivery, e.g. code for gate, drop-off location..."></textarea>
                        </div>

                        <!-- Submit Button -->
                        <div class="col-12 text-end mt-4">
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-light border me-2">Back to Cart</a>
                            <button type="submit" class="btn btn-primary-custom px-4 py-2">
                                <i class="bi bi-check-circle-fill"></i> Complete Order
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Order Summary Panel -->
        <div class="col-lg-5">
            <div class="card border-0 shadow-sm p-4 bg-white rounded-lg">
                <h4 class="fw-bold mb-4 text-dark border-bottom pb-2">Your Order</h4>
                
                <!-- Order Items list -->
                <div class="mb-4" style="max-height: 300px; overflow-y: auto;">
                    <c:forEach var="item" items="${sessionScope.cart.itemList}">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="d-flex align-items-center">
                                <div class="bg-light rounded p-1 me-2" style="width: 45px; height: 45px; overflow: hidden; display: flex; align-items: center; justify-content: center;">
                                    <c:choose>
                                        <c:when test="${not empty item.product.imageURL}">
                                            <img src="${item.product.imageURL}" class="img-fluid rounded" alt="${item.product.productName}" style="object-fit: cover; max-height: 100%;">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-image text-muted small"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <h6 class="mb-0 text-truncate" style="max-width: 180px;">${item.product.productName}</h6>
                                    <small class="text-muted">Qty: ${item.quantity}</small>
                                </div>
                            </div>
                            <span class="fw-bold">
                                <fmt:formatNumber value="${item.total}" type="currency" currencySymbol="$" maxFractionDigits="0" />
                            </span>
                        </div>
                    </c:forEach>
                </div>

                <div class="border-top pt-3">
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Subtotal</span>
                        <span class="fw-bold">
                            <fmt:formatNumber value="${sessionScope.cart.total}" type="currency" currencySymbol="$" maxFractionDigits="0" />
                        </span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Shipping</span>
                        <span class="text-success fw-bold">FREE</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="h5 fw-bold mb-0 text-dark">Total</span>
                        <span class="h4 fw-bold text-primary mb-0">
                            <fmt:formatNumber value="${sessionScope.cart.total}" type="currency" currencySymbol="$" maxFractionDigits="0" />
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />
