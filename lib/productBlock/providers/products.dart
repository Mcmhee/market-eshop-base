import 'package:flutter/foundation.dart';
import 'package:market/productBlock/providers/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _productItems = [
    Product(
        productImage:
            "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80",
        productName: "Blaz",
        productPrice: 12.20,
        productid: "1",
        isFav: false,
        productDiscount: "0"),
    Product(
        productImage:
            'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
        productName: "Blazer",
        productPrice: 12.0,
        productid: "2",
        isFav: false,
        productDiscount: "0"),
    Product(
        productImage:
            "https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80",
        productName: "Cup",
        productPrice: 20.19,
        productid: "3",
        isFav: false,
        productDiscount: "0"),
    Product(
        productImage:
            "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80",
        productName: "Blazer",
        productPrice: 99.99,
        productid: "4",
        isFav: false,
        productDiscount: "0"),
    Product(
        productImage:
            "https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80",
        productName: "Shoe",
        productPrice: 126.0,
        productid: "5",
        isFav: false,
        productDiscount: "0"),
    Product(
        productImage:
            "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80",
        productName: "Phone",
        productPrice: 15.60,
        productid: "6",
        isFav: true,
        productDiscount: "0"),
    Product(
        productImage:
            "https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80",
        productName: "tie",
        productPrice: 120.99,
        productid: "7",
        isFav: false,
        productDiscount: "0"),
  ];

  List<Product> get productItem => [..._productItems];

  Product findById(String id) {
    return _productItems.firstWhere((product) => product.productid == id);
  }

  List<Product> get favorites {
    return _productItems.where((product) => product.isFav == true).toList();
  }

  int get numberofFav {
    return favorites.length;
  }
}
