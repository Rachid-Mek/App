// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/main.dart';
import 'package:app/med.dart';
import 'package:app/others.dart';
import 'globals.dart' as global;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class shoppingcart extends StatefulWidget {
  List<Med> shoppinglist = List.empty();
  shoppingcart({Key? key, required this.shoppinglist}) : super(key: key);

  @override
  State<shoppingcart> createState() => _shoppingcartState();
}

class _shoppingcartState extends State<shoppingcart> {
  TextEditingController id = TextEditingController();
  TextEditingController iduser = TextEditingController();
  TextEditingController idpharm = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController Miligramme = TextEditingController();
  TextEditingController Qte = TextEditingController();
  TextEditingController QteAchte = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController pricetotal = TextEditingController();
  @override
  void initState() {
    super.initState();
    total();
  }

  @override
  Widget build(BuildContext context) {
    bool reserve = false;
    Future reserver() async {
      var url = "https://pharmacile.000webhostapp.com/appmobile/panier.php";

      for (var element in widget.shoppinglist) {
        var QteRestante = element.Qte - element.QteAchte;
        var Prix = element.QteAchte * element.price;

        id.text = element.id.toString();
        iduser.text = global.userID.toString();
        idpharm.text = element.idpharm.toString();
        //image.text = element.image,
        //name.text = element.name,
        //Miligramme.text = element.Miligramme.toString(),
        Qte.text = QteRestante.toString();
        QteAchte.text = element.QteAchte.toString();
        pricetotal.text = Prix.toString();

        var response = await http.post(
          Uri.parse(url),
          headers: {"Accept": "application/json"},
          body: {
            "id": id.text,
            "iduser": iduser.text,
            "idpharm": idpharm.text,
            "Qte": Qte.text,
            "QteAchte": QteAchte.text,
            "pricetotal": pricetotal.text,
          },
        );

        if (jsonDecode(response.body) == "error 1") {
          Fluttertoast.showToast(
              msg: "Erreur modification medicament",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16);
          reserve = false;
        } else if (jsonDecode(response.body) == "error 2") {
          Fluttertoast.showToast(
              msg: "Erreur Panier",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16);
          reserve = false;
        } else {
          reserve = true;
        }
      }
      if (reserve == true) {
        global.shoppinglist.clear();
        Fluttertoast.showToast(
            msg: "Réservé correctement",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16);
        reserve = false;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MainHome(pageindex: 0);
            },
          ),
        );
      }
    }

    ;

    if (global.prixtotal != 0 && global.isloggedin == true) {
      return Scaffold(
        backgroundColor: HexColor("#EDE6DB"),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                  child: Text(
                    "Panier",
                    style: GoogleFonts.staatliches(
                      textStyle: TextStyle(
                        color: HexColor("#069A8E"),
                        fontWeight: FontWeight.w400,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  height: 402,
                  width: 380,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: HexColor("#6EBF8B"),
                      width: 3,
                    ),
                  ),
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 25),
                  child: Row(
                    children: [
                      Column(
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: SizedBox(
                          width: 165,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (() {
                              setState(
                                () {
                                  reserver();
                                },
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
