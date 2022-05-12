import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class EditUser extends StatefulWidget {
  EditUser({Key? key}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Modification",
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
                height: 95,
              ),
              const SizedBox(
                height: 25,
              ),
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                          hintText: 'Confirmer Le Mot De Passe'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Confirmer",
                      style: TextStyle(fontSize: 25),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10)),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Annuler",
                      style: TextStyle(fontSize: 25),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10)),
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
