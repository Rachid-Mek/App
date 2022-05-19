// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:app/details/MapScreen.dart';
import 'package:app/details/addtocarte.dart';
import 'package:app/details/cartcounter.dart';
import 'package:app/details/productwithimage.dart';
import 'package:flutter/material.dart';
import 'package:app/globals.dart' as global;
import 'package:hexcolor/hexcolor.dart';

class Body extends StatefulWidget {
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
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var indext =
        global.shoppinglist.indexWhere((element) => element.id == widget.id);
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
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Notre location :  ",
                              style: TextStyle(fontSize: 18),
                            ),
                            ElevatedButton.icon(
                              label: Text(
                                "Voir la map".toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    width: 3, color: HexColor("#069A8E")),
                                primary: HexColor("#069A8E"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                              ),
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return MapSample();
                                      },
                                    ),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        indext == -1
                            ? CarteCounter(
                                QteR: (widget.Qte - 1),
                                id: widget.id,
                              )
                            : CarteCounter(
                                QteR: (widget.Qte -
                                    global.shoppinglist[indext].QteAchte),
                                id: widget.id,
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        AddToCarte(
                          id: widget.id,
                          Miligramme: widget.Miligramme,
                          name: widget.name,
                          Qte: widget.Qte,
                          price: widget.price,
                          image: widget.image,
                          idpharm: widget.idpharm,
                        )
                      ]),
                ),
                ProductTitlewithImage(
                    id: widget.id,
                    Miligramme: widget.Miligramme,
                    name: widget.name,
                    Qte: widget.Qte,
                    price: widget.price,
                    image: widget.image),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
