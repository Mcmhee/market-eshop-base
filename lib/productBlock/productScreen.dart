import 'package:flutter/material.dart';
import 'package:market/productBlock/productsView.dart';

// ==================== this is where View All comes when clicked from home screen
class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: SingleChildScrollView(child: ProductView()),
    );
  }
}
