import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:market/cartBlock/cart.dart';
import 'package:market/orderBlock/order.dart';
import 'package:provider/provider.dart';

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  bool _orderButton = false;

  @override
  Widget build(BuildContext context) {
    final cartInstance = Provider.of<Carts>(context);
    final count = cartInstance.carts.length;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Text(
                cartInstance.carts.length.toString() + " ITEMS IN YOUR CART",
                textDirection: TextDirection.ltr,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      // Each Dismissible must contain a Key. Keys allow Flutter to
                      // uniquely identify widgets.
                      key: Key(UniqueKey().toString()),
                      // Provide a function that tells the app
                      // what to do after an item has been swiped away.
                      onDismissed: (direction) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(cartInstance.carts.values
                                    .toList()[index]
                                    .productName +
                                " Removed from Cart"),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                        Provider.of<Carts>(context, listen: false)
                            .removeFromCart(
                                cartInstance.carts.keys.toList()[index]);
                        // if (direction == DismissDirection.endToStart) {
                        //   // Then show a snackbar.
                        //   cartInstance.removeFromCart(cartInstance.carts.values
                        //       .toList()[index]
                        //       .productId);

                        // } else {
                        //   cartInstance.removeFromCart(cartInstance.carts.values
                        //       .toList()[index]
                        //       .productId);
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(cartInstance.carts.values
                        //               .toList()[index]
                        //               .productName +
                        //           " Removed from Cart"),
                        //       duration: const Duration(seconds: 1),
                        //     ),
                        //   );
                        // }
                      },
                      direction: DismissDirection.endToStart,
                      // Show a red background as the item is swiped away.
                      background: Container(
                        decoration: const BoxDecoration(color: Colors.red),
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      // secondaryBackground: Container(
                      //   decoration: const BoxDecoration(color: Colors.red),
                      //   padding: const EdgeInsets.all(5.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       const Padding(
                      //         padding: EdgeInsets.only(right: 20.0),
                      //         child: Icon(Icons.delete, color: Colors.white),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/productsDetail',
                              arguments: cartInstance.carts.values
                                  .toList()[index]
                                  .productId);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Divider(
                              height: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              child: ListTile(
                                trailing: SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Spacer(),
                                      Text(
                                          '\$ ${cartInstance.carts.values.toList()[index].price}'),
                                      Text(
                                        'X ${cartInstance.carts.values.toList()[index].productQuantity}',
                                        style: const TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 13.0,
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Container(
                                    decoration:
                                        const BoxDecoration(color: Colors.blue),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: cartInstance.carts.values
                                          .toList()[index]
                                          .productImage,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  cartInstance.carts.values
                                      .toList()[index]
                                      .productName,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, bottom: 1),
                                          child: cartInstance.carts.values
                                                  .toList()[index]
                                                  .inStock
                                              ? Text(
                                                  'In Stock',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                )
                                              : const Text(
                                                  'Out of stock',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                        ),
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
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "TOTAL",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        )),
                        Text(cartInstance.total.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 15.0),
                  //   child: Row(
                  //     children: [
                  //       const Expanded(
                  //           child: Text("Subtotal",
                  //               style: TextStyle(fontSize: 14))),
                  //       const Text("\$36.00",
                  //           style: TextStyle(fontSize: 14, color: Colors.grey)),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text("Shipping",
                                style: TextStyle(fontSize: 14))),
                        const Text("\$5.00",
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text("Tax", style: TextStyle(fontSize: 14))),
                        const Text("\$2.00",
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 50, bottom: 10),
              child: ButtonTheme(
                buttonColor: Theme.of(context).primaryColor,
                minWidth: double.infinity,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: cartInstance.total <= 0
                      ? null
                      : () async {
                          try {
                            setState(() {
                              _orderButton = true;
                            });
                            await Provider.of<Orders>(context, listen: false)
                                .addOrder(
                              cartInstance.carts.values.toList(),
                              cartInstance.total,
                            )
                                .then((value) {
                              cartInstance.clearCart();
                              setState(() {
                                _orderButton = false;
                              });
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Your Order have been sent"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Opps an error occured"),
                                content: Text(e.toString()),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text("Okay"),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                  child: _orderButton
                      ? const SizedBox(
                          width: 100,
                          height: 30,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ))
                      : const Text(
                          "CHECKOUT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ));
  }
}
