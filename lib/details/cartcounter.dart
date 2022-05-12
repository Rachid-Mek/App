import 'package:flutter/material.dart';
import 'package:app/globals.dart' as global;

class CarteCounter extends StatefulWidget {
  int QteR;
  final int id;
  CarteCounter({Key? key, required this.QteR, required this.id})
      : super(key: key);

  @override
  State<CarteCounter> createState() => _CarteCounterState();
}

class _CarteCounterState extends State<CarteCounter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quantité:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                buildOutlinedButton(
                  icon: Icons.remove,
                  press: () {
                    setState(() {
                      if (global.qte > 1) {
                        widget.QteR++;
                        global.qte--;
                      }
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Text(
                    //if the qte is less than 10 it shown 01 02...
                    global.qte.toString().padLeft(2, "0"),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                buildOutlinedButton(
                    icon: Icons.add,
                    press: () {
                      setState(() {
                        if (widget.QteR > 0) {
                          widget.QteR--;
                          global.qte++;
                        }
                      });
                    })
              ],
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Quantité Restante:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Text(
                //if the qte is less than 10 it shown 01 02...
                widget.QteR.toString().padLeft(2, "0"),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }

  SizedBox buildOutlinedButton({
    required IconData icon,
    required Function press,
  }) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          ),
          onPressed: () {
            press();
          },
          child: Icon(icon)),
    );
  }
}
