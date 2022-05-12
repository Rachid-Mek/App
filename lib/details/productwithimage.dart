import "package:flutter/material.dart";

class ProductTitlewithImage extends StatelessWidget {
  final int id, price, Miligramme, Qte;
  final String image, name;

  const ProductTitlewithImage({
    Key? key,
    required this.id,
    required this.Miligramme,
    required this.name,
    required this.Qte,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Miligramme != 0) {
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
              "${name} ${Miligramme}mg",
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: "\$${price}",
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ]),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Hero(
                  tag: "${id}",
                  child: Image.network(
                    "https://pharmacile.000webhostapp.com/site/uploads/${image}",
                    fit: BoxFit.fill,
                    height: 245,
                  ),
                ))
              ],
            )
          ],
        ),
      );
    } else {
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
              "${name} ",
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: "\$${price}",
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ]),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Hero(
                    tag: "${id}",
                    child: Image.network(
                      "https://pharmacile.000webhostapp.com/site/uploads/${image}",
                      fit: BoxFit.fill,
                      height: 245,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
  }
}
