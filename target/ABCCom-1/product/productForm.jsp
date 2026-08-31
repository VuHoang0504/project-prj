<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/common/header.jsp">
    <jsp:param name="title" value="${action == 'edit' ? 'Edit Product' : 'Add New Product'} - Admin" />
</jsp:include>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <!-- Form Card -->
            <div class="form-card">
                <div class="d-flex align-items-center mb-4">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-sm me-3 rounded-circle" style="width: 32px; height: 32px; padding: 0; display: inline-flex; align-items: center; justify-content: center;">
                        <i class="bi bi-arrow-left"></i>
                    </a>
                    <h1 class="h3 fw-bold mb-0">
                        <c:choose>
                            <c:when test="${action == 'edit'}">
                                <i class="bi bi-pencil-square text-primary"></i> Edit Product
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-plus-circle text-primary"></i> Add New Product
                            </c:otherwise>
                        </c:choose>
                    </h1>
                </div>

                <form action="${pageContext.request.contextPath}/${action == 'edit' ? 'product-edit' : 'product-add'}" method="post">
                    <!-- Hidden field for productID if editing -->
                    <c:if test="${action == 'edit'}">
                        <input type="hidden" name="productID" value="${product.productID}">
                    </c:if>

                    <div class="row g-3">
                        <!-- Product Name -->
                        <div class="col-md-8">
                            <label for="productName" class="form-label">Product Name</label>
                            <input type="text" class="form-control" id="productName" name="productName" value="${product.productName}" required placeholder="e.g. Dell XPS 15">
                        </div>

                        <!-- Product Type -->
                        <div class="col-md-4">
                            <label for="productType" class="form-label">Product Type</label>
                            <select class="form-select" id="productType" name="productType" required>
                                <option value="" disabled ${empty product.productType ? 'selected' : ''}>Choose type...</option>
                                <option value="Laptop" ${product.productType == 'Laptop' ? 'selected' : ''}>Laptop</option>
                                <option value="Smartphone" ${product.productType == 'Smartphone' ? 'selected' : ''}>Smartphone</option>
                                <option value="Tablet" ${product.productType == 'Tablet' ? 'selected' : ''}>Tablet</option>
                                <option value="Headphones" ${product.productType == 'Headphones' ? 'selected' : ''}>Headphones</option>
                                <option value="Smartwatch" ${product.productType == 'Smartwatch' ? 'selected' : ''}>Smartwatch</option>
                                <option value="Accessories" ${product.productType == 'Accessories' ? 'selected' : ''}>Accessories</option>
                            </select>
                        </div>

                        <!-- Price -->
                        <div class="col-md-6">
                            <label for="price" class="form-label">Price (USD)</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control" id="price" name="price" value="${product.price != null ? product.price : ''}" step="1" min="0" required placeholder="0">
                            </div>
                        </div>

                        <!-- Image URL -->
                        <div class="col-md-6">
                            <label for="imageURL" class="form-label">Image URL</label>
                            <input type="url" class="form-control" id="imageURL" name="imageURL" value="${product.imageURL}" placeholder="https://example.com/image.jpg">
                        </div>

                        <!-- Description -->
                        <div class="col-12">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="5" required placeholder="Provide a detailed product description here...">${product.description}</textarea>
                        </div>

                        <!-- Submit Buttons -->
                        <div class="col-12 text-end mt-4">
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-light me-2 border">Cancel</a>
                            <button type="submit" class="btn btn-primary-custom">
                                <c:choose>
                                    <c:when test="${action == 'edit'}">Save Changes</c:when>
                                    <c:otherwise>Create Product</c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />
