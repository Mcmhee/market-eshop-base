import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cart with ChangeNotifier {
  final String productId;
  final String productName;
  final int productQuantity;
  final double price;
  final String productImage;
  final bool inStock;

  Cart({
    required this.productId,
    required this.productName,
    required this.productQuantity,
    required this.price,
    required this.productImage,
    this.inStock = true,
  });
}

class Carts with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, Cart> _carts = {};

  Map<String, Cart> get carts {
    return {..._carts};
  }

  void addToCart(
    String id,
    double price,
    String productName,
    String productImage,
  ) {
    if (_carts.containsKey(id)) {
      _carts.update(
        id,
        (existingValue) => Cart(
            inStock: existingValue.inStock,
            productImage: existingValue.productImage,
            productId: existingValue.productId,
            price: existingValue.price,
            productName: existingValue.productName,
            productQuantity: existingValue.productQuantity + 1),
      );
    } else {
      _carts.putIfAbsent(
          id,
          () => Cart(
                productId: DateTime.now().toString(),
                productName: productName,
                productQuantity: 1,
                price: price,
                productImage: productImage,

                //inStock: inStock,
              ));
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _carts.remove(productId);
    notifyListeners();
  }

  double get total {
    var total = 0.0;
    var shipping = 5.0;
    var tax = 3.0;
    _carts.forEach((key, cartItem) {
      total += cartItem.price * cartItem.productQuantity + shipping + tax;
    });
    return total;
  }

  void clearCart() {
    _carts = {};
    notifyListeners();
  }
}
