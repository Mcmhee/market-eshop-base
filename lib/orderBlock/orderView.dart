import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:market/orderBlock/order.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              icon: Icon(_isExpanded ? Icons.visibility_off : Icons.visibility),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.error != null) {
                return const Center(
                  child: Text("sorry an error occured"),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, orderInstance, child) {
                    return ListView.builder(
                      itemCount: orderInstance.orders.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                  "\$${orderInstance.orders[index].amount}"),
                              subtitle: Text(
                                DateFormat('dd/MM/yyy hh:mm').format(
                                    orderInstance.orders[index].dateTime),
                              ),
                              // orderInstance.orders[index].dateTime),
                              trailing: IconButton(
                                onPressed: () {
                                  orderInstance.deleteOrder(
                                      orderInstance.orders[index].id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            if (_isExpanded)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                height: min(
                                  orderInstance.orders.length * 10 + 10,
                                  150,
                                ),
                                child: ListView(
                                  children: orderInstance
                                      .orders[index].orderItems
                                      .map((orderItem) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                orderItem.productName,
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${orderItem.price} X ${orderItem.productQuantity}',
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          }),
    );
  }
}
