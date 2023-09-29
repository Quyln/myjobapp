import 'package:flutter/material.dart';

class Tinnoibat1 extends StatelessWidget {
  const Tinnoibat1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 2,
                    blurStyle: BlurStyle.outer,
                    color: Color.fromRGBO(0, 0, 0, 0.4))
              ]),
        ),
      ),
    );
  }
}
