import 'dart:async';
import 'package:camera/camera.dart';
import 'package:fall_app/bottom_bar_page.dart';
// import 'package:fall_app/pages/home_page.dart';
// import 'package:fall_app/pages/login_view.dart';
import 'package:fall_app/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fall_app/services/users_service.dart';

class GoogleAuthWebView extends StatefulWidget {
  final CameraDescription camera;
  final String url;
  final String? phpSessId;
  GoogleAuthWebView(this.url, this.phpSessId, this.camera);

  @override
  createState() => _GoogleAuthWebViewState(this.url,this.phpSessId);
}

class _GoogleAuthWebViewState extends State<GoogleAuthWebView> {
  var _url;
  var _phpSessId;
  // late String userId;
  
  Timer? _timer;
  final _key = UniqueKey();

  _GoogleAuthWebViewState(this._url,this._phpSessId);
  @override
  void initState() {
    // TODO: implement initState
    
    // İlk get isteğini yapmak için 2 saniye bekleyin
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async{
      var _user =await LoginService.fetchGoogleUser(_phpSessId);
      // fetchGoogleLoginStatus(_phpSessId);
      if (_user?.status=="success") {
        
        checkIfUserExists(_user!.email.toString()).then(
      (userId) {
        print("USEEERIIDD: ${userId}");
        if (userId!="") {
          userID=userId;
        } else {
          addUser(name: _user.name, email: _user.email, photo: _user.photo);
          print("kullanıcı eklendi");
        }
      },
    );
        await Future.delayed(const Duration(seconds: 2), () {
                   // Gecikmeden sonra yapılması gereken işlemleri burada gerçekleştirin
                           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomBarPage(camera: widget.camera, userId: userID??""),),(route) => false,);

                 });
      }
    })
    ;
  }
  @override
  void dispose() {
    // Zamanlayıcıyı iptal edin
    _timer?.cancel();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kod Doğrulama'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: _url,
            ),
          ),
        ],
      ),
    );
  }
}
