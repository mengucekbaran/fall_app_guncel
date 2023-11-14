import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fall_app/services/users_service.dart';

Future<User?> getUserDataByUserId(String userId) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('userId', isEqualTo: userId)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    print("object");
    DocumentSnapshot doc = querySnapshot.docs.first;
    User user = User.fromFirestore(doc);
    user.id = doc.id; // Firestore belge kimliğini User nesnesine ekleyin
    return user;
  } else {
    return null;
  }
}