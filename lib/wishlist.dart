import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import 'package:market/productBlock/providers/products.dart';
import 'package:provider/provider.dart';

import 'cartBlock/cart.dart';

class WishList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<ProductsProvider>(context).favorites;
    final cartInstance = Provider.of<Carts>(context);
    // final changeFav = Provider.of<Product>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          final singleProductItem = wishlist[index];
          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify widgets.
            key: Key(UniqueKey().toString()),
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                // Then show a snackbar.
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(singleProductItem.productName + " dismissed"),
                    duration: const Duration(seconds: 1)));
                singleProductItem.toggleFavoriteState();
                //  changeFav.toggleFavoriteState();
              } else {
                // Then show a snackbar.
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text(singleProductItem.productName + " added to carts"),
                    duration: const Duration(seconds: 1)));

                cartInstance.addToCart(
                  singleProductItem.productid,
                  singleProductItem.productPrice,
                  singleProductItem.productName,
                  singleProductItem.productImage,
                );
                singleProductItem.toggleFavoriteState();
              }
            },
            // Show a red background as the item is swiped away.
            background: Container(
              decoration: const BoxDecoration(color: Colors.green),
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(Icons.add_shopping_cart, color: Colors.white),
                  ),
                ],
              ),
            ),
            secondaryBackground: Container(
              decoration: const BoxDecoration(color: Colors.red),
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ],
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/productsDetail',
                    arguments: singleProductItem.productid);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Divider(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: ListTile(
                      trailing: const Icon(Icons.swap_horiz),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.blue),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: singleProductItem.productImage,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      title: Text(
                        singleProductItem.productName,
                        style: const TextStyle(fontSize: 14),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 2.0, bottom: 1),
                                child: Text(
                                    singleProductItem.productPrice.toString(),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: Text(singleProductItem.productDiscount,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey,
                                        decoration:
                                            TextDecoration.lineThrough)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              RatingStars(
                                value: 3.5,
                                starSize: 16,
                                valueLabelColor: Colors.amber,
                                starColor: Colors.amber,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
