import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final String _eposta="E-posta";

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }
  Future<void> passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Şifre sıfırlama maili başarılı bir şekilde gönderildi. Lütfen mail kutunuzu kontrol ediniz.")
            );
          },
        );
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hata'),
              content: e.toString().contains('user-not-found')
                  ? Text(
                      'Girilen e-postaya sahip kullanıcı bulunamadı.')
                  : Text('Sıfırlama e-postası yollanırken hata oluştu.Daha sonra tekrar deneyiniz. '),
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text("Mail Adresinize şifre sıfırlama linki yollanacaktır.",textAlign: TextAlign.center,),
            ),
            SizedBox(height: 10,),
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
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: (){if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                passwordReset();
              }} ,
              child: Text('Şifremi Sıfırla',style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  color: Colors.white,
                ),),
            ),
          ],
        ),
      ),
      
    );
  }
}
