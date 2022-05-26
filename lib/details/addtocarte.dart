import "package:flutter/material.dart";
import 'package:hexcolor/hexcolor.dart';
import 'package:app/med.dart';
import 'package:app/shoppingcart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/globals.dart' as global;
import 'package:app/main.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class AddToCarte extends StatefulWidget {
  final int id, price, Miligramme, Qte, idpharm;
  final String image, name, pharmemail;
  const AddToCarte({
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
  State<AddToCarte> createState() => _AddToCarteState();
}

class _AddToCarteState extends State<AddToCarte> {
  @override
  Widget build(BuildContext context) {
    if (global.isloggedin) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 75,
              width: 150,
              child: ElevatedButton.icon(
                label: Text(
                  "Ajouter au panier".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
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
                    if (widget.Qte > 0) {
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
                          idpharm: widget.idpharm,
                          pharmemail: widget.pharmemail,
                        ),
                      );
                      global.qte = 1;
                      shoppingcart(
                        shoppinglist: global.shoppinglist,
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: "OOPS! Medicament non disponible",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          fontSize: 16);
                    }
                  });
                },
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              height: 75,
              width: 150,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: HexColor("#069A8E"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: () {
                  setState(() {
                    if (widget.Qte > 0) {
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
                          idpharm: widget.idpharm,
                          pharmemail: widget.pharmemail,
                        ),
                      );
                      global.qte = 1;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return MainHome(pageindex: 1);
                          },
                        ),
                      );
                      shoppingcart(
                        shoppinglist: global.shoppinglist,
                      );
                    } else {
                      showAlertDialog(
                          context,
                          widget.idpharm,
                          widget.id,
                          widget.name,
                          widget.Miligramme,
                          widget.price,
                          widget.pharmemail);
                    }
                  });
                },
                child: Text(
                  "Reserver Maintenant".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 75,
              width: 150,
              child: ElevatedButton.icon(
                label: Text(
                  "Ajouter au panier".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 3, color: HexColor("#cccccc")),
                  primary: HexColor("#cccccc"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: () {
                  setState(() {
                    Fluttertoast.showToast(
                        msg: "Vous Devez Etre Connecté",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        fontSize: 16);
                  });
                },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              height: 75,
              width: 150,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: HexColor("#cccccc"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: () {
                  setState(() {
                    Fluttertoast.showToast(
                        msg: "Vous Devez Etre Connecté",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        fontSize: 16);
                  });
                },
                child: Text(
                  "Reserver Maintenant".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

/******************************************************************************/
showAlertDialog(BuildContext context, int idpharm, int idmed, String nom,
    int milli, int prix, String emailpharm) {
  TextEditingController QteReserve = TextEditingController();

  Future Reservernondispo() async {
    try {
      String username = 'pharmacile.live@gmail.com';
      String password = 'PFE2022karimRACHID';

      int prixtotal = int.parse(QteReserve.text) * prix;
      String message =
          "$nom $milli mg, le prix total: $prixtotal\nL'email de la pharmacie: $emailpharm";
      final smtpServer = gmail(username, password);
      final message1 = Message()
        ..from = Address(username, 'Pharmacile')
        ..recipients.add(global.infouser[0]['Email'])
        //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
        //..bccRecipients.add(Address('bccAddress@example.com'))
        ..subject = 'Réservation de produit avec pharmacile :'
        ..html = '<h1>Vous avez commandé :</h1>\n<p>${message}</p>';

      final message2 = Message()
        ..from = Address(username, 'Pharmacile')
        ..recipients.add(emailpharm)
        ..subject = 'une commande dun produit indisponible avec pharmacile :'
        ..html =
            '<h1>Nouvelle Résevation :</h1>\n<p>${message}</p><p><b>fait par:</b><br> ${global.infouser[0]['Nom']} ${global.infouser[0]['Prenom']} <br>Email: ${global.infouser[0]['Email']}<br>Numero Telephone: ${global.infouser[0]['numerotel']}</p>';

      var url =
          "https://pharmacile.000webhostapp.com/appmobile/ReserviatonNonDispo.php";
      var data = {
        "QteReserve": QteReserve.text,
        "iduser": global.userID.toString(),
        "idpharm": idpharm.toString(),
        "idmed": idmed.toString(),
        "emailuser": global.infouser[0]['Email'].toString(),
      };

      EasyLoading.show(status: 'Réservation en cour ...');
      var response = await http.post(
        Uri.parse(url),
        headers: {"Accept": "application/json"},
        body: data,
      );
      if (jsonDecode(response.body) == "error add") {
        Fluttertoast.showToast(
            msg: "Erreur, Réservation annuler",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16);
      } else if (jsonDecode(response.body) == "success") {
        final sendReport1 = await send(message1, smtpServer);
        final sendReport2 = await send(message2, smtpServer);
        EasyLoading.showSuccess("Réservation faite avec succés");
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
            msg: "Erreur, Réservation annuler",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16);
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError('Erreur de connexion');
      EasyLoading.dismiss();
    }
  }

  Widget SubmitButton = TextButton(
    child: Text("Réserver"),
    onPressed: () {
      Reservernondispo();
    },
  );
  Widget CancelButton = TextButton(
    child: Text("Annuler"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget OuiButton = TextButton(
    child: Text("Oui"),
    onPressed: () {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: Text('Résever'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Text("Choisir la Quantité à réservé"),
                      TextFormField(
                        controller: QteReserve,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          labelText: 'La Quantité',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [SubmitButton, CancelButton],
            );
          });
    },
  );
  Widget NonButton = TextButton(
    child: Text("Non"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text(
        "Produit non disponible pour le moment. \nVoulez vous placer une commande et être notifier lorsque le medicament est disponible?"),
    actions: [
      OuiButton,
      NonButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
