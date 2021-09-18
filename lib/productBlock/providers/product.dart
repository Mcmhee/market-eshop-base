import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String productImage;
  final String productName;
  final double productPrice;
  final String productDiscount;
  final String productid;
  bool isFav;

  Product({
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productid,
    this.productDiscount = "-0",
    this.isFav = false,
  });

  void toggleFavoriteState() {
    isFav = !isFav;
    notifyListeners();
  }
}
