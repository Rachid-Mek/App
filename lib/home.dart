import 'package:app/details/details_product.dart';
import 'package:app/medicament.dart';
import 'package:app/loginsignup.dart';
import 'package:flutter/material.dart';
import 'package:app/product.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#EDE6DB"),
      body: SafeArea(
        child: Column(
          children: [
            /******************** LOGIN SQUAR *************************/
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                    color: HexColor("#6EBF8B"),
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
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return connect();
                                },
                              ),
                            );
                          });
                        },
                        child: const Text("LOGIN"),
                        style: ElevatedButton.styleFrom(
                            primary: HexColor("#069A8E"),
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
                    color: HexColor("#6EBF8B"),
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
            // ****************** liste of produits **************//
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
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            product: products[index],
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
