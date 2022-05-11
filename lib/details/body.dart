// ignore_for_file: prefer_const_constructors

import 'package:app/details/addtocarte.dart';
import 'package:app/details/cartcounter.dart';
import 'package:app/details/productwithimage.dart';
import 'package:app/medicament.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final Product product;
  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        CarteCounter(),
                        SizedBox(
                          height: 10,
                        ),
                        AddToCarte()
                      ]),
                ),
                ProductTitlewithImage(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}
