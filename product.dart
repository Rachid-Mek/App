import 'dart:math';
import 'package:flutter/material.dart';
import 'medicament.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.deepPurple[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.network(
            product.image,
            height: 150,
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
    );
  }
}
