import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:market/providers/products.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerProductData = Provider.of<ProductsProvider>(context);
    final productList = providerProductData.productItem;
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: productList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        padding: const EdgeInsets.only(
          top: 8,
          left: 6,
          right: 6,
          bottom: 12,
        ),
        itemBuilder: (ctx, i) {
          return Container(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/productsDetail',
                      arguments: productList[i].productid);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: (MediaQuery.of(context).size.width / 2) - 70,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: productList[i].productImage,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        productList[i].productName,
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_outline_outlined),
                      ),
                      leading: Text(
                        productList[i].productPrice.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
