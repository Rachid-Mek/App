import 'dart:async';
import 'package:app/home.dart';
import 'package:app/shoppingcart.dart';
import 'package:app/account.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'globals.dart' as global;
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //  ..customAnimation = CustomAnimation();
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
      home: MainHome(pageindex: 0),
      theme: ThemeData(primarySwatch: buildMaterialColor(Color(0xFF417D7A))),
      builder: EasyLoading.init(),
    );
  }
}

class MainHome extends StatefulWidget {
  int pageindex;
  MainHome({Key? key, required this.pageindex}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  Timer? _timer;

  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#EDE6DB"),
      body: SafeArea(
          child: widget.pageindex == 0
              ? HomePage()
              : widget.pageindex == 1
                  ? shoppingcart(
                      shoppinglist: global.shoppinglist,
                    )
                  : account()),
      // ****************** Bottom Navigation Bar ********************//
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //inside the bottomNavigationBar we must do items[ and do our BottomNavgationBarItem>2 and we define our label and icon]
        items: const [
          BottomNavigationBarItem(
            label: 'Accueil',
            icon: Icon(
              Icons.home,
              size: 35,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Panier',
            icon: Icon(
              Icons.shopping_cart,
              size: 35,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profil',
            icon: Icon(
              Icons.account_box_sharp,
              size: 35,
            ),
          )
        ],
        //when we select between icons
        currentIndex: widget.pageindex,
        //when we tap flutter return an index
        onTap: (int index) {
          setState(() {
            widget.pageindex = index;
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
