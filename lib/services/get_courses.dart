import 'package:cloud_firestore/cloud_firestore.dart';


Future<Map<String, dynamic>?> getHtmlCourseFromFirestore() async {
  DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('courses').doc('html').get();
  if (snapshot.exists) {
    return snapshot.data() as Map<String, dynamic>?;
  }
  return null;
}
