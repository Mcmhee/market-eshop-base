import 'package:flutter/material.dart';
import 'package:market/productBlock/productScreen.dart';
import 'package:market/productBlock/product_detail.dart';
import 'package:market/providers/products.dart';
import 'package:market/settings.dart';

import 'package:market/wishlist.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';
import 'blocks/auth_block.dart';
import 'cart.dart';
import 'categorise.dart';
import 'home/home.dart';

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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.lime, fontFamily: 'Lato'),
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
        },
      ),
    ),
  );
}
