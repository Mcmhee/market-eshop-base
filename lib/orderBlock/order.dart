import 'package:flutter/material.dart';
import 'package:market/cartBlock/cart.dart';

class Order with ChangeNotifier {
  final String id;
  final double amount;
  final List<Cart> ordersItem;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.amount,
    required this.ordersItem,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];
  List<Order> get orders => [..._orders];

  void addOrder(List<Cart> cart, double total) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        amount: total,
        ordersItem: cart,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void clear() {
    _orders = [];
    notifyListeners();
  }

  void removeOrder(String productId) {
    _orders.remove(productId);
    notifyListeners();
  }
}
