import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'globals.dart' as global;

class ProductCard extends StatelessWidget {
  final int id, price, Miligramme, Qte;
  final String image, name;
  final Function press;

  const ProductCard({
    Key? key,
    required this.id,
    required this.Miligramme,
    required this.name,
    required this.Qte,
    required this.price,
    required this.image,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var indext = global.shoppinglist.indexWhere((element) => element.id == id);
    if (Miligramme != 0) {
      return GestureDetector(
        onTap: () => press(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 150,
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
                tag: "${id}",
                child: Image.network(
                  "https://pharmacile.000webhostapp.com/site/uploads/${image}",
                  height: 150,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.5),
              child: Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "${Miligramme}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    indext == -1
                        ? "Quantité: ${Qte}"
                        : "Quantité: ${Qte - global.shoppinglist[indext].QteAchte}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${price}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => press(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 150,
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
                tag: "${id}",
                child: Image.network(
                  "https://pharmacile.000webhostapp.com/site/uploads/${image}",
                  height: 150,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.5),
              child: Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    indext == -1
                        ? "Quantité: ${Qte}"
                        : "Quantité: ${Qte - global.shoppinglist[indext].QteAchte}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${price}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
