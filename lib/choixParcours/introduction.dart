import 'package:flutter/material.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  String selectedContainerId = "";
  Color defaultBorderColor = Colors.transparent;
  Color selectedBorderColor = Colors.green;

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
        body: const Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text("Choisissez ce que vous voullez apprendre", style: TextStyle(
                color: Colors.white,
                fontSize: 25
              ),)
              ],
          ),
        ));
  }
}
