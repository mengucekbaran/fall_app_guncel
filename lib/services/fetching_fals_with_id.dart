import 'package:cloud_firestore/cloud_firestore.dart';

import 'fal_service.dart';

Future<Fal?> getFalDataByFalId(String falId) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('fallar')
      .where('fal_id', isEqualTo: falId)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    print("object");
    DocumentSnapshot doc = querySnapshot.docs.first;
    Fal fal = Fal.fromFirestore(doc);
    fal.fal_id = doc.id; // Firestore belge kimliğini User nesnesine ekleyin
    return fal;
  } else {
    return null;
  }
}