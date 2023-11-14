import 'package:flutter/material.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';
import '../const/Padding.dart';
import '../services/assets_manager.dart';
import '../widget/flash_message_screen.dart';

class ContactUsView extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  final String _send = "Gönder";
  final String _mail = "Mail adresinizi giriniz";
  final String _username = "Kullanıcı Adı";
  final String _subject = "Konu Başlığı";
  final String _description = "Açıklama";
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
          title: const Text("Bizimle İletişime Geç"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: PaddingApp.paddingLoginPage,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    CustomCard(
                        color: Color(0xffE67605), subtitle: "info@ile.com.tr",iconPath: AssetsManager.mailIcon ),
                    CustomCard(
                        color: Color(0xff01D277),
                        subtitle: "Yenimahalle İsmetinönü Cd. No:130/A Atakum",
                        iconPath: AssetsManager.telIcon,
                        ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      CustomTextField(
                        text: _mail,
                      ),
                      Padding(
                        padding: PaddingApp.paddingSmallTop,
                        child: CustomTextField(text: _username),
                      ),
                      Padding(
                        padding: PaddingApp.paddingSmallTop,
                        child: CustomTextField(text: _subject),
                      ),
                      Padding(
                        padding: PaddingApp.paddingSmallTop,
                        child: CustomTextField(text: _description, maxLines: 5),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: PaddingApp.paddingTop,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomButton(
                            title: _send,
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                // Form geçerliyse, işlemleri burada gerçekleştirin
                                // Örneğin, verileri bir API'ye gönderme veya kaydetme
                                // işlemlerini burada yapabilirsiniz.
                                // Burada sadece bir mesaj gösterelim.
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Başarılı'),
                                      content:
                                          Text('Form başarıyla gönderildi.'),
                                      actions: [
                                        TextButton(
                                          child: Text('Tamam'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: CustomSnackBarContent(
                                      errorText:
                                          "That Email Address is already in use! Please try with a different one.",
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                );
                              }
                              //*********************************
                            },
                          ),
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
                      // Form(
                      //   child: Column(
                      //     children: [
                      //       TextFormField(
                      //         decoration: InputDecoration(
                      //           labelText: 'Metin',
                      //         ),
                      //         validator: validateTextField,
                      //       ),
                      //       TextFormField(
                      //         controller: _controller,
                      //         decoration: InputDecoration(
                      //           labelText: 'Metin',
                      //         ),
                      //         validator: validateTextField,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class CustomCard extends StatelessWidget {
const CustomCard({
  Key? key,
  required this.color,
  required this.subtitle,
  required this.iconPath,
}) : super(key: key);
  final Color color;
  final String subtitle;
  final String iconPath;
  @override
  Widget build(BuildContext context) {

    return Card(
      shadowColor: Colors.black,
      color: color,
      child: SizedBox(
        width: 150,
        height: 112,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(iconPath,color: Colors.white,width: 35,height: 35,)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String? validateTextField(String? value) {
  if (value == null || value.isEmpty) {
    return 'Bu alan boş bırakılamaz.';
  }
  return null;
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
