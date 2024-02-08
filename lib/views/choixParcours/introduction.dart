import 'package:code_crafters/provider/cours_model.dart';
import 'package:code_crafters/views/choixParcours/gestureDetecto/gesture.dart';
import 'package:code_crafters/views/widgets/showSnackbar.dart';
import 'package:dev_icons/dev_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text(
                      "Choisissez ce que vous voulez apprendre",
                      style: TextStyle(
                          color: Colors.black,
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
                        CustomGestureDetector(
                          containerId: 'github',
                          defaultBorderColor: Colors.transparent,
                          selectedBorderColor: Colors.black,
                          onTapCallback: updateSelectedContainer,
                          containerIcon: const Icon(
                            DevIcons.githubOriginalWordmark,
                            size: 100,
                            color: Colors.black,
                          ),
                          isSelected: selectedContainerId == 'github',
                          autreInformation: 'GITHUB',
                          autreVariable:
                              "*Maîtrisez le contrôle de version avec Git et GitHub. Apprenez à suivre les changements",
                        ),
                        CustomGestureDetector(
                          containerId: 'kotlin',
                          defaultBorderColor: Colors.transparent,
                          selectedBorderColor: Colors.amber,
                          onTapCallback: updateSelectedContainer,
                          containerIcon: const Icon(
                            DevIcons.kotlinPlainWordmark,
                            size: 100,
                            color: Colors.orangeAccent,
                          ),
                          isSelected: selectedContainerId == 'kotlin',
                          autreInformation: 'KOTLIN',
                          autreVariable:
                              "* Explorez le monde puissant et expressif de Kotlin. Apprenez à développer des applications Android modernes",
                        ),
                        CustomGestureDetector(
                          containerId: 'bootstrap',
                          defaultBorderColor: Colors.transparent,
                          selectedBorderColor: Colors.deepPurple,
                          onTapCallback: updateSelectedContainer,
                          containerIcon: const Icon(
                            DevIcons.bootstrapPlainWordmark,
                            size: 100,
                            color: Colors.deepPurple,
                          ),
                          isSelected: selectedContainerId == 'bootstrap',
                          autreInformation: 'BOOTSTRAP',
                          autreVariable:
                              "* Mettez en œuvre des designs web modernes et réactifs avec Bootstrap. Apprenez à utiliser ce framework front-end",
                        ),
                        CustomGestureDetector(
                          containerId: 'c',
                          defaultBorderColor: Colors.transparent,
                          selectedBorderColor: Colors.blue,
                          onTapCallback: updateSelectedContainer,
                          containerIcon: const Icon(
                            DevIcons.cLine,
                            size: 100,
                            color: Colors.blue,
                          ),
                          isSelected: selectedContainerId == 'c',
                          autreInformation: 'C',
                          autreVariable:
                              "* Maîtrisez les fondamentaux du langage C. Plongez dans la programmation bas niveau,",
                        ),
                        CustomGestureDetector(
                          containerId: 'nodejs',
                          defaultBorderColor: Colors.transparent,
                          selectedBorderColor: Colors.green,
                          onTapCallback: updateSelectedContainer,
                          containerIcon: const Icon(
                            DevIcons.nodejsPlain,
                            size: 100,
                            color: Colors.green,
                          ),
                          isSelected: selectedContainerId == 'nodejs',
                          autreInformation: 'NODE JS',
                          autreVariable:
                              "* Explorez le monde de la programmation côté serveur avec Node.js",
                        ),
                        CustomGestureDetector(
                          containerId: 'python',
                          defaultBorderColor: Colors.transparent,
                          selectedBorderColor: Colors.amberAccent,
                          onTapCallback: updateSelectedContainer,
                          containerIcon: const Icon(
                            DevIcons.pythonPlain,
                            size: 100,
                            color: Colors.amberAccent,
                          ),
                          isSelected: selectedContainerId == 'python',
                          autreInformation: 'PYTHON',
                          autreVariable:
                              "* Un langage polyvalent et convivial. Apprenez les bases de la programmation, la manipulation de données",
                        ),
                        CustomGestureDetector(
                          containerId: 'mongodb',
                          defaultBorderColor: Colors.transparent,
                          selectedBorderColor: Colors.green,
                          onTapCallback: updateSelectedContainer,
                          containerIcon: const Icon(
                            DevIcons.mongodbPlain,
                            size: 100,
                            color: Colors.green,
                          ),
                          isSelected: selectedContainerId == 'mongodb',
                          autreInformation: 'MONGO DB',
                          autreVariable:
                              "* La base de données NoSQL avec MongoDB. Apprenez à stocker et à interroger des données de manière flexible",
                        ),
                      ],
                    ),
                  ),
                  CustomGestureDetector(
                    containerId: 'devFullSctack',
                    width: MediaQuery.of(context).size.width,
                    defaultBorderColor: Colors.transparent,
                    selectedBorderColor: Colors.deepPurple,
                    onTapCallback: updateSelectedContainer,
                    isSelected: selectedContainerId == 'devFullSctack',
                    autreInformation: 'Full Stack',
                    hasImage: true,
                    autreVariable:
                        "Transformez votre passion en carrière avec notre cours de Développement Full Stack. Maîtrisez chaque aspect du développement web moderne, obtenez une certification reconnue, et lancez-vous dans une carrière dynamique en tant que développeur Full Stack.",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 15.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 53, 32, 149),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              minimumSize: const Size(double.infinity, 50.0),
              elevation: 10),
          onPressed: () {
            // verifier si l'id du container est null
            if (selectedContainerId.isEmpty) {
              // si aucun cours n'est selectionner
              print("Aucun cours selectionner");
              return showNotification(context,
                  "Veuillez selectionner un cours ou un parcours s'il vous plait");
            }

            final user = Provider.of<User?>(context, listen: false);

            if (user != null) {
              // Enregistrer l'ID du container selectionner dans le fireStore
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .set({'selectedContainerId': selectedContainerId}).then((_) {
                // Enregistrement réussi, naviguer vers la page appropriée
                navigateToSelectedContainerPage(selectedContainerId);
              });
            }
          },
          child: const Text(
            "Commencer",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void navigateToSelectedContainerPage(String containerId) {
    if (containerId == 'html') {
      print("Donnees pour html envoyer");
      Navigator.pushNamed(context, '/html');
    } else if (containerId == 'css') {
      Navigator.pushNamed(context, '/css');
    }
  }

  void updateSelectedContainer(String id) {
    setState(() {
      selectedContainerId = id;
    });
  }
}
