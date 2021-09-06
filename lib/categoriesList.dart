import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
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
        ],
      ),
    );
  }
}

class CategoriesItem extends StatelessWidget {
  final String image;
  final String dsc;

  // ignore: use_key_in_widget_constructors
  const CategoriesItem({
    required this.image,
    required this.dsc,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: 100.0,
      child: ListTile(
        title: Image.asset(
          image,
          width: 120.0,
          height: 45.0,
        ),
        subtitle: Text(
          dsc,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
