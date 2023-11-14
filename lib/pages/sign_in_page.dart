import 'package:camera/camera.dart';
import 'package:fall_app/config.dart';

import 'package:fall_app/pages/sign_up_view.dart';
import 'package:flutter/material.dart';

import '../../widget/custom_button.dart';

import '../bottom_bar_page.dart';
import '../const/Padding.dart';
import '../services/assets_manager.dart';
import '../services/auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'forgot_pass_page.dart';

class SignInPage extends StatefulWidget {
  final CameraDescription camera;
  const SignInPage({super.key, required this.camera});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _login = "Giriş";
  final String _eposta = "E-posta";

  Future<void> _signIn() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId= userCredential.user!.uid;
      if (userCredential.user != null) {
        // Giriş başarılı, ana sayfaya yönlendir
        Config.login="1";
        AuthHelper.setLoggedIn(true);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => BottomBarPage(
                  userId: userId,
                  camera: widget.camera,
                ),),
                  (route) => false,
        );
      } else {
        // Giriş başarısız, hata mesajı göster
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hata'),
              content: Text(
                  'Giriş yaparken bir hata oluştu. Lütfen tekrar deneyin.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Tamam'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Giriş yapılırken bir hata oluştu, hata mesajını görüntüleyebilirsiniz.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content:
                Text('E-posta ya da şifre hatalı.Lütfen tekrar deneyin'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );

      print('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: PaddingApp.paddingLoginPage,
        child: Column(
          children: [
            Column(
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
                        borderRadius: BorderRadius.circular(
                            10), // Kenarları yuvarlak yapar
                        child: Image.asset(
                          AssetsManager.logoImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Falcınız - Kahve & El Falınız",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 193, 3, 66),
                      ),
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(0.1))
                        ]),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(hintText: _eposta),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'E-posta boş olamaz';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: PaddingUtility().paddingTop,
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.1))
                          ]),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(labelText: 'Şifre'),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Şifre boş olamaz';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassPage(),) );
                            },
                            child: const Text("Şifremi Unuttum",style: TextStyle(color: Colors.pinkAccent),)),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomButton(
                          color: Colors.pinkAccent,
                          title: _login,
                          onPressed: () {
                            if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                              _signIn();
                            }
                            // AuthHelper.setLoggedIn(true);
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => BottomBarPage(
                            //       userId: "AqoNnmrzMSgErugY2noaXZXmvMm1",
                            //       camera: widget.camera,
                            //     ),
                            //   ),
                            //   (route) => false,
                            // );
                          },
                        ),
                      ),
                                      const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Henüz Bir Hesabın Yok Mu",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 13,color: Color.fromARGB(255, 25, 187, 251)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage(
                                      camera: widget.camera,
                                    )));
                      },
                      child: Text(
                        "Üye Ol",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.pinkAccent),
                      ),
                    ),
                  ],
                )
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class PngImage extends StatelessWidget {
  const PngImage({
    super.key,
    required this.name,
    this.height = 300,
  });
  final String name;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Image.asset(_nameWithPath, height: height, fit: BoxFit.cover);
  }

  String get _nameWithPath => "assets/images/$name.png";
}

class PaddingUtility {
  final EdgeInsets smallPadding = EdgeInsets.all(8);
  final EdgeInsets normalPadding = EdgeInsets.all(12);
  final paddingTop = const EdgeInsets.only(top: 10);
  final paddingBotttom = const EdgeInsets.only(bottom: 20);
  final paddingGeneral = const EdgeInsets.all(22);
  final paddingHorizontal = const EdgeInsets.symmetric(horizontal: 20);
}

class ImageItems {
  final String welcome_image = "login_image";
  final String logo_image = "logo";
}
