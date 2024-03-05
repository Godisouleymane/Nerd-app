import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class introPage2 extends StatelessWidget {
  const introPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Container(
            child: Image.asset(
              "assets/machine-animation.gif",
              width: 400,
              height: 400,
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Apprentissage Pratique",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            "Plongez dans des projets pratiques et renforcez vos compétences avec des exercices interactifs. Codez en temps réel et consolidez vos connaissances.",
            style: TextStyle(fontSize: 15, color: Colors.grey),
          )
        ],
      ),
    );
  }
}