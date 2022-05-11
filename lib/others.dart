// ignore_for_file: unnecessary_brace_in_string_interps, camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:hexcolor/hexcolor.dart';

class other extends StatefulWidget {
  final String img;
  final String name;
  final int mg;
  final int qte;
  final int price;
  const other(
      {Key? key,
      required this.img,
      required this.name,
      required this.mg,
      required this.qte,
      required this.price})
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
                child: Image.asset(
                  widget.img,
                  height: 90,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Container(
                  height: 85,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.name} ${widget.mg}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      Row(children: [
                        SizedBox(
                          width: 35,
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
                                  () {},
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
                                "${widget.qte}",
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
                          width: 35,
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
                                  () {},
                                );
                              }),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 35,
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
                                  () {},
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
                  width: 80,
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
                        "\$${widget.qte * widget.price}",
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
