import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _productItems = [];

  List<Product> get productItems => [..._productItems];

  Product findById(String id) {
    return _productItems.firstWhere((product) => product.productid == id);
  }

  List<Product> get favorites {
    return _productItems.where((product) => product.isFav == true).toList();
  }

  int get numberofFav {
    return favorites.length;
  }

  Future<void> fetchAndSetProducts() async {
    var url = Uri.parse(
        'https://eshop-7a11c-default-rtdb.firebaseio.com/Products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> tempLoadedProductsFromServer = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodId, prodData) {
        tempLoadedProductsFromServer.add(Product(
          productid: prodId,
          productName: prodData['productName'],
          productImage: prodData['productImage'],
          productPrice: prodData['productPrice'],
          productDsc: prodData['productDsc'],
          productDiscount: prodData['productDiscount'],
          isFav: prodData['isFav'],
        ));
      });
      _productItems = tempLoadedProductsFromServer;
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
