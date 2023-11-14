import 'package:camera/camera.dart';
import 'package:fall_app/config.dart';
import 'package:fall_app/pages/login_view.dart';
import 'package:fall_app/pages/policy_dialog.dart';
import 'package:fall_app/pages/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../const/Padding.dart';
// import '../const/colors.dart';
// import '../services/assets_manager.dart';
import '../services/auth_helper.dart';
import '../services/fetching_user_with_id.dart';
import '../services/users_service.dart';
import 'contact_us_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.camera, required this.userId});
  final CameraDescription camera;
  final String userId;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> logout() async {
    Config.login="0";
    final GoogleSignIn googleSign = GoogleSignIn();
    await googleSign.signOut();
  }
  String _hesap = "Hesap";
  // String _tercihler = "Tercihler";
  // String _diger = "Diğer";
  // bool _notifications = true; // bildirimleri aç

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 30,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<User?>(
          future: getUserDataByUserId(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
      
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: Text('User not found.'),
              );
            }
      
            User user = snapshot.data!;
      
            return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 78),
          child: Column(
            children: [
              Padding(
            padding: PaddingApp.paddingMediumBottom,
            child: Column(
              children: [
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      '${user.name}',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  subtitle: Text('${user.email}',style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 10,
                    color: Colors.grey
                  )),
                  leading: CircleAvatar(backgroundImage: NetworkImage("${user.photo}")),
                  trailing: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                      onPressed: () async {
                        await logout();
                        AuthHelper.setLoggedIn(false);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage(camera: widget.camera,)),
                          (route) => false,
                        );
                        
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             const OnBoarding()));
                      },
                      child: Text("Çıkış Yap",style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 10,
                    color: Colors.white
                  ))),
                ),
                Padding(
                  padding: PaddingApp.paddingLargeTop,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                        child: _setTitle(context, _hesap),
                      ),
                      // CustomListTileWidget(
                      //   leading: const Icon(Icons.notifications),
                      //   title: "Bildirimleri Aç",
                      //   trailing: Transform.scale(
                      //     scale: 0.7, // Boyutu ayarlamak için
                      //     child: CupertinoSwitch(
                      //       value: _notifications,
                      //       activeColor: appBarColor,
                      //       onChanged: (value) {
                      //         setState(() {
                      //           _notifications = value;
                      //         });
                      //       },
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     setState(() {
                      //       _notifications = !_notifications;
                      //     });
                      //   },
                      // ),
      
      
                      // CustomListTileWidget(
                      //   leading: const Icon(Icons.message_sharp),
                      //   title: "Bizimle iletişime geç",
                      //   trailing: _rightIcon(),
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       CupertinoPageRoute(
                      //         builder: (context) => ContactUsView(),
                      //       ),
                      //     );
                      //   },
                      // ),
                      CustomListTileWidget(
                        leading: const Icon(Icons.privacy_tip_outlined),
                        title: "Gizlilik Politikaları",
                        trailing: _rightIcon(),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return PolicyDialog(
                                mdFileName: "privacy_policy.md",
                              );
                            },
                          );
                        },
                      ),
                      CustomListTileWidget(
                        leading: const Icon(Icons.settings),
                        title: "Ayarlar",
                        trailing: _rightIcon(),
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => SettingsView(),
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
              ),
            ],
          ),
        );
          },
        ),
      ),
      
    );
  }

  Text _setTitle(BuildContext context, String title) => Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
      );
  // Açma Kapama Butonu
  // Switch _switchIt(bool _isSwitch) {
  //   return Switch(
  //                 value:_isSwitch ,
  //                 onChanged: (value){
  //                   setState(() {
  //                     _isSwitch=value;
  //                   });
  //                 },);
  // }

  Icon _rightIcon() => const Icon(Icons.chevron_right_outlined);

  Column _socialPlatforms(String imagePath, String title) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          width: 25,
          height: 25,
        ),
        const SizedBox(
          height: 3,
        ),
        Text(title),
      ],
    );
  }
}
// class Switch extends StatelessWidget {
//   const Switch({super.key,this.isSwitched=false});
//   final bool isSwitched;
//   @override
//   Widget build(BuildContext context) {
//     return Switch(value: isSwitched, onChanged: (){

//     });
//   }
// }
class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget(
      {super.key,
      required this.leading,
      required this.title,
      required this.trailing,
      this.onTap});
  final Widget leading;
  final String title;
  final Widget trailing;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onTap,
      leading: leading,
      title: Text(title),
      trailing: trailing,
    );
  }
}
