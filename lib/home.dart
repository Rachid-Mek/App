import 'package:app/loginsignup.dart';
import 'package:flutter/material.dart';
import 'package:app/product.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/details/details_product.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List productList = List.empty();
  getAllProducts() async {
    var url = "https://pharmacile.000webhostapp.com/appmobile/fetchappdata.php";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      if (this.mounted) {
        setState(
          () {
            productList = jsonDecode(response.body);
          },
        );
      }
      ;
      return (productList);
    }
  }

  void initState() {
    super.initState();
    getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
                  itemCount: productList.length,
                  // ignore: prefer_const_constructors
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 25,
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) => ProductCard(
                    name: productList[index]['Nom'],
                    image: productList[index]['imageURL'],
                    id: int.parse(productList[index]['Med_Id']),
                    Miligramme: int.parse(productList[index]['Miligramme']),
                    Qte: int.parse(productList[index]['Quantite']),
                    price: int.parse(productList[index]['Prix']),
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            name: productList[index]['Nom'],
                            image: productList[index]['imageURL'],
                            id: int.parse(productList[index]['Med_Id']),
                            Miligramme:
                                int.parse(productList[index]['Miligramme']),
                            Qte: int.parse(productList[index]['Quantite']),
                            price: int.parse(productList[index]['Prix']),
                          ),
                        )),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
