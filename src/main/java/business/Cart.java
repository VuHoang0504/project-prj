package business;

import java.io.Serializable;
import java.util.ArrayList;

public class Cart implements Serializable {
    private ArrayList<LineItem> itemList;

    public Cart() {
        itemList = new ArrayList<>();
    }

    public ArrayList<LineItem> getItemList() {
        return itemList;
    }

    public void setItemList(ArrayList<LineItem> itemList) {
        this.itemList = itemList;
    }

    public int getCount() {
        return itemList.size();
    }

    public void addItem(LineItem item) {
        long code = item.getProduct().getProductID();
        int quantity = item.getQuantity();
        for (LineItem lineItem : itemList) {
            if (lineItem.getProduct().getProductID() == code) {
                lineItem.setQuantity(lineItem.getQuantity() + quantity);
                return;
            }
        }
        itemList.add(item);
    }

    public void removeItem(long productID) {
        for (int i = 0; i < itemList.size(); i++) {
            LineItem lineItem = itemList.get(i);
            if (lineItem.getProduct().getProductID() == productID) {
                itemList.remove(i);
                return;
            }
        }
    }

    public void updateQuantity(long productID, int quantity) {
        if (quantity <= 0) {
            removeItem(productID);
            return;
        }
        for (LineItem lineItem : itemList) {
            if (lineItem.getProduct().getProductID() == productID) {
                lineItem.setQuantity(quantity);
                return;
            }
        }
    }

    public double getTotal() {
        double total = 0.0;
        for (LineItem item : itemList) {
            total += item.getTotal();
        }
        return total;
    }
}
