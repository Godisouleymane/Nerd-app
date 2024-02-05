import 'package:code_crafters/choixParcours/gestureDetecto/gesture.dart';
import 'package:flutter/material.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "CodeCrafters",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 53, 32, 149),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 16, 74),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Choisissez ce que vous voullez apprendre", style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.0,),
              const Align(
                alignment: Alignment.topLeft,
                child: Text("Nos Cours :", style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 18
                ),textAlign: TextAlign.left,),
              ),
              GesturePage(idContainer : ""),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: (){}, 
                  child: Text("Continuer")),
              )
              ],
          ),
        ));
  }
}
