import 'package:flutter/material.dart';
import 'package:market/cartBlock/cart.dart';
import 'package:market/orderBlock/order.dart';
import 'package:market/productBlock/productScreen.dart';
import 'package:market/productBlock/product_detail.dart';
import 'package:market/productBlock/providers/products.dart';
import 'package:market/settings.dart';

import 'package:market/wishlist.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';
import 'blocks/auth_block.dart';
import 'cartBlock/cartView.dart';
import 'categorise.dart';
import 'home/home.dart';
import 'orderBlock/orderView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthBlock>.value(
          value: AuthBlock(),
        ),
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Carts(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.lime,
          fontFamily: 'Lato',
        ),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => Home(),
          '/auth': (BuildContext context) => Auth(),
          '/categorise': (BuildContext context) => Categorise(),
          '/wishlist': (BuildContext context) => WishList(),
          '/cart': (BuildContext context) => CartList(),
          '/settings': (BuildContext context) => Settings(),
          '/productsDetail': (BuildContext context) => ProductsDetail(),
          '/productsScreen': (BuildContext context) => ProductScreen(),
          '/orderScreen': (BuildContext context) => OrderScreen(),
        },
      ),
    ),
  );
}
