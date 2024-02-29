import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: camel_case_types
class introPage1 extends StatelessWidget {
  const introPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Container(
            child: SvgPicture.asset(
            "assets/programmer-animate.svg",
            width: 300,
            height: 300,
            ),
          ),
        
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Bienvenue sur codeCrafters.", style:TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
            textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 20.0,),
          const Text("Explorez le monde de la programmation et du développement web avec notre mentor virtuel. Apprenez les bases, perfectionnez vos compétences et devenez un expert du code.", style: TextStyle(
           fontSize: 15,
           color: Colors.grey
          ),)
        ],
      ),
    );
  }
}