import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fall_app/bottom_bar_page.dart';
import 'package:fall_app/const/colors.dart';
import 'package:fall_app/pages/camera_view.dart';
import 'package:fall_app/pages/fal_page.dart';
import 'package:fall_app/pages/home_page.dart';
import 'package:fall_app/pages/login_view.dart';
import 'package:fall_app/services/api_service.dart';
import 'package:fall_app/services/fal_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

// import 'package:kartal/kartal.dart';
class FalSetting extends StatelessWidget {
  Future<bool> checkIfFalExists(String fal_id) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('fallar')
        .where('fal_id', isEqualTo: fal_id)
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  const FalSetting(
      {Key? key,
      required this.imagePath,
      required this.camera,
      required this.falTuru, required this.userId})
      : super(key: key);
  final String imagePath;
  final String userId;
  final FalTuru falTuru;

  final CameraDescription camera;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RichText(
              textAlign: TextAlign.justify,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'Fotoğraf çek 📸\n',
                    style: TextStyle(
                      color: Colors.orange,
                      fontFamily: 'AlfaSlabOne',
                    ),
                  ),
                  TextSpan(
                    text:
                        '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t🔮Falını gönder ',
                    style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'AlfaSlabOne',
                    ),
                  ),
                  TextSpan(
                    text: '1 dk içinde\n \t\t\t\t\tgerçekleri öğren 🪄 ',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontFamily: 'BrunoAceSC',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Gölge rengi
                        spreadRadius: 2, // Yayılma yarıçapı
                        blurRadius: 20, // Bulanıklık yarıçapı
                        offset: Offset(0, 10), // Gölgenin konumu (x, y)
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: FileImage(File(imagePath)), fit: BoxFit.cover)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0, top: 30),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorPurple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () async {
                      imagePa = imagePath;
                      try {
                        Fluttertoast.showToast(
                          msg:
                              "Falınız yorumlanıyor. Kısa sürede sonuçlanacaktır ve sonuca Fallarım ekranından erişebilirsiniz.Yönlendirilene kadar lütfen bekleyiniz..",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.grey[700],
                          textColor: Colors.white,
                        );

                        await ApiService.sendMessage(
                          message: falTuru == FalTuru.ElFali
                              ? "Şimdi sen dünyanın en iyi el falcısısın ve elimi görüyormuş gibi sadece ele bakarak şaşırtıcı, neden sonuç ilişkisine dayalı, kısa ve uzun vadeli tahminler yapan, geçmiş hakkında tahminler yapan el falı üret. Falcı gibi konuşmaya direkt başla. Çok uzun ,detaylı anlat ama sıkıcı olmasın. İlgi çekici olsun"
                              : falTuru == FalTuru.KahveFali
                                  ? "Şimdi sen dünyanın en iyi kahve falcısısın ve kahve falımı görüyormuş gibi şaşırtıcı, neden sonuç ilişkisine dayalı, kısa ve uzun vadeli tahminler yapan, geçmiş hakkında tahminler yapan kahve falı üret. Falcı gibi konuşmaya direkt başla.Çok uzun ,detaylı anlat ama sıkıcı olmasın. İlgi çekici olsun"
                                  : "Şimdi sen dünyanın en iyi yüz falcısısın ve yüz falımı görüyormuş gibi şaşırtıcı, neden sonuç ilişkisine dayalı, kısa ve uzun vadeli tahminler yapan, geçmiş hakkında tahminler yapan yüz falı üret. Falcı gibi konuşmaya direkt başla.Çok uzun ,detaylı anlat ama sıkıcı olmasın. İlgi çekici olsun",
                        );

                        addFal(
                          Uuid().v1(),
                          userId,
                          _findFalTuru(),
                          ApiService.fal,
                          imagePa,
                        );
                      } catch (e) {
                        print("error $e");
                      }
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomBarPage(camera: camera,userId: userId),
                        ),
                        (route) => false,
                      );
                    },

                    // onPressed: () async {
                    //   imagePa = imagePath;
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const FalPage(),
                    //       ));
                    //   try {
                    //     await ApiService.sendMessage(
                    //         message: falTuru == FalTuru.ElFali
                    //             ? "Şimdi sen dünyanın en iyi el falcısısın ve elimi görüyormuş gibi sadece ele bakarak şaşırtıcı, neden sonuç ilişkisine dayalı, kısa ve uzun vadeli tahminler yapan, geçmiş hakkında tahminler yapan el falı üret. Falcı gibi konuşmaya direkt başla."
                    //             : "Şimdi sen dünyanın en iyi kahve falcısısın ve kahve falımı görüyormuş gibi şaşırtıcı, neden sonuç ilişkisine dayalı, kısa ve uzun vadeli tahminler yapan, geçmiş hakkında tahminler yapan el falı üret. Falcı gibi konuşmaya direkt başla.");
                    //     addFal(Uuid().v1(), userId, _findFalTuru(), ApiService.fal, imagePa,);
                    //   } catch (e) {
                    //     print("error $e");
                    //   }
                    // },
                    child: const Text("Falı Gönder")),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _findFalTuru() => falTuru == FalTuru.ElFali
      ? "El Falı"
      : falTuru == FalTuru.KahveFali
          ? "Kahve Falı"
          : "Yüz Falı";
}
