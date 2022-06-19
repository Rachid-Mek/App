// ignore_for_file: unnecessary_brace_in_string_interps, camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app/main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'globals.dart' as global;

class other extends StatefulWidget {
  final String img;
  final String name;
  final int mg;
  final int id;
  int qte;
  int qteAchete;
  final int price;
  other(
      {Key? key,
      required this.img,
      required this.name,
      required this.mg,
      required this.id,
      required this.qte,
      required this.price,
      required this.qteAchete})
      : super(key: key);

  @override
  State<other> createState() => _otherState();
}

class _otherState extends State<other> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: HexColor("#6EBF8B"),
            width: 3,
          ),
        )),
        //color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: Row(
            children: [
              //image
              Container(
                height: 105,
                width: 125,
                padding: const EdgeInsets.all(0.5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: HexColor("#6EBF8B"),
                    width: 3,
                  ),
                ),
                child: Image.network(
                  "https://pharmacile.000webhostapp.com/site/uploads/${widget.img}",
                  height: 90,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Container(
                  height: 85,
                  width: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.mg == 0
                            ? "${widget.name}"
                            : "${widget.name} ${widget.mg}mg",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      Row(children: [
                        SizedBox(
                          width: 30,
                          height: 35,
                          child: Card(
                            color: HexColor("#069A8E"),
                            child: IconButton(
                              icon: Icon(Icons.remove),
                              iconSize: 20,
                              color: Colors.white,
                              padding: EdgeInsets.all(0),
                              onPressed: (() {
                                setState(
                                  () {
                                    if (widget.qteAchete > 1) {
                                      widget.qteAchete--;
                                      global
                                          .shoppinglist[global.shoppinglist
                                              .indexWhere((element) =>
                                                  element.id == widget.id)]
                                          .QteAchte = widget.qteAchete;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return MainHome(pageindex: 1);
                                          },
                                        ),
                                      );
                                    }
                                  },
                                );
                              }),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${widget.qteAchete}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          height: 35,
                          child: Card(
                            color: HexColor("#069A8E"),
                            child: IconButton(
                              icon: Icon(Icons.add),
                              iconSize: 20,
                              color: Colors.white,
                              padding: EdgeInsets.all(0),
                              onPressed: (() {
                                setState(
                                  () {
                                    if ((widget.qte - widget.qteAchete) > 0) {
                                      widget.qteAchete++;
                                      global
                                          .shoppinglist[global.shoppinglist
                                              .indexWhere((element) =>
                                                  element.id == widget.id)]
                                          .QteAchte = widget.qteAchete;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return MainHome(pageindex: 1);
                                          },
                                        ),
                                      );
                                    }
                                  },
                                );
                              }),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 30,
                          height: 35,
                          child: Card(
                            color: HexColor("#069A8E"),
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              iconSize: 20,
                              color: Colors.white,
                              padding: EdgeInsets.all(0),
                              onPressed: (() {
                                setState(
                                  () {
                                    widget.qteAchete = 0;
                                    global.shoppinglist.removeWhere(
                                        (element) => element.id == widget.id);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return MainHome(pageindex: 1);
                                        },
                                      ),
                                    );
                                  },
                                );
                              }),
                            ),
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Container(
                  height: 85,
                  width: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "${widget.qteAchete * widget.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
