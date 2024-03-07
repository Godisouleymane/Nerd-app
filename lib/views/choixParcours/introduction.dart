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
              Fluttertoast.showToast(
                msg: "Cours sélectionné : $selectedCourseId",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
              // Naviguer vers la page du cours ou une autre action ici
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

  void sauvergarderProgression() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null && selectedCourseId != null) {
      
    }
  }
}
