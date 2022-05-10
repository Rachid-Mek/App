import 'package:flutter/material.dart';

class account extends StatefulWidget {
  account({Key? key}) : super(key: key);

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('this is the account')),
    );
  }
}
