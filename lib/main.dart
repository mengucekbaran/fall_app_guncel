import 'package:camera/camera.dart';
import 'package:fall_app/pages/login_view.dart';
import 'package:fall_app/services/api_service.dart';
import 'package:fall_app/services/auth_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'bottom_bar_page.dart';
import 'config.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  //**Firebase Bağlantısı */
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ApiService.initializeApiBaseLink();
  
  //************* */
  runApp(
    
    MyApp(
    camera: firstCamera,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera,});
  final CameraDescription camera;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16)),
          hintStyle:
              Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black54),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16)),
          fillColor: Color.fromARGB(245, 255, 255, 255),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16)),
        ),
        appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            titleTextStyle: Theme.of(context).textTheme.titleLarge),
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<String?>(
        future: AuthHelper.checkLoginStatus(),
        builder: (context, snapshot) {
          if (Config.login == "0") {
            // Kullanıcı giriş yapmamış, Giriş Sayfasını göster
            return LoginPage(camera: camera,);            
          } else if (Config.login == "1") {
            // Kullanıcı daha önce giriş yapmış, Ana Sayfayı göster
            return BottomBarPage(camera: camera,userId: snapshot.data!,);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      // BottomBarPage(
      //   camera: camera,
      // ),
    );
  }
}


