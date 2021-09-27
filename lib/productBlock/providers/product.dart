import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String productImage;
  final String productName;
  final double productPrice;
  final String productDiscount;
  final String productDsc;
  final String productid;
  bool isFav;

  Product({
    required this.productid,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDsc,
    this.productDiscount = "-0",
    this.isFav = false,
  });

  Future<void> toggleFavoriteState() async {
    final oldStatus = isFav;
    isFav = !isFav;
    var url = Uri.parse(
        'https://eshop-7a11c-default-rtdb.firebaseio.com/Products/$productid.json');
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFav': isFav,
        }),
      );
      if (response.statusCode >= 400) {
        isFav = oldStatus;
        notifyListeners();
      }
      notifyListeners();
    } catch (error) {
      isFav = oldStatus;
      notifyListeners();
    }
  }
}
