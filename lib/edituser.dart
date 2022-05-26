// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'main.dart';
import 'globals.dart' as global;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditUser extends StatefulWidget {
  EditUser({Key? key}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController numtel = TextEditingController();
  TextEditingController nvemail = TextEditingController();
  TextEditingController nvpassword = TextEditingController();
  TextEditingController nvpasswordconfirm = TextEditingController();

  bool show = false;

  Future modifer() async {
    var url = "https://pharmacile.000webhostapp.com/appmobile/appedit.php";
    var data = {
      "id": global.infouser[0]['iduser'],
      "nom": nom.text,
      "prenom": prenom.text,
      "numtel": numtel.text,
      "nvemail": nvemail.text,
      "nvpassword": nvpassword.text,
      "nvpasswordconfirm": nvpasswordconfirm.text,
    };

    var response = await http.post(
      Uri.parse(url),
      headers: {"Accept": "application/json"},
      body: data,
    );

    if (jsonDecode(response.body) == "error password") {
      Fluttertoast.showToast(
          msg: "mot de passe et sa confirmation ne correspond pas",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16);
    } else if (jsonDecode(response.body) == "error same password") {
      Fluttertoast.showToast(
          msg:
              "Vous ne pouvez pas changer le mot de passe au mot de passe actuelle",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16);
    } else if (jsonDecode(response.body) == "success") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainHome(pageindex: 2);
          },
        ),
      );
      Fluttertoast.showToast(
          msg: "Vos informations sont modifiés correctement",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16);
    } else if (jsonDecode(response.body) == "error edit") {
      Fluttertoast.showToast(
          msg: "Erreur, compte n'est pas modifié",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16);
    } else {
      Fluttertoast.showToast(
          msg: "Erreur",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    nom.text = global.infouser[0]['Nom'];
    prenom.text = global.infouser[0]['Prenom'];
    numtel.text = global.infouser[0]['numerotel'];
    nvemail.text = global.infouser[0]['Email'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor("#EDE6DB"),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Text(
                "Modification",
                style: GoogleFonts.staatliches(
                  textStyle: TextStyle(
                    color: HexColor("#069A8E"),
                    fontWeight: FontWeight.w400,
                    fontSize: 48,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                "images/modifiercompte.png",
                scale: 0.6,
                height: 95,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: HexColor("#6EBF8B"),
                      width: 3,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: nom,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_box,
                            ),
                            hintText: 'Nom'),
                      ),
                      TextField(
                        controller: prenom,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_box,
                            ),
                            hintText: 'Prenom'),
                      ),
                      TextField(
                        controller: numtel,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                            hintText: 'Numéro De Téléphone'),
                      ),
                      TextField(
                        controller: nvemail,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.mail,
                            ),
                            hintText: 'Email'),
                      ),
                      if (!show)
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.blue,
                                  height: 2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              text: 'Modifier Le Mot de Passe',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    show = true;
                                  });
                                }),
                        ),
                      if (show)
                        TextField(
                          controller: nvpassword,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              hintText: 'Mot De Passe'),
                        ),
                      if (show)
                        TextField(
                          controller: nvpasswordconfirm,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              hintText: 'Confirmer Le Mot De Passe'),
                        ),
                      if (show)
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.blue,
                                  height: 2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              text: 'Annuler La Modification Du Mot De Passe',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    nvpassword.text = "";
                                    nvpasswordconfirm.text = "";
                                    show = false;
                                  });
                                }),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          modifer();
                        });
                      },
                      child: const Text(
                        "Confirmer",
                        style: TextStyle(fontSize: 25),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10)),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return MainHome(pageindex: 2);
                              },
                            ),
                          );
                        });
                      },
                      child: const Text(
                        "Annuler",
                        style: TextStyle(fontSize: 25),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
