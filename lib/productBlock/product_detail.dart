import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:market/cartBlock/cart.dart';
import 'package:market/productBlock/providers/products.dart';
import 'package:provider/provider.dart';

class ProductsDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final tappedProductDetails =
        Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
    final cartInstance = Provider.of<Carts>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(tappedProductDetails.productName),
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: 260,
                child: Hero(
                  tag: productId,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: tappedProductDetails.productImage,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: const Alignment(-1.0, -1.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          tappedProductDetails.productName,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(
                                  "N${tappedProductDetails.productPrice.toString()}",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(tappedProductDetails.productDiscount,
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const RatingStars(
                                value: 5,
                                starSize: 16,
                                valueLabelColor: Colors.amber,
                                starColor: Colors.amber,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                            alignment: const Alignment(-1.0, -1.0),
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Description',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                        Container(
                            alignment: const Alignment(-1.0, -1.0),
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. but also the leap into electronic typesetting Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            )),
                        ElevatedButton(
                          child: Text(
                            "Add to Cart".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          onPressed: () {
                            cartInstance.addToCart(
                              tappedProductDetails.productid,
                              tappedProductDetails.productPrice,
                              tappedProductDetails.productName,
                              tappedProductDetails.productImage,
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
