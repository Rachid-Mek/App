// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'globals.dart' as global;
import 'edituser.dart';

class account extends StatefulWidget {
  account({Key? key}) : super(key: key);

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  @override
  Widget build(BuildContext context) {
    if (global.isloggedin) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Profile",
            style: GoogleFonts.staatliches(
              textStyle: TextStyle(
                color: HexColor("#069A8E"),
                fontWeight: FontWeight.w400,
                fontSize: 48,
              ),
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: HexColor("#EDE6DB"),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "images/utilisateur.png",
                  scale: 0.6,
                  height: 105,
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  height: 320,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: HexColor("#6EBF8B"),
                      width: 3,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Les informations personnels",
                              style: TextStyle(
                                  color: HexColor("#069A8E"),
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Nom : ",
                              style: TextStyle(
                                color: HexColor("#069A8E"),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${global.infouser[0]['Nom']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              "Prenom : ",
                              style: TextStyle(
                                color: HexColor("#069A8E"),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${global.infouser[0]['Prenom']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              "Numéro de telephone: ",
                              style: TextStyle(
                                color: HexColor("#069A8E"),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${global.infouser[0]['numerotel']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              "Email: ",
                              style: TextStyle(
                                color: HexColor("#069A8E"),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${global.infouser[0]['Email']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              "Mot de passe: ",
                              style: TextStyle(
                                color: HexColor("#069A8E"),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              " ●●●●●●●●●●●●",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return EditUser();
                                },
                              ),
                            );
                          });
                        },
                        child: const Text(
                          "Modifier",
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
                            global.isloggedin = false;
                            global.infouser = [];
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
                          "Déconecter",
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
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Profile",
            style: GoogleFonts.staatliches(
              textStyle: TextStyle(
                color: HexColor("#069A8E"),
                fontWeight: FontWeight.w400,
                fontSize: 48,
              ),
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: HexColor("#EDE6DB"),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "images/utilisateur.png",
                  scale: 0.6,
                  height: 105,
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  height: 320,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: HexColor("#6EBF8B"),
                      width: 3,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Vous N'êtes Pas Connecté",
                        style: TextStyle(
                            color: HexColor("#069A8E"),
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
