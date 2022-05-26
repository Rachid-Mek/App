import 'package:app/loginsignup.dart';
import 'package:flutter/material.dart';
import 'package:app/product.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/details/details_product.dart';
import 'globals.dart' as global;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'searchwidget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();
  List productList = List.empty();
  late List listMedicament = List.empty();
  String query = '';
  getAllProducts() async {
    try {
      var url =
          "https://pharmacile.000webhostapp.com/appmobile/fetchappdata.php";
      EasyLoading.show(status: 'Téléchargement des Medicament');
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        //EasyLoading.showSuccess('Great Success!');
        if (this.mounted) {
          setState(
            () {
              productList = jsonDecode(response.body);
            },
          );

          EasyLoading.dismiss();
        }
        ;
        return (productList);
      }
    } catch (e) {
      EasyLoading.showError('Erreur de connexion');
      EasyLoading.dismiss();
    }
  }

  void initState() {
    super.initState();
    getAllProducts();
    listMedicament = productList;
  }

  bool isPrixAsc = true;

  @override
  Widget build(BuildContext context) {
    searchBook(query);
    isPrixAsc
        ? listMedicament.sort(
            (a, b) => int.parse(a["Prix"]).compareTo(int.parse(b["Prix"])))
        : listMedicament.sort(
            (a, b) => int.parse(b["Prix"]).compareTo(int.parse(a["Prix"])));
    try {
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
                                child: Text(
                                  global.isloggedin
                                      ? "Vous Etes Connecté"
                                      : "Vous N'étes pas connecté",
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              // ignore: prefer_const_constructors
                              Text(
                                global.isloggedin
                                    ? "Bienvenue a notre application"
                                    : "connecter vous pour profiter d'option supplimentaires",
                                // ignore: prefer_const_constructors
                                style: TextStyle(fontSize: 19),
                              )
                            ],
                          ),
                        ),
                        // button
                        if (global.isloggedin == false) ...[
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
                        ]
                      ],
                    ),
                  ),
                ),
                // ******************* Search bar ***********************//
                buildSearch(),
                const SizedBox(
                  height: 5,
                ),
                TextButton.icon(
                  onPressed: (() {
                    setState(() {
                      isPrixAsc = !isPrixAsc;
                    });
                  }),
                  icon: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(Icons.compare_arrows, size: 28),
                  ),
                  label: Text(
                    isPrixAsc ? 'Prix Ascendeant' : "Prix Déscendant",
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // ****************** liste of produits **************//
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: const [
                      Text(
                        'Product list:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GridView.builder(
                      itemCount: listMedicament.length,
                      // ignore: prefer_const_constructors
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 25,
                        crossAxisSpacing: 25,
                        crossAxisCount: 2,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                        name: listMedicament[index]['Nom'],
                        image: listMedicament[index]['imageURL'],
                        id: int.parse(listMedicament[index]['Med_Id']),
                        Miligramme:
                            int.parse(listMedicament[index]['Miligramme']),
                        Qte: int.parse(listMedicament[index]['Quantite']),
                        price: int.parse(listMedicament[index]['Prix']),
                        press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(
                              name: listMedicament[index]['Nom'],
                              image: listMedicament[index]['imageURL'],
                              id: int.parse(listMedicament[index]['Med_Id']),
                              Miligramme: int.parse(
                                  listMedicament[index]['Miligramme']),
                              Qte: int.parse(listMedicament[index]['Quantite']),
                              price: int.parse(listMedicament[index]['Prix']),
                              idpharm:
                                  int.parse(listMedicament[index]['pharma_Id']),
                              pharmemail: listMedicament[index]['email'],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      return Scaffold(
        body: Center(child: Text("Erreur de Connexion")),
      );
    }
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Chercher Un Produit',
        onChanged: searchBook,
      );

  void searchBook(String query) {
    final listMedicament = productList.where((product) {
      final titleLower = product['Nom'].toString().toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.listMedicament = listMedicament;
    });
  }
}
