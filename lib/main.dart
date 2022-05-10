import 'dart:math';
import 'package:my_app/home.dart';
import 'package:my_app/shoppingcart.dart';
import 'package:my_app/notification.dart';
import 'package:my_app/account.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainHome(),
      theme: ThemeData(primarySwatch: buildMaterialColor(Color(0xFF417D7A))),
    );
  }
}

class MainHome extends StatefulWidget {
  MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#EDE6DB"),
      body: SafeArea(
          child: currentIndex == 0
              ? HomePage()
              : currentIndex == 1
                  ? shoppingcart()
                  : currentIndex == 2
                      ? notifications()
                      : account()),
      // ****************** Bottom Navigation Bar ********************//
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //inside the bottomNavigationBar we must do items[ and do our BottomNavgationBarItem>2 and we define our label and icon]
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home,
              size: 35,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.shopping_cart,
              size: 35,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.notifications,
              size: 35,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.account_box_sharp,
              size: 35,
            ),
          )
        ],
        //when we select between icons
        currentIndex: currentIndex,
        //when we tap flutter return an index
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
