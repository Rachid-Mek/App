// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:my_app/home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class connect extends StatefulWidget {
  connect({Key? key}) : super(key: key);

  @override
  State<connect> createState() => _connectState();
}

class _connectState extends State<connect> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController numtel = TextEditingController();
  TextEditingController nvemail = TextEditingController();
  TextEditingController nvpassword = TextEditingController();
  TextEditingController nvpasswordconfirm = TextEditingController();

  Future login() async {
    var url = "https://pharmacile.000webhostapp.com/appmobile/applogin.php";
    var data = {
      "email": email.text,
      "password": password.text,
    };

    var response = await http.post(
      Uri.parse(url),
      headers: {"Accept": "application/json"},
      body: data,
    );

    if (jsonDecode(response.body) == "error") {
      Fluttertoast.showToast(
          msg: "Email ou Mot De Passe Incorrect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16);
    } else if (jsonDecode(response.body) == "success") {
      Fluttertoast.showToast(
          msg: "Welcome",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16);
    } else {
      Fluttertoast.showToast(
          msg: jsonDecode(response.body),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16);
      print(response.statusCode);
    }
  }

  Future signup() async {
    var url = "https://pharmacile.000webhostapp.com/appmobile/appsignup.php";
    var data = {
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
    } else if (jsonDecode(response.body) == "error exist") {
      Fluttertoast.showToast(
          msg: "le compte existe deja",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16);
    } else if (jsonDecode(response.body) == "success") {
      Fluttertoast.showToast(
          msg: "compte est ajouter correctement",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16);
    } else if (jsonDecode(response.body) == "error add") {
      Fluttertoast.showToast(
          msg: "Erreur, compte n'est pas ajouter",
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

  int pageindex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor("#EDE6DB"),
        body: SafeArea(
          child: pageindex == 0
              ? //Login
              Column(
                  children: [
                    // login text
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text(
                          "Connectez-vous",
                          style: GoogleFonts.staatliches(
                            textStyle: TextStyle(
                              color: HexColor("#069A8E"),
                              fontWeight: FontWeight.w400,
                              fontSize: 48,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // image
                    Image.asset(
                      "images/connexion.png",
                      height: 300,
                    ),
                    // form
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: email,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail,
                                ),
                                hintText: 'Email'),
                          ),

                          // ignore: prefer_const_constructors
                          TextField(
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                hintText: 'Mot De Passe'),
                          ),

                          SizedBox(
                            height: 10.0,
                          ),

                          SizedBox(
                            width: 140,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: (() {
                                login();
                              }),
                              child: const Text(
                                "Connecter",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: HexColor("#069A8E"),
                                  shape: StadiumBorder()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // button : go to sign up
                    Container(
                      decoration: BoxDecoration(
                          color: HexColor("#6EBF8B"),
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(
                              "Vous n’avez pas de compte ?",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
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
                                    () {
                                      email.clear();
                                      password.clear();
                                      pageindex = 1;
                                    },
                                  );
                                }),
                                child: const Text(
                                  "Inscrivez-vous",
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
                )
              : // Signup
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // login text
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: Text(
                        "Inscrivez-vous",
                        style: GoogleFonts.staatliches(
                          textStyle: TextStyle(
                            color: HexColor("#069A8E"),
                            fontWeight: FontWeight.w400,
                            fontSize: 48,
                          ),
                        ),
                      ),
                    ),
                    // form
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                          TextField(
                            controller: nvpassword,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                hintText: 'Mot De Passe'),
                          ),
                          TextField(
                            controller: nvpasswordconfirm,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                hintText: 'Confirmer Le Mot De Passe'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            width: 175,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: (() {
                                signup();
                              }),
                              child: const Text(
                                "Créer Un Compte",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: HexColor("#069A8E"),
                                  shape: StadiumBorder()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // button : go to sign in
                    Container(
                      decoration: BoxDecoration(
                          color: HexColor("#6EBF8B"),
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(
                              "Vous avez un compte ?",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
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
                                    () {
                                      nom.clear();
                                      prenom.clear();
                                      numtel.clear();
                                      nvemail.clear();
                                      nvpassword.clear();
                                      nvpasswordconfirm.clear();
                                      pageindex = 0;
                                    },
                                  );
                                }),
                                child: const Text(
                                  "Connectez-vous",
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
  }
}
