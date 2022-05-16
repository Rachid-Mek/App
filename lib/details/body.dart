// ignore_for_file: prefer_const_constructors

import 'package:app/details/addtocarte.dart';
import 'package:app/details/cartcounter.dart';
import 'package:app/details/productwithimage.dart';
import 'package:flutter/material.dart';
import 'package:app/globals.dart' as global;

class Body extends StatelessWidget {
  final int id, price, Miligramme, idpharm;
  int Qte;
  final String image, name;
  Body({
    Key? key,
    required this.id,
    required this.idpharm,
    required this.Miligramme,
    required this.name,
    required this.Qte,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var indext = global.shoppinglist.indexWhere((element) => element.id == id);
    Size size = MediaQuery.of(context).size;
    //it provided us total height and width
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                //la partie blanche
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                      top: size.height * 0.12, left: 15, right: 15),
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "A propos de nous:",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "L'ouverture du notre pharmacie est du 8h.00 à 00.00",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        indext == -1
                            ? CarteCounter(
                                QteR: (Qte - 1),
                                id: id,
                              )
                            : CarteCounter(
                                QteR: (Qte -
                                    global.shoppinglist[indext].QteAchte),
                                id: id,
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        AddToCarte(
                          id: id,
                          Miligramme: Miligramme,
                          name: name,
                          Qte: Qte,
                          price: price,
                          image: image,
                          idpharm: idpharm,
                        )
                      ]),
                ),
                ProductTitlewithImage(
                    id: id,
                    Miligramme: Miligramme,
                    name: name,
                    Qte: Qte,
                    price: price,
                    image: image)
              ],
            ),
          )
        ],
      ),
    );
  }
}
