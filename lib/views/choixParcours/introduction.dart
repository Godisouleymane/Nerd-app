import 'package:code_crafters/views/choixParcours/loadingAnimation.dart';
import 'package:code_crafters/views/login.dart';
import 'package:code_crafters/views/parcours/html/Cours_Screen.dart';
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
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pop(); // Fermer l'animation de chargement
      // sauvegarderProgression();
    });
  }

//  void sauvegarderProgression() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null && selectedCourseId != null) {
//       try {
//         final docRef = FirebaseFirestore.instance
//             .collection('progressionUtilisateurs')
//             .doc(user.uid)
//             .collection(
//                 'cours') // Ajouter une sous-collection pour organiser les cours
//             .doc(selectedCourseId);

//         await docRef.set(
//             {
//               'coursId': selectedCourseId,
//               'progression': 0, // Initialiser la progression à 0
//               'dernièreLeçon':
//                   1, // Supposons que l'utilisateur commence à la leçon 1
//               'dernièreMiseÀJour': FieldValue
//                   .serverTimestamp(), // Stocker la date de la dernière mise à jour
//             },
//             SetOptions(
//                 merge:
//                     true)); // Utiliser merge pour ne pas écraser d'autres champs

//         // Navigation dynamique basée sur le cours sélectionné
//         // ignore: use_build_context_synchronously
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           switch (selectedCourseId) {
//             case 'html':
//               return CourseModulesScreen(courseId: 'html_cours');
//             // Ajouter d'autres cas pour différents cours
//             default:
//               return const IntroductionPage(); // Retourner à la page d'introduction si l'ID du cours n'est pas géré
//           }
//         }));
//       } catch (e) {
//         if (!mounted) return;

//         Fluttertoast.showToast(
//           msg: "Erreur lors de la sauvegarde de la progression : $e",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//         );
//       }
//     } else {
//       if (!mounted) return;

//       Fluttertoast.showToast(
//         msg: "Aucun cours sélectionné ou utilisateur non connecté.",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//       );
//     }
//   }

}
