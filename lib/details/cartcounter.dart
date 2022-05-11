import 'package:flutter/material.dart';

class CarteCounter extends StatefulWidget {
  CarteCounter({Key? key}) : super(key: key);

  @override
  State<CarteCounter> createState() => _CarteCounterState();
}

class _CarteCounterState extends State<CarteCounter> {
  int qte = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  if (qte > 1) {
                    qte--;
                  }
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Text(
                //if the qte is less than 10 it shown 01 02...
                qte.toString().padLeft(2, "0"),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            buildOutlinedButton(
                icon: Icons.add,
                press: () {
                  setState(() {
                    qte++;
                  });
                })
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
