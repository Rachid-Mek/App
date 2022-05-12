library my_app.global;

import "package:flutter/material.dart";
import 'package:hexcolor/hexcolor.dart';
import 'package:app/med.dart';
import 'package:app/others.dart';
import 'package:app/shoppingcart.dart';
import 'package:app/globals.dart' as global;

class AddToCarte extends StatefulWidget {
  final int id, price, Miligramme, Qte;
  final String image, name;
  const AddToCarte({
    Key? key,
    required this.id,
    required this.Miligramme,
    required this.name,
    required this.Qte,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  State<AddToCarte> createState() => _AddToCarteState();
}

class _AddToCarteState extends State<AddToCarte> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            width: 330,
            child: ElevatedButton.icon(
              label: Text(
                "Ajouter au panier".toUpperCase(),
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              icon: Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                side: BorderSide(width: 3, color: HexColor("#069A8E")),
                primary: HexColor("#069A8E"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
              ),
              onPressed: () {
                setState(() {
                  global.shoppinglist = global.shoppinglist.toList();
                  global.shoppinglist.add(
                    Med(
                      id: widget.id,
                      image: widget.image,
                      name: widget.name,
                      Miligramme: widget.Miligramme,
                      Qte: widget.Qte,
                      price: widget.price,
                      QteAchte: global.qte,
                    ),
                  );
                  global.qte = 1;
                  shoppingcart(
                    shoppinglist: global.shoppinglist,
                  );
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            width: 330,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: HexColor("#069A8E"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
              ),
              onPressed: () {
                setState(() {
                  global.shoppinglist = global.shoppinglist.toList();
                  global.shoppinglist.add(
                    Med(
                      id: widget.id,
                      image: widget.image,
                      name: widget.name,
                      Miligramme: widget.Miligramme,
                      Qte: widget.Qte,
                      price: widget.price,
                      QteAchte: global.qte,
                    ),
                  );
                  global.qte = 1;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return shoppingcart(
                          shoppinglist: global.shoppinglist,
                        );
                      },
                    ),
                  );
                });
              },
              child: Text(
                "Reserver Maintenant".toUpperCase(),
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
