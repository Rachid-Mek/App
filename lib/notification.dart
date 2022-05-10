import 'package:flutter/material.dart';

class notifications extends StatefulWidget {
  notifications({Key? key}) : super(key: key);

  @override
  State<notifications> createState() => _notificationsState();
}

class _notificationsState extends State<notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('this is the notifications')),
    );
  }
}
