import 'package:flutter/material.dart';
import 'package:market/product_detail.dart';
import 'package:market/settings.dart';
import 'package:market/shop/shop.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.deepOrange.shade500, fontFamily: 'Lato'),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => Home(),
          '/auth': (BuildContext context) => Auth(),
          '/shop': (BuildContext context) => Shop(),
          '/categorise': (BuildContext context) => Categorise(),
          '/wishlist': (BuildContext context) => WishList(),
          '/cart': (BuildContext context) => CartList(),
          '/settings': (BuildContext context) => Settings(),
          '/products': (BuildContext context) => Products()
        },
      ),
    ),
  );
}
