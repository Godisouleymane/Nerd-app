import 'package:code_crafters/views/choixParcours/loadingAnimation.dart';
import 'package:code_crafters/views/login.dart';
import 'package:code_crafters/views/parcours/html/Cours_Screen.dart';
import 'package:code_crafters/views/parcours/html/html.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);
  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  String? selectedCourseId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                });
              },
              child: Card(
                color: isSelected ? Colors.teal : Colors.blueGrey,
                elevation: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.network(data['imageUrl'], width: 90, height: 90),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['titre'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const Gap(5),
                          Text(
                            data['description'],
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList();

          // Construction de la liste avec un En-tête
          return Column(
            children: [
              header,
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: courseWidgets.length,
                  itemBuilder: (context, index) {
                    return courseWidgets[index];
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 15.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(double.infinity, 50.0),
            elevation: 10,
          ),
          onPressed: () {
            if (selectedCourseId != null) {
              if (selectedCourseId == 'html') {
                montrerChargementEtSauvegarder();
              }
            } else {
              Fluttertoast.showToast(
                msg: "Veuillez sélectionner un cours.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
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

  void montrerChargementEtSauvegarder() {
    // Afficher l'animation de chargement
    showDialog(
      context: context,
      barrierDismissible:
          false, // L'utilisateur ne peut pas fermer le dialogue lui-même
      builder: (BuildContext context) {
        return const Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            insetPadding: EdgeInsets.all(0.0),
            child: LoadingAnimation());
      },
    );

    // Attendre quelques secondes avant de fermer l'animation et sauvegarder
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop(); // Fermer l'animation de chargement
      Navigator.pushNamed(context, '/html');
      // sauvegarderProgression();
    });
  }

  void initialiserProgression() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && selectedCourseId != null) {
      final docRef = FirebaseFirestore.instance
          .collection('progressionUtilisateurs')
          .doc(user.uid)
          .collection('coursEnCours')
          .doc(selectedCourseId);

      // Verifier si le document existe deja pour l'utilisateur et pour le cours
      final docSnapshot = await docRef.get();

      // si le document n'existe pas, initialiser la progression de l'utilisateur pour ce cours
      if (!docSnapshot.exists) {
        await docRef.set({
          'coursId': selectedCourseId,
          'leçonActuelle': null,
          'leçonsTerminee': [],
          'progressionGlobale': 0,
          'derniereLeçonTerminee': null,
          'scrore': 1,
          'dateDeDébut': FieldValue.serverTimestamp(),
        });
      } else {
        // La progression de ce utilisateur existe deja
        print('La progression de l\'utilisateur pour ce cours existe déjà.');
      }
    }
  }
}
