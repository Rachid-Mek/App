import 'package:flutter/material.dart';
import 'medicament.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function press;

  const ProductCard({Key? key, required this.product, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => press(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: HexColor("#6EBF8B"),
                width: 3,
              ),
            ),
            child: Hero(
              tag: "${product.id}",
              child: Image.network(
                product.image,
                height: 150,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.5),
            child: Text(
              product.name,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Text(
            "\$${product.price}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

