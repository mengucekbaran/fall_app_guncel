import 'package:camera/camera.dart';
import 'package:fall_app/pages/camera_view.dart';
// import 'package:fall_app/pages/login_view.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../services/fetching_user_with_id.dart';
import '../services/users_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.camera, required this.userId}) : super(key: key);
  final CameraDescription camera;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title:  Text('Falcınız - Kahve & El Falınız',style: TextStyle(color: colorPurple),),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: SvgPicture.asset("assets/icons/icon_notifi.svg")),
        //   IconButton(
        //       onPressed: () {},
        //       icon: SvgPicture.asset("assets/icons/icon_profile.svg"))
        // ],
      ),
      body: FutureBuilder<User?>(
        future: getUserDataByUserId(userId),
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
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AvatarWidget(userName: "${user.name}"),
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://i.pinimg.com/originals/b8/58/c6/b858c60ab186d515feb6d44e51fcef16.jpg"),
                  radius: 14,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Hemen Yeni Bir Fal Baktır!",
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            GridViewOlacak(
              camera: camera,
              userId: userId,
            ),
          ],
        ),
      );
    
        },
      ),
 );
  }
}

class GridViewOlacak extends StatelessWidget {
  const GridViewOlacak({
    Key? key,
    required this.camera,
    required this.userId
  }): super(key: key);
  final CameraDescription camera;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 3.6 / 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16),
          children: [
            MenuCardWidget(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CameraExampleHome(userId: userId ,camera: camera,falTuru: FalTuru.ElFali),));
              },
              image: "assets/image/img_lean.png",
              title: "El Falı",
              desc: "El Falı İle Açıklama",
            ),
            MenuCardWidget(
              image: "assets/image/img_test.png",
              title: "Kahve Falı",
              desc: "Kahve Falı İle Açıklama",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CameraExampleHome(userId: userId,camera: camera,falTuru: FalTuru.KahveFali),));
              },
            ),
            MenuCardWidget(
              image: "assets/image/img_test.png",
              title: "Yüz Falı",
              desc: "Yüz Falı ile Açıklama",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CameraExampleHome(userId: userId,camera: camera,falTuru: FalTuru.YuzFali),));

              },
            ),
          ],
        ),
      ),
    );
    // return Column(
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         MenuCardWidget(
    //           onTap: () {},
    //           image: "assets/image/img_lean.png",
    //           title: "El Falı",
    //           desc: "El Falı İle Açıklama",
    //         ),
    //         MenuCardWidget(
    //           onTap: () {},
    //           image: "assets/image/img_test.png",
    //           title: "Kahve Falı",
    //           desc: "Kahve Falı İle Açıklama",
    //         ),
    //       ],
    //     ),
    //     SizedBox(
    //       height: context.width * .04,
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         MenuCardWidget(
    //           onTap: () {},
    //           image: "assets/image/img_lean.png",
    //           title: "Yakında Gelecek",
    //           desc: "açıklama alanı",
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}

class MenuCardWidget extends StatelessWidget {
  const MenuCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
    this.onTap,
  });
  final String image;
  final String title;
  final String desc;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2.35,
        height: MediaQuery.of(context).size.width / 2.2,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 10,
                  color: Colors.grey.withOpacity(.2))
            ]),
        child: Column(
          children: [
            Image.asset(image),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontSize: 12, color: Colors.black54,),
            )
          ],
        ),
      ),
    );
  }
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key, required this.userName,
  });
  final String userName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: colorPurple, borderRadius: BorderRadius.all(Radius.circular(20))),
      height: 60,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomCircleAvatar(),
          SizedBox(
            width: MediaQuery.of(context).size.width * .01,
          ),
          Center(
            child: Row(
              children: [
                Text(
                  "👋Hoş Geldin ${userName}",
                  style: Theme.of(context).textTheme.titleSmall
                      ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const Spacer(),
          Image.asset("assets/image/img_title.png"),
        ],
      ),
    );
  }
}

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(97, 255, 255, 255), shape: BoxShape.circle),
      child: Container(
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        padding: const EdgeInsets.all(2),
        child: const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
              "https://i.pinimg.com/originals/b8/58/c6/b858c60ab186d515feb6d44e51fcef16.jpg"),
        ),
      ),
    );
  }
}
enum FalTuru {
  ElFali,
  KahveFali,
  YuzFali
}