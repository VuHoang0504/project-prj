<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/common/header.jsp">
    <jsp:param name="title" value="Manage Products - Admin Portal" />
</jsp:include>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1 class="fw-bold h2 text-dark"><i class="bi bi-gear-wide-connected text-primary"></i> Product Management</h1>
            <p class="text-muted mb-0">Total Products: ${products.size() != null ? products.size() : 0}</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/product-add" class="btn btn-primary-custom">
                <i class="bi bi-plus-lg"></i> Add New Product
            </a>
        </div>
    </div>

    <!-- Product list table -->
    <c:choose>
        <c:when test="${empty products}">
            <div class="card border-0 shadow-sm p-5 text-center bg-white rounded-lg">
                <div class="py-4">
                    <i class="bi bi-box-seam text-muted" style="font-size: 5rem;"></i>
                    <h3 class="mt-4 fw-bold">No Products Available</h3>
                    <p class="text-muted">Click the button above to add the first product to the catalog.</p>
                </div>
            </div>
        </c:when>
        
        <c:otherwise>
            <div class="table-responsive">
                <table class="table table-custom table-hover">
                    <thead>
                        <tr>
                            <th style="width: 80px;">ID</th>
                            <th style="width: 80px;">Image</th>
                            <th>Product Name</th>
                            <th>Type</th>
                            <th>Price</th>
                            <th style="width: 180px;" class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td class="text-muted font-monospace">${p.productID}</td>
                                <td>
                                    <div class="bg-light rounded p-1" style="width: 50px; height: 50px; overflow: hidden; display: flex; align-items: center; justify-content: center;">
                                        <c:choose>
                                            <c:when test="${not empty p.imageURL}">
                                                <img src="${p.imageURL}" class="img-fluid rounded" alt="${p.productName}" style="object-fit: cover; max-height: 100%;">
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-image text-muted"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td>
                                    <div class="fw-bold text-dark">${p.productName}</div>
                                    <div class="text-muted small text-truncate" style="max-width: 300px;" title="${p.description}">${p.description}</div>
                                </td>
                                <td>
                                    <span class="badge bg-light text-secondary border px-2 py-1">${p.productType}</span>
                                </td>
                                <td class="fw-bold">
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="$" maxFractionDigits="0" />
                                </td>
                                <td class="text-center">
                                    <div class="d-inline-flex gap-2">
                                        <a href="${pageContext.request.contextPath}/product-edit?id=${p.productID}" class="btn btn-sm btn-outline-primary" title="Edit Product">
                                            <i class="bi bi-pencil-fill"></i> Edit
                                        </a>
                                        <a href="${pageContext.request.contextPath}/product-delete?id=${p.productID}" 
                                           class="btn btn-sm btn-outline-danger" 
                                           title="Delete Product" 
                                           onclick="return confirm('Are you sure you want to delete this product? This action cannot be undone.');">
                                            <i class="bi bi-trash-fill"></i> Delete
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/common/footer.jsp" />
