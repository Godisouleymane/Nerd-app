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
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Text(
                "Choisissez ce que vous voullez apprendre",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Développement web :",
                  style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
            
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                   CustomGestureDetector(
                    containerId: 'html',
                    defaultBorderColor: Colors.transparent,
                    selectedBorderColor: Colors.green,
                    onTapCallback: updateSelectedContainer,
                    containerIcon: Icon(
                      DevIcons.html5PlainWordmark,
                      size: 100,
                      color: Colors.orange[700],
                    ),
                    isSelected: selectedContainerId == 'html',
                    autreInformation: 'HTML',
                    autreVariable: '',
                   
                  ),
                  CustomGestureDetector(
                    containerId: 'node',
                    defaultBorderColor: Colors.transparent,
                    selectedBorderColor: Colors.green,
                    onTapCallback: updateSelectedContainer,
                    containerIcon: Icon(
                      DevIcons.nodejsPlainWordmark,
                      size: 100,
                      color: Colors.green,
                    ),
                    isSelected: selectedContainerId == 'node',
                    autreInformation: 'Description du conteneur 2',
                    autreVariable: 'Valeur 2',
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:
                  ElevatedButton(onPressed: () {}, child: Text("Continuer")),
            )
          ],
        ));
  }

  void updateSelectedContainer(String id) {
    setState(() {
      selectedContainerId = id;
      print(id);
    });
  }
}
