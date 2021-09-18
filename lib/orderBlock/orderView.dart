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
    final orderInstance = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: ListView.builder(
        itemCount: orderInstance.orders.length,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                title: Text("\$${orderInstance.orders[index].amount}"),
                subtitle: Text(
                  DateFormat('dd/MM/yyy hh:mm')
                      .format(orderInstance.orders[index].dateTime),
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  icon:
                      Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                ),
              ),
              if (_isExpanded)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: min(
                    orderInstance.orders.length * 20 + 10,
                    100,
                  ),
                  child: ListView(
                    children: orderInstance.orders[index].ordersItem
                        .map((orderItem) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}
