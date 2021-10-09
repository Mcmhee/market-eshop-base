import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market/Authenticate/Methods.dart';
import 'package:market/cartBlock/cart.dart';
import 'package:market/productBlock/providers/products.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final wishlistbanner = Provider.of<ProductsProvider>(context);
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/drawer-header.jpg'),
          )),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
                _auth.currentUser!.photoURL ??
                    "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                scale: 4 / 2),
          ),
          accountEmail: Text(_auth.currentUser!.email.toString()),
          accountName: Text(_auth.currentUser!.displayName.toString()),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.category,
                    color: Theme.of(context).colorScheme.secondary),
                title: const Text('Categorise'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/categorise');
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite,
                    color: Theme.of(context).colorScheme.secondary),
                title: const Text('My Wishlist'),
                trailing: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    wishlistbanner.numberofFav.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/wishlist');
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart,
                    color: Theme.of(context).colorScheme.secondary),
                title: const Text('My Cart'),
                trailing: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    '${Provider.of<Carts>(context).carts.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/cart');
                },
              ),
              ListTile(
                leading: Icon(Icons.money,
                    color: Theme.of(context).colorScheme.secondary),
                title: const Text('My Orders'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/orderScreen');
                },
              ),
              const Divider(
                height: 20,
                color: Colors.black,
              ),
              const SizedBox(
                height: 120.0,
              ),
              const Divider(
                height: 20,
                color: Colors.black,
              ),
              ListTile(
                leading: Icon(Icons.settings,
                    color: Theme.of(context).colorScheme.secondary),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              ListTile(
                leading: Icon(Icons.lock,
                    color: Theme.of(context).colorScheme.secondary),
                title: const Text('Login'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/auth');
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app,
                    color: Theme.of(context).colorScheme.secondary),
                title: const Text('Logout'),
                onTap: () async {
                  await logOut(context);
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
