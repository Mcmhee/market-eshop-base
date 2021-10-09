import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:market/cartBlock/cart.dart';
import 'package:market/orderBlock/order.dart';
import 'package:market/productBlock/productScreen.dart';
import 'package:market/productBlock/product_detail.dart';
import 'package:market/productBlock/providers/products.dart';
import 'package:market/settings.dart';
import 'package:market/wishlist.dart';
import 'package:provider/provider.dart';
import 'Authenticate/autheticate.dart';
import 'cartBlock/cartView.dart';
import 'categorise.dart';
import 'home/home.dart';
import 'orderBlock/orderView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
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
          '/': (BuildContext context) => Authenticate(),
          '/home': (BuildContext context) => Home(),
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
