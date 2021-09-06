import 'package:flutter/material.dart';

import 'package:market/categoriesList.dart';

class Categorise extends StatefulWidget {
  @override
  _CategoriseState createState() => _CategoriseState();
}

class _CategoriseState extends State<Categorise> {
  final List<CategoriesItem> imgList = [
    const CategoriesItem(
      image: 'assets/images/cats/accessories.png',
      dsc: 'Accesories',
    ),
    const CategoriesItem(
      image: 'assets/images/cats/formal.png',
      dsc: 'Formal',
    ),
    const CategoriesItem(
      image: 'assets/images/cats/informal.png',
      dsc: 'Informal',
    ),
    const CategoriesItem(
      image: 'assets/images/cats/jeans.png',
      dsc: 'Pants',
    ),
    const CategoriesItem(
      image: 'assets/images/cats/shoe.png',
      dsc: 'Shoes',
    ),
    const CategoriesItem(
      image: 'assets/images/cats/tshirt.png',
      dsc: 'Shirts',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorise'),
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 8, left: 6, right: 6, bottom: 8),
          children: List.generate(6, (index) {
            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  print('Card tapped.');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Image.asset(
                          imgList[index].image,
                          fit: BoxFit.contain,
                          errorBuilder: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    ListTile(
                        title: Text(
                      imgList[index].dsc,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ))
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
