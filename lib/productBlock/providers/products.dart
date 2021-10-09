import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class ProductsProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
      var urlFav = Uri.parse(
          'https://eshop-7a11c-default-rtdb.firebaseio.com/userFav/${_auth.currentUser!.uid}.json');
      final responseFav = await http.get(urlFav);
      final favState = json.decode(responseFav.body);
      extractedData.forEach((prodId, prodData) {
        tempLoadedProductsFromServer.add(Product(
          productid: prodId,
          productName: prodData['productName'],
          productImage: prodData['productImage'],
          productPrice: prodData['productPrice'],
          productDsc: prodData['productDsc'],
          productDiscount: prodData['productDiscount'],
          isFav: favState == null ? false : favState[prodId] ?? false,
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
