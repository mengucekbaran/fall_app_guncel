import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widget/custom_button.dart';
import '../const/Padding.dart';
import '../services/assets_manager.dart';
import 'sign_in_page.dart';

// String userId = "";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.camera});
  final CameraDescription camera;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  Future<void> _signUp() async {
    try {
      // final username = _usernameController.text;
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;
      if (password != confirmPassword) {
        print('Hata: Şifreler eşleşmiyor');
        return;
      }

      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      final userId = userCredential.user?.uid ?? '';
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': _emailController.text.trim(),
        'userId': userId,
        'username': _usernameController.text.trim(),
        'password': _passwordController.text,
        'photoUrl': '',
      });
      // Kullanıcı kaydı başarılı, bilgilendirme mesajı göster
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Başarılı'),
            content: Text('Üyelik işlemi başarıyla tamamlandı.'),
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
      // Kullanıcı kaydı başarılı, istediğiniz işlemleri yapabilirsiniz.
    } catch (e) {
      // Kayıt oluşturulurken bir hata oluştu, hata mesajını görüntüleyebilirsiniz.
      if (mounted) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hata'),
              content: e.toString().contains('email-already-in-use')
                  ? Text(
                      'Kaydolmaya çalıştığınız e-posta adresi zaten başka bir kullanıcı tarafından kullanılıyor.')
                  : Text('Kaydolma sırasında bir hata oluştu.'),
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
      print('Hata: $e');
    }
  }

  final String _uyeOl = "Üye Ol";

  final String _mail = "Enter your e-mail address";

  final String _username = "Username";

  final String _password = "Şifrenizi girin";

  final String _passwordAgain = "Şifrenizi tekrar girin";

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
                    borderRadius:
                        BorderRadius.circular(10), // Kenarları yuvarlak yapar
                    child: Image.asset(
                      AssetsManager.logoImage,
                      height: 340,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Seni Aramızda Görmek\nÇok Güzel",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.pink,
                      fontFamily: 'BrunoAceSC',
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                ),
                const SizedBox(
                  height: 15,
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
                          decoration: InputDecoration(hintText: _mail),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email boş olamaz';
                            } else if (!isValidEmail(value)) {
                              return 'Geçerli bir email adresi girin';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: PaddingApp.paddingSmallTop,
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.1))
                          ]),
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(hintText: _username),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Kullanıcı adı boş olamaz';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: PaddingApp.paddingSmallTop,
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
                            decoration: InputDecoration(hintText: _password),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Şifre boş olamaz';
                              } else if (value.length < 6) {
                                return 'Şifre 6 haneden küçük olamaz';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: PaddingApp.paddingSmallTop,
                        child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.1))
                            ]),
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration:
                                  InputDecoration(hintText: _passwordAgain),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Şifre boş olamaz';
                                }
                                if (value != _passwordController.text) {
                                  return 'Şifreler eşleşmiyor';
                                }
                                return null;
                              },
                            )),
                      ),
                      // Padding(
                      //   padding: PaddingApp.paddingSmallTop,
                      //   child: CustomTextField(
                      //       text: _passwordAgain, isPassword: true),
                      // ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomButton(
                          title: _uyeOl,
                          onPressed: ()async{
                            if (_formKey.currentState!.validate()) {
                              await _signUp();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage(
                                          camera: widget.camera,
                                        )),
                                (route) => false,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   child: CustomButton(title: _loginWithGoogle,onPressed:() {

                //   },),
                // ),
                // const SizedBox(height: 7,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children:  [
                //     const Text("Don’t Have An Account?"),
                //     TextButton(
                //     onPressed: () { },
                //     child:  Text("Sign Up",style: Theme.of(context).textTheme.titleSmall?.copyWith(
                //       fontWeight: FontWeight.w500,
                //       color: const Color.fromRGBO(24, 91, 255, 1)

                //     ),),),

                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  bool isValidEmail(String email) {
    return EmailValidator.validate(email);
  }
}

