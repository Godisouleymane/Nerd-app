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
          backgroundColor: const Color.fromARGB(255, 53, 32, 149),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 16, 74),
        body: Stack(
          children: [
            ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    "Choisissez ce que vous voulez apprendre",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Vous pouvez changer ça plus tard",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 16),
                      textAlign: TextAlign.center,
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
                        selectedBorderColor: Colors.orange,
                        onTapCallback: updateSelectedContainer,
                        containerIcon: Icon(
                          DevIcons.html5PlainWordmark,
                          size: 100,
                          color: Colors.orange[700],
                        ),
                        isSelected: selectedContainerId == 'html',
                        autreInformation: 'HTML',
                        autreVariable:
                            '* Construisez des bases solides pour vos sites web en apprenant HTML',
                      ),
                      CustomGestureDetector(
                        containerId: 'css',
                        defaultBorderColor: Colors.transparent,
                        selectedBorderColor: Colors.blue,
                        onTapCallback: updateSelectedContainer,
                        containerIcon: const Icon(
                          DevIcons.css3PlainWordmark,
                          size: 100,
                          color: Colors.blue,
                        ),
                        isSelected: selectedContainerId == 'css',
                        autreInformation: 'CSS',
                        autreVariable:
                            '* Donnez du style à vos sites web avec CSS',
                      ),
                      CustomGestureDetector(
                        containerId: 'javaScript',
                        defaultBorderColor: Colors.transparent,
                        selectedBorderColor: Colors.amber,
                        onTapCallback: updateSelectedContainer,
                        containerIcon: const Icon(
                          DevIcons.javascriptPlain,
                          size: 100,
                          color: Colors.amber,
                        ),
                        isSelected: selectedContainerId == 'javaScript',
                        autreInformation: 'JavaScript',
                        autreVariable:
                            "* Explorez l'interactivité avec JavaScript. Manipulez le contenu dynamique, gérez les événements ",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                      onPressed: () {}, child: Text("Continuer")),
                ))
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
