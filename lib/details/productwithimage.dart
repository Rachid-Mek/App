import 'package:app/medicament.dart';
import "package:flutter/material.dart";

class ProductTitlewithImage extends StatelessWidget {
  const ProductTitlewithImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            "Le produit ou medicament",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            product.name,
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: 'Prix\n',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: "\$${product.price}",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ]),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Hero(
                tag: "${product.id}",
                child: Image.network(
                  product.image,
                  fit: BoxFit.fill,
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
