import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:fall_app/bottom_bar_page.dart';
import 'package:fall_app/const/colors.dart';
import 'package:fall_app/pages/sign_up_view.dart';
import 'package:fall_app/pages/google_auth_webview.dart';
import 'package:fall_app/services/assets_manager.dart';
import 'package:fall_app/services/users_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../config.dart';
import '../const/Padding.dart';
import '../models/google_code_model.dart';
import '../services/api_service.dart';
import '../services/auth_helper.dart';
import 'package:http/http.dart' as http;
import '../widget/custom_rich_text.dart';
import 'sign_in_page.dart';
import 'package:url_launcher/url_launcher.dart';

// String userId="";
class LoginPage extends StatefulWidget {
  
  final CameraDescription camera;
   LoginPage({super.key, required this.camera});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static GoogleCodeModel? _item;

  final _url='https://youtube.com/activate';
  void _launchUrl() async {
    const url = 'https://youtube.com/activate'; // Açmak istediğiniz web sitesinin URL'sini buraya yazın
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Web sitesi açılamadı: $url';
    }
  }


  @override
  void initState() {
    super.initState();
    fetchGoogleCode();
  }
  //PHPSESSİON ID YI ALMA FONKSİYOUNU
  String extractPhpSessionId(String? cookie) {
    if (cookie!.isNotEmpty) {
        final parts = cookie.split(';');
        for (final part in parts) {
          final keyValue = part.trim().split('=');
          if (keyValue.length == 2 && keyValue[0] == 'PHPSESSID') {
            return keyValue[1];
          }
      }
    }
    return '';
  }

  Future<void> fetchGoogleCode() async {
    try {
      
      final response =
          await http.get(Uri.parse('${ApiService.apiBaseLink}api.php'));

      if (response.statusCode == 200) {
        print("istek başarılı");
        final _data = jsonDecode(response.body);
        print("body:${response.body}");
        final cookie = response.headers['set-cookie'];
        // PHPSESSID'yi almak için:
        setState(() {
          _item = GoogleCodeModel.fromJson(_data);
          _item?.phpSessionId=extractPhpSessionId(cookie);
          print("PHPSESSID: ${_item?.phpSessionId}");
        });
        // final _datas = json.decode(response.body);
        // print(_datas);
        // if(_datas is List){

        // }

        // Veri işlemlerini burada gerçekleştirin
      } else {
        print('API isteği başarısız oldu. Hata kodu: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  Future<bool> checkIfUserExists(String email) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  //MİSAFİR GİRİŞ Mİ? GOOGLE İLE GİRİŞ Mİ
  // Future<bool> fetchGirisSekli() async {
  //   try {
  //     final response = await http.get(Uri.parse('${ApiService.apiBaseLink}status.txt'));

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       bool result = data == 1; // true olarak değerlendirilir
  //       return result;
  //       // Veri işlemlerini burada gerçekleştirin
  //     } else {
  //       print('API isteği başarısız oldu. Hata kodu: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Hata oluştu: $e');
  //   }
  //   return false;
  // }

  Future<void> signInWithGoogle() async {
    //firebase kimlik doğrulamasının bir örneği ve google oturumu oluşturma
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    //triger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    //taking Username and email

    //obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    //Create a new credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    //Sign in the user with the credentials
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    final userId = userCredential.user!.uid ?? "";
    final String userName = userCredential.user!.displayName ?? "";
    final String email = userCredential.user!.email ?? "";
    final String photoUrl = userCredential.user!.photoURL ?? "";
    print("id:$userId kullanıcı adı:$userName email:$email photo:$photoUrl");
    checkIfUserExists(email.toString()).then(
      (value) {
        if (value) {
        } else {
          addUser(name:  userName,email:  email,photo:  photoUrl);
          print("kullanıcı eklendi");
        }
      },
    );
    if (userCredential.user != null) {
      // Giriş başarılı, ana sayfaya yönlendir
      Config.login = "1";
      AuthHelper.setLoggedIn(true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomBarPage(
            userId: userId,
            camera: widget.camera,
          ),
        ),
      );
    }
  }

  final String _loginWithGoogle = "Login With Google";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: PaddingApp.paddingLoginPage,
              child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                  padding: PaddingApp.paddingLargeTop,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Gölge rengi
                          spreadRadius: 2, // Gölge yayılma yarıçapı
                          blurRadius: 5, // Gölge bulanıklık yarıçapı
                          offset: Offset(0, 3), // Gölgenin konumu
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10), // Kenarları yuvarlak yapar
                      child: Image.asset(
                        AssetsManager.logoImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Falcınız - Kahve & El Falınız",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorPink,
                      ),
                ),
              ),            
              CustomRichText(),
        
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<bool>(
                  future: ApiService.fetchGirisSekli(),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Veri çekme işlemi hala devam ediyorsa, yükleniyor gösterebilirsiniz
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Veri çekme işleminde hata oluştuysa, hata mesajını gösterebilirsiniz
                      return Text('Veri çekme hatası: ${snapshot.error}');
                    } else {
                      // Veri çekme işlemi tamamlandıysa, sonucu kullanarak widget oluşturabilirsiniz
                      return buildLoginButton(snapshot.data ?? false, context);
                    }
                  },
                ),            
              )
            ],
          ),
              ),
            ),
        ));
  }

  Widget buildLoginButton(bool fetchDataResult, BuildContext context) {
    if (fetchDataResult) {
      return Padding(
        padding: const EdgeInsets.only(top:15.0),
        child: Column(
          children: [
            Text("Fallanmak İçin Alttaki Kodu Kopyala 😇 ",style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontFamily: "AlfaSlabOne",
                  color: Colors.lightBlue,
                  fontSize: 13
      
                ),),
            Padding(
              padding: PaddingApp.paddingTop,
              child: ListTile(
                title: Card(child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(" ${(_item?.code ?? "")}",style: const TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold),),
                  ),
                )),
                trailing: ElevatedButton.icon(
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.pinkAccent,)),
                  label:Text("Kopyala"),
                  icon: const Icon(Icons.copy,color: Colors.white,),                
                  onPressed: () {
                      Clipboard.setData(ClipboardData(text: _item?.code??""));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Kopyalandı!')),
                      );
                    },
                  ),
              ),
            ),
            // Text(_item?.phpSessionId ?? "tst"),
            Padding(
              padding: const EdgeInsets.only(top:15.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),
                ),
                onPressed: () async {
                  // showCodePopup(context, _item?.code??"deneme");
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => GoogleAuthWebView(_url,_item?.phpSessionId,widget.camera),),(route) => false,);
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  // await signInWithGoogle();
                  // if (mounted) {
                  //   await Future.delayed(const Duration(seconds: 3), () {
                  //     // Gecikmeden sonra yapılması gereken işlemleri burada gerçekleştirin
                  //   });
                  //   // Navigator.pushAndRemoveUntil(
                  //   //   context,
                  //   //   MaterialPageRoute(
                  //   //     builder: (context) => BottomBarPage(
                  //   //       userId: userId,
                  //   //       camera: widget.camera,
                  //   //     ),
                  //   //   ),
                  //   //   (route) => false,
                  //   // );
                  // }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsManager.googleImage,
                      width: 25,
                    ),
                    SizedBox(width: 15),
                    Text(
                      _loginWithGoogle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top:25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpPage(
                              camera: widget.camera,
                            )));
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Color.fromARGB(255, 25, 187, 251),
              )),
              child: Text(
                'Üye Ol',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignInPage(
                              camera: widget.camera,
                            )));
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Colors.pinkAccent,
              )),
              child: Text(
                'Giriş Yap',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
