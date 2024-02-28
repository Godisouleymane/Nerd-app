import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>?> getHtmlCourseFromFirestore() async {
  try {
    DocumentSnapshot courseSnapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc('html')
        .get();

    if (courseSnapshot.exists) {
      return courseSnapshot.data() as Map<String, dynamic>;
    } else {
      print('Le cours HTML n\'a pas été trouvé dans Firestore');
      return null;
    }
  } catch (error) {
    print(
        'Erreur lors de la récupération du cours HTML depuis Firestore: $error');
    return null;
  }
}
