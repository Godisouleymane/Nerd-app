import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  String? selectedCourseId;
  bool isAnimating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 217, 217),
      appBar: AppBar(
        title: const Text(
          "Nerd",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('selectedCours').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Quelque chose s'est mal passé"));
          }
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.teal));
          }
          // Widget En-tête
          Widget header = const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Choisissez ce que vous voulez apprendre",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );

          // Widgets des Cours
          List<Widget> courseWidgets =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            bool isSelected = data['id'] == selectedCourseId;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCourseId = data['id'];
                  isAnimating = true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: isSelected ? Colors.teal : Colors.blueGrey,
                  elevation: 5,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.network(
                          data['imageUrl'],
                          width: 90,
                          height: 90,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10.0, bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['titre'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                data['description'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList();

          // Construction de la liste avec un En-tête
          return SingleChildScrollView(
            child: Column(
              children: [header] + courseWidgets,
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 15.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isAnimating = true;
            });

            // Retarder la navigation pour permettre à l'utilisateur de voir l'animation
            Future.delayed(const Duration(milliseconds: 500), () {
              if (selectedCourseId != null) {
                print('hello');
              } else {
                Fluttertoast.showToast(
                  msg: "Veuillez sélectionner un cours.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
                // Réinitialiser l'état d'animation
                setState(() {
                  isAnimating = false;
                });
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(
              color: isAnimating ? Colors.green : Colors.teal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: isAnimating
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Commencer",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void sauvegarderProgression() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null && selectedCourseId != null) {
      FirebaseFirestore.instance
          .collection('progressionUtilisateurs')
          .doc(user.uid)
          .set({
        'coursId': selectedCourseId,
        'progression': 0,
      }).then((_) {
        print('Sauvegarder avec succes');
        // Afficher une confirmation.
        Fluttertoast.showToast(
            msg: 'Bon apprentissage a vous.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        // Renvoyer l'ecran du cours choisi a l'utilisateur.
      }).catchError((error) {
        print(
            'Erreur lors de la sauvegarde de la progression ${error.message}');
        // Gestion d'erreur
        Fluttertoast.showToast(
          msg: "Erreur lors de la sauvegarde de la progression.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      });
    } else {
      print('Aucun cours selectionner');
      // Afficher un message si aucun utilisateur n'est connecté ou aucun cours n'est sélectionné
      Fluttertoast.showToast(
          msg: "Aucun cours sélectionné ou utilisateur non connecté.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    }
  }
}
