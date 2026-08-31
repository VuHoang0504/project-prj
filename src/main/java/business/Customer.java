package business;

import java.io.Serializable;

public class Customer implements Serializable {
    private int customerID;
    private String customerName;
    private String email;
    private String customerAddress;
    private String customerPhone;
    private String note;

    public Customer() {
        this.customerID = 0;
        this.customerName = "";
        this.email = "";
        this.customerAddress = "";
        this.customerPhone = "";
        this.note = "";
    }

    public Customer(int customerID, String customerName, String email, String customerAddress, String customerPhone, String note) {
        this.customerID = customerID;
        this.customerName = customerName;
        this.email = email;
        this.customerAddress = customerAddress;
        this.customerPhone = customerPhone;
        this.note = note;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}
