<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/common/header.jsp">
    <jsp:param name="title" value="Order Confirmation - VCLShop" />
</jsp:include>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-7 text-center">
            <div class="card border-0 shadow-sm p-5 bg-white rounded-lg">
                <div class="py-4">
                    <!-- Success Icon with Pulse animation -->
                    <div class="d-inline-flex align-items-center justify-content-center rounded-circle bg-success-subtle text-success mb-4" style="width: 100px; height: 100px;">
                        <i class="bi bi-check-circle-fill" style="font-size: 4rem;"></i>
                    </div>
                    
                    <h1 class="display-6 fw-bold text-dark mb-3">Order Placed Successfully!</h1>
                    <p class="lead text-muted mb-4">Thank you for your purchase. Your order has been received and is currently being processed by our team.</p>
                    
                    <div class="bg-light p-4 rounded-md mb-4 text-start border" style="border-radius: 8px;">
                        <h5 class="fw-bold mb-3"><i class="bi bi-info-circle-fill text-primary"></i> What's Next?</h5>
                        <ul class="mb-0 text-muted ps-3">
                            <li class="mb-2">A confirmation email has been sent to your registered email address.</li>
                            <li class="mb-2">We will notify you as soon as your items are shipped with tracking details.</li>
                            <li>Standard shipping typically takes 2-5 business days.</li>
                        </ul>
                    </div>

                    <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary-custom px-4 py-2">
                            <i class="bi bi-shop"></i> Continue Shopping
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />
