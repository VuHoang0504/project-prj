package business;

import java.io.Serializable;

public class Product implements Serializable {
    private long productID;
    private String productName;
    private String description;
    private String productType;
    private double price;
    private String imageURL;

    public Product() {
        this.productID = 0;
        this.productName = "";
        this.description = "";
        this.productType = "";
        this.price = 0.0;
        this.imageURL = "";
    }

    public Product(long productID, String productName, String description, String productType, double price, String imageURL) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.productType = productType;
        this.price = price;
        this.imageURL = imageURL;
    }

    public long getProductID() {
        return productID;
    }

    public void setProductID(long productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
}
