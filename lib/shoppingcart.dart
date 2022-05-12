// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/med.dart';
import 'package:app/others.dart';
import 'globals.dart' as global;

class shoppingcart extends StatefulWidget {
  List<Med> shoppinglist = List.empty();
  shoppingcart({Key? key, required this.shoppinglist}) : super(key: key);

  @override
  State<shoppingcart> createState() => _shoppingcartState();
}

class _shoppingcartState extends State<shoppingcart> {
  @override
  void initState() {
    super.initState();
    total();
  }

  @override
  Widget build(BuildContext context) {
    if (global.prixtotal != 0) {
      return Scaffold(
        backgroundColor: HexColor("#EDE6DB"),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    "Panier",
                    style: GoogleFonts.staatliches(
                      textStyle: TextStyle(
                        color: HexColor("#069A8E"),
                        fontWeight: FontWeight.w400,
                        fontSize: 48,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  height: 375,
                  child: ListView.builder(
                    itemCount: widget.shoppinglist.length,
                    itemBuilder: (context, index) => other(
                        id: widget.shoppinglist[index].id,
                        img: widget.shoppinglist[index].image,
                        name: widget.shoppinglist[index].name,
                        mg: widget.shoppinglist[index].Miligramme,
                        qte: widget.shoppinglist[index].Qte,
                        qteAchete: widget.shoppinglist[index].QteAchte,
                        price: widget.shoppinglist[index].price),
                    scrollDirection: Axis.vertical,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          "Votre Total Est",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          "${global.prixtotal}",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: SizedBox(
                          width: 165,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (() {
                              setState(
                                () {},
                              );
                            }),
                            child: const Text(
                              "Résever",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: HexColor("#069A8E"),
                                shape: StadiumBorder()),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: HexColor("#EDE6DB"),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    "Panier",
                    style: GoogleFonts.staatliches(
                      textStyle: TextStyle(
                        color: HexColor("#069A8E"),
                        fontWeight: FontWeight.w400,
                        fontSize: 48,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
                Text(
                  "Votre Panier Est Vide",
                  style: GoogleFonts.staatliches(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 48,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}

total() {
  int prixprod = 0;
  global.prixtotal = 0;
  global.shoppinglist.forEach(
    (element) {
      prixprod = element.QteAchte * element.price;
      global.prixtotal = global.prixtotal + prixprod;
    },
  );
}
