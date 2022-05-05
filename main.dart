import 'dart:math';
import 'package:app/medicament.dart';
import 'package:flutter/material.dart';
import 'package:app/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainHome(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
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
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(18),
                child: Row(
                  /*    crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,*/
                  children: [
                    Expanded(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          // ignore: prefer_const_constructors
                          Center(
                            child: const Text(
                              "VOUS N'ETES PAS CONNECTER",
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // ignore: prefer_const_constructors
                          Text(
                            "connecter vous pour profiter d'option supplimentaires",
                            // ignore: prefer_const_constructors
                            style: TextStyle(fontSize: 19),
                          )
                        ],
                      ),
                    ),
                    // button
                    SizedBox(
                      width: 80,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("LOGIN"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple[300],
                            shape: StadiumBorder()),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ******************* Search bar ***********************//
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.circular(12)),
                child: const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: "Chercher un produit",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            //liste of produits
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: const [
                  Text(
                    'Product list:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GridView.builder(
                  itemCount: products.length,
                  // ignore: prefer_const_constructors
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 25,
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) => ProductCard(
                        product: products[index],
                      )),
            ))
          ],
        ),
      ),
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
