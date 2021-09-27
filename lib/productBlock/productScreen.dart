import 'package:flutter/material.dart';
import 'package:market/productBlock/productsView.dart';
import 'package:market/productBlock/providers/products.dart';
import 'package:provider/provider.dart';

// ==================== this is where View All comes when clicked from home screen
class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
