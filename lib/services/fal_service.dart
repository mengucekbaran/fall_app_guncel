import 'package:cloud_firestore/cloud_firestore.dart';

class Fal {
  String fal_id;
  String user_id;
  String fal_turu;
  String fal_icerik;
  String fal_photo;
  Fal({
    required this.fal_id,
    required this.user_id,
    required this.fal_turu,
    required this.fal_icerik,
    required this.fal_photo
  });

  //veri çekme
  factory Fal.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Fal(
      fal_id: data["fal_id"],
      user_id: data['user_id'],
      fal_turu: data['fal_turu'],
      fal_icerik: data["fal_icerik"],
      fal_photo: data["fal_photo"]
    );
  }
}
//veri ekleme
void addFal(fal_id,user_id, fal_turu, fal_icerik,fal_photo) {
  Fal fal =
      Fal(fal_id: fal_id, user_id: user_id, fal_turu: fal_turu, fal_icerik: fal_icerik,fal_photo:fal_photo);

  FirebaseFirestore.instance.collection('fallar').add({
    'fal_id': fal.fal_id,
    'user_id': fal.user_id,
    'fal_turu': fal_turu,
    'fal_icerik': fal.fal_icerik,
    'fal_photo': fal.fal_photo,

  }).then((value) {
    print('Fal added successfully!');
  }).catchError((error) {
    print('Failed to add fal: $error');
  });
}