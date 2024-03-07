import 'package:code_crafters/views/widgets/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Assurez-vous d'ajouter fluttertoast à votre pubspec.yaml

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
      appBar: AppBar(
        title: const Text(
          "Nerd",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('selectedCours').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Quelque chose s'est mal passé"));
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              bool isSelected = data['id'] ==
                  selectedCourseId; 
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCourseId = data['id'];
                    print(selectedCourseId);
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
                              padding: const EdgeInsets.only(left: 10, right: 10.0, bottom: 8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['titre'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      data['description'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                    ),
                                  ]),
                            )),
                          ],
                        ))),
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 15.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              minimumSize: const Size(double.infinity, 50.0),
              elevation: 10),
          onPressed: () {},
          child: const Text(
            "Commencer",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
