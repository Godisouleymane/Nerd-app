import 'package:code_crafters/choixParcours/gestureDetecto/gesture.dart';
import 'package:dev_icons/dev_icons.dart';
import 'package:flutter/material.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  String selectedContainerId = '';
  List<String> selectedContainerIds = [];
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
              const Text(
                "Choisissez ce que vous voullez apprendre",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.0,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Nos Cours :",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 18),
                  textAlign: TextAlign.left,
                ),
              ),
              CustomGestureDetector(
                containerId: 'fullStack1',
                defaultBorderColor: Colors.transparent,
                selectedBorderColor: Colors.green,
                onTapCallback: updateSelectedContainer,
                containerIcon: Icon(Icons.code),
                isSelected: selectedContainerId == 'fullStack1',
                autreInformation: 'Description du conteneur 1',
                autreVariable: 'Valeur 1',
              ),
              CustomGestureDetector(
                containerId: 'fullStack2',
                defaultBorderColor: Colors.transparent,
                selectedBorderColor: Colors.green,
                onTapCallback: updateSelectedContainer,
                containerIcon: Icon(Icons.layers),
                isSelected: selectedContainerId == 'fullStack2',
                autreInformation: 'Description du conteneur 2',
                autreVariable: 'Valeur 2',
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:
                    ElevatedButton(onPressed: () {}, child: Text("Continuer")),
              )
            ],
          ),
        ));
  }

  void updateSelectedContainer(String id) {
    setState(() {
      selectedContainerId = id;
      print(id);
    });
  }
}
