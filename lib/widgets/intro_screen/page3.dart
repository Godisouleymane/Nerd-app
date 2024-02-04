import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class introPage3 extends StatelessWidget {
  const introPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Container(
            child: SvgPicture.asset(
              "assets/Achievement-amico.svg",
              width: 300,
              height: 300,
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Progressez et Maîtrisez",
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
            "Suivez votre progression, remportez des succès et maîtrisez de nouvelles compétences. Codez avec confiance et atteignez vos objectifs de développement.",
            style: TextStyle(fontSize: 15, color: Colors.grey),
          )
        ],
      ),
    );
  }
}