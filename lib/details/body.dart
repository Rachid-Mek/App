// ignore_for_file: prefer_const_constructors
import 'package:app/details/MapScreen.dart';
import 'package:app/details/addtocarte.dart';
import 'package:app/details/cartcounter.dart';
import 'package:app/details/productwithimage.dart';
import 'package:flutter/material.dart';
import 'package:app/globals.dart' as global;
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Body extends StatefulWidget {
  final int id, price, Miligramme, idpharm;
  int Qte;
  final String image, name, pharmemail;
  Body({
    Key? key,
    required this.id,
    required this.idpharm,
    required this.Miligramme,
    required this.name,
    required this.pharmemail,
    required this.Qte,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(global.globalproductList.length);
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
                  height: size.height,
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
                        SizedBox(
                          height: 10,
                        ),
                        if (indext == -1) ...[
                          if (widget.Qte == 0) ...[
                            CarteCounter(
                              QteR: widget.Qte,
                              id: widget.id,
                              QteM: widget.Qte,
                            ),
                          ] else ...[
                            CarteCounter(
                              QteR: (widget.Qte - 1),
                              id: widget.id,
                              QteM: widget.Qte,
                            ),
                          ]
                        ] else ...[
                          CarteCounter(
                            QteR: (widget.Qte -
                                global.shoppinglist[indext].QteAchte),
                            id: widget.id,
                            QteM: widget.Qte,
                          ),
                        ],
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
                          pharmemail: widget.pharmemail,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "A propos de nous:",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "la Pharmacie: ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor("#069A8E")),
                            ),
                            Flexible(
                              child: Text(
                                global.globalproductList.length == 0
                                    ? ""
                                    : "${global.globalproductList[0]["Name"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Numéro: ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor("#069A8E")),
                            ),
                            Flexible(
                              child: Text(
                                global.globalproductList.length == 0
                                    ? ""
                                    : "${global.globalproductList[0]["Contact_Number1"]} / ${global.globalproductList[0]["Contact_Number2"]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Email: ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor("#069A8E")),
                            ),
                            Flexible(
                              child: Text(
                                global.globalproductList.length == 0
                                    ? ""
                                    : "${global.globalproductList[0]["Email"]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Localisation :  ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor("#069A8E")),
                            ),
                            Flexible(
                              child: global.globalproductList.length != 0
                                  ? ElevatedButton.icon(
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
                                            width: 3,
                                            color: HexColor("#069A8E")),
                                        primary: HexColor("#069A8E"),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return MapApp(
                                                    lant: double.parse(global
                                                        .globalproductList[0]
                                                            ["Location"]
                                                        .toString()
                                                        .split("/")[0]),
                                                    long: double.parse(global
                                                        .globalproductList[0]
                                                            ["Location"]
                                                        .toString()
                                                        .split("/")[1]));
                                              },
                                            ),
                                          );
                                        });
                                      },
                                    )
                                  : Text(""),
                            ),
                          ],
                        ),
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
