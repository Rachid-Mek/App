import 'package:app/details/body.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:app/globals.dart' as global;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Details extends StatefulWidget {
  final int id, price, Miligramme, Qte, idpharm;
  final String image, name, pharmemail;

  const Details({
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
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List Info = List.empty();
  getUserInfo() async {
    try {
      var url =
          "https://pharmacile.000webhostapp.com/appmobile/fetchpharminfo.php";
      var data = {
        "pharmID": widget.idpharm.toString(),
      };
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        if (this.mounted) {
          setState(
            () {
              Info = jsonDecode(response.body);
            },
          );
        }
        global.globalproductList = Info;
        return (global.globalproductList);
      }
    } catch (e) {
      EasyLoading.showError('Erreur de connexion');
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#6EBF8B"),
      appBar: buildAppBar(context),
      body: Body(
        id: widget.id,
        idpharm: widget.idpharm,
        price: widget.price,
        Miligramme: widget.Miligramme,
        Qte: widget.Qte,
        image: widget.image,
        name: widget.name,
        pharmemail: widget.pharmemail,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: HexColor("#6EBF8B"),
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            setState(() {
              global.qte = 1;
              global.globalproductList = [];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MainHome(pageindex: 0);
                  },
                ),
              );
            });
          },
          icon: Image.asset('images/back.png')),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            setState(() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MainHome(pageindex: 1);
                  },
                ),
              );
            });
          },
          icon: Image.asset('images/shopping-cart.png'),
        ),
      ],
    );
  }
}
