import 'package:app/details/body.dart';
import 'package:app/medicament.dart';
import 'package:app/shoppingcart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Details extends StatefulWidget {
  final Product product;

  const Details({Key? key, required this.product}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#6EBF8B"),
      appBar: buildAppBar(context),
      body: Body(
        product: widget.product,
      ),
    );
  }

  bool isSearching = false;
  Widget searchIcon = Image.asset(
    'images/search.png',
    color: Colors.white,
  );
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: HexColor("#6EBF8B"),
      elevation: 0,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset('images/back.png')),
      title: !isSearching
          ? Text("")
          : const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Chercher un produit",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
      actions: <Widget>[
        isSearching
            ? IconButton(
                onPressed: () {
                  setState(() {
                    this.isSearching = false;
                  });
                },
                icon: Icon(Icons.cancel),
              )
            : IconButton(
                onPressed: () {
                  setState(() {
                    this.isSearching = true;
                  });
                },
                icon: searchIcon,
              ),
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => shoppingcart()));
          },
          icon: Image.asset('images/shopping-cart.png'),
        ),
      ],
    );
  }
}
