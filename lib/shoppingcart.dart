// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/others.dart';

class shoppingcart extends StatefulWidget {
  shoppingcart({Key? key}) : super(key: key);

  @override
  State<shoppingcart> createState() => _shoppingcartState();
}

class _shoppingcartState extends State<shoppingcart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#EDE6DB"),
      body: SafeArea(
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
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  other(
                      img: "images/doli500.jpg",
                      name: "doliprane",
                      mg: 500,
                      qte: 10,
                      price: 60),
                  other(
                      img: "images/doli500.jpg",
                      name: "doliprane",
                      mg: 500,
                      qte: 10,
                      price: 60),
                  other(
                      img: "images/doli500.jpg",
                      name: "doliprane",
                      mg: 500,
                      qte: 10,
                      price: 60),
                  other(
                      img: "images/doli500.jpg",
                      name: "doliprane",
                      mg: 500,
                      qte: 10,
                      price: 60),
                ],
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
                      "360 DA",
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
    );
  }
}
