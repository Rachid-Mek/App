// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:my_app/home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';

class connect extends StatefulWidget {
  connect({Key? key}) : super(key: key);

  @override
  State<connect> createState() => _connectState();
}

class _connectState extends State<connect> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var msgController = TextEditingController();

  Future login() async {
    print('bonjour');
    var url = "https://pharmacile.000webhostapp.com/applogin.php";
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

  int pageindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        style: TextStyle(
                          color: HexColor("#069A8E"),
                          fontWeight: FontWeight.w400,
                          fontSize: 40,
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
                      style: TextStyle(
                        color: HexColor("#069A8E"),
                        fontWeight: FontWeight.w400,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  // form
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_box,
                              ),
                              hintText: 'Nom'),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_box,
                              ),
                              hintText: 'Prenom'),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone,
                              ),
                              hintText: 'Numéro De Téléphone'),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.mail,
                              ),
                              hintText: 'Email'),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              hintText: 'Mot De Passe'),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              hintText: 'Configurer Le Mot De Passe'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: 175,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (() {}),
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
    );
  }
}
