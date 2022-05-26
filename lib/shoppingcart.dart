// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:async';
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
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
    bool trouve = false;
    int i = 0;
    List<int> ids = List.empty();
    ids = ids.toList();

    for (var elemnt in global.shoppinglist) {
      trouve = false;
      while (i < ids.length && trouve == false) {
        ids[i] == elemnt.idpharm ? trouve == true : trouve == false;
        i = i + 1;
      }
      if (trouve == false) {
        ids.add(elemnt.idpharm);
      }
    }
    print(ids);
    Future reserver() async {
      try {
        String username = 'pharmacile.live@gmail.com';
        String password = 'PFE2022karimRACHID';
        global.shoppinglist.forEach(
          (element) {
            global.emailmessage = global.emailmessage +
                "<tr><td> " +
                "<b> Le Produit</b>: " +
                element.name.toString().toUpperCase() +
                " " +
                element.Miligramme.toString() +
                " ," +
                "<b> La Quantité: </b>" +
                element.QteAchte.toString() +
                " ," +
                "<b> Le Prix Total: </b>" +
                (element.QteAchte * element.price).toString() +
                "<b> L'email de la pharmacie: </b>" +
                element.pharmemail.toString() +
                '</td></tr>';
            //global.emailmessage.add('\n');
          },
        );

        final smtpServer = gmail(username, password);

        final message1 = Message()
          ..from = Address(username, 'Pharmacile')
          ..recipients.add(global.infouser[0]['Email'])
          //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
          //..bccRecipients.add(Address('bccAddress@example.com'))
          ..subject = 'Réservation de produit avec pharmacile :'
          ..html =
              '<h1>Vous avez réservez :</h1>\n<table>${global.emailmessage}</table>';

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
          EasyLoading.show(status: 'Résevation en cours...');
          final sendReport1 = await send(message1, smtpServer);

          for (var id in ids) {
            final indexcond = global.shoppinglist
                .indexWhere((element) => element.idpharm == id);
            print(global.shoppinglist[indexcond].pharmemail);

            final message1 = Message()
              ..from = Address(username, 'Pharmacile')
              ..recipients
                  .add(global.shoppinglist[indexcond].pharmemail.toString())
              //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
              //..bccRecipients.add(Address('bccAddress@example.com'))
              ..subject = 'Réservation de produit avec pharmacile :'
              ..html =
                  '<h1>Nouvelle Résevation :</h1>\n<table>${global.emailmessage}</table><p><b>fait par:</b><br> ${global.infouser[0]['Nom']} ${global.infouser[0]['Prenom']} <br>Email: ${global.infouser[0]['Email']}<br>Numero Telephone: ${global.infouser[0]['numerotel']}</p>';
            final sendReport1 = await send(message1, smtpServer);
            EasyLoading.showSuccess('Réservé correctement!');
          }
          reserve = false;
          global.shoppinglist.clear();
          global.emailmessage = "";
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return MainHome(pageindex: 0);
              },
            ),
          );
          EasyLoading.dismiss();
        }
      } catch (e) {
        EasyLoading.showError('Erreur, Réservation non enregistré');
        EasyLoading.dismiss();
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  textAlign: TextAlign.center,
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
