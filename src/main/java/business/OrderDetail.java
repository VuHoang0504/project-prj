package business;

import java.io.Serializable;

public class OrderDetail implements Serializable {
    private int orderID;
    private long productID;
    private int quantity;
    private double unitPrice;

    public OrderDetail() {
        this.orderID = 0;
        this.productID = 0;
        this.quantity = 0;
        this.unitPrice = 0.0;
    }

    public OrderDetail(int orderID, long productID, int quantity, double unitPrice) {
        this.orderID = orderID;
        this.productID = productID;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public long getProductID() {
        return productID;
    }

    public void setProductID(long productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }
}
