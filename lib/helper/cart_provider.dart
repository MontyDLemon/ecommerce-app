import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  double amount = 0;
  List<Product> prods = [];
  //id: quantità
  Map<int, int> quantity = {};
  int itemsLength = 0;

  void addItem(Product item) {
    amount += item.price;
    quantity[item.id] == null
        ? quantity[item.id] = 1
        : quantity[item.id] = quantity[item.id]! + 1;
    itemsLength++;
    //usando set anzichè list non mi worka, bhoo lo faccio con lista
    if (quantity[item.id] == 1) {
      prods.add(item);
    }
    notifyListeners();
  }

//per ora si può rimuovere 1 elemento alla volta
  void removeItem(Product item) {
    amount -= item.price;
    quantity[item.id] = quantity[item.id]! - 1;
    itemsLength--;
    //rimuovo elemento se non ne ho più
    if (quantity[item.id] == 0) {
      prods.remove(item);
    }
    notifyListeners();
  }
}
