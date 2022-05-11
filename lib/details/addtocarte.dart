import "package:flutter/material.dart";
import 'package:hexcolor/hexcolor.dart';

class AddToCarte extends StatelessWidget {
  const AddToCarte({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            width: 330,
            child: Expanded(
              child: ElevatedButton.icon(
                label: Text(
                  "Ajouter au panier".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                icon: Image.asset(
                  "images/add-to-cart.png",
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 3, color: HexColor("#069A8E")),
                  primary: HexColor("#069A8E"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: () {},
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            width: 330,
            child: Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: HexColor("#069A8E"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: () {},
                child: Text(
                  "Reserver Maintenant".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
