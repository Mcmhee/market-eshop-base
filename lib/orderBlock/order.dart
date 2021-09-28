import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:market/cartBlock/cart.dart';
import 'package:market/models/errorClass.dart';

class Order with ChangeNotifier {
  final String id;
  final double amount;
  final List<Cart> orderItems;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.amount,
    required this.orderItems,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];
  List<Order> get orders => [..._orders];

  Future<void> addOrder(List<Cart> cart, double total) async {
    var url = Uri.parse(
        'https://eshop-7a11c-default-rtdb.firebaseio.com/Orders.json');
    final timeStamp = DateTime.now();
    await http
        .post(url,
            body: json.encode({
              'amount': total,
              'orderItem': cart
                  .map((cart) => {
                        'id': cart.productId,
                        'productName': cart.productName,
                        'productImage': cart.productImage,
                        'price': cart.price,
                        'inStock': cart.inStock,
                        'productQuantity': cart.productQuantity,
                      })
                  .toList(),
              'dateTime': timeStamp.toIso8601String(),
            }))
        .then((response) {
      _orders.insert(
        0,
        Order(
          id: json.decode(response.body)['name'],
          amount: total,
          orderItems: cart,
          dateTime: timeStamp,
        ),
      );
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://eshop-7a11c-default-rtdb.firebaseio.com/Orders.json');
    try {
      final response = await http.get(url);
      final List<Order> tempLoadedOrderFromServer = [];
      final checker = json.decode(response.body);
      if (checker == null) {
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      // if (extractedData.isEmpty) {
      //   return;
      // }
      print(extractedData);
      extractedData.forEach((orderId, orderData) {
        tempLoadedOrderFromServer.add(Order(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          orderItems: (orderData['orderItem'] as List<dynamic>)
              .map((item) => Cart(
                    productId: item['id'],
                    price: item['price'],
                    productImage: item['productImage'],
                    productName: item['productName'],
                    productQuantity: item['productQuantity'],
                    inStock: item['inStock'],
                  ))
              .toList(),
        ));
      });
      _orders = tempLoadedOrderFromServer.reversed.toList();
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> deleteOrder(String id) async {
    final url = Uri.parse(
        'https://eshop-7a11c-default-rtdb.firebaseio.com/Orders/$id.json');
    final deletingOrderIndex =
        _orders.indexWhere((element) => element.id == id);
    var deletingOrder = _orders[deletingOrderIndex];

    await http.delete(url).then((value) {
      if (value.statusCode >= 400) {
        throw HttpException("error deleting product");
      }
    }).catchError((onError) {
      _orders.insert(deletingOrderIndex, deletingOrder);
      notifyListeners();
      throw onError;
    });
    _orders.removeAt(deletingOrderIndex);
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
