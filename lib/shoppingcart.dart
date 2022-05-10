import 'package:flutter/material.dart';

class shoppingcart extends StatefulWidget {
  shoppingcart({Key? key}) : super(key: key);

  @override
  State<shoppingcart> createState() => _shoppingcartState();
}

class _shoppingcartState extends State<shoppingcart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('this is the shopping cart')),
    );
  }
}
