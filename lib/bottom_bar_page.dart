import 'package:camera/camera.dart';
import 'package:fall_app/pages/fal_page.dart';
import 'package:fall_app/pages/home_page.dart';
import 'package:fall_app/pages/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.home,
    title: 'Home',
  ),
  TabItem(
    icon: Icons.people,
    title: 'Fallarım',
  ),
  TabItem(
    icon: Icons.account_box,
    title: 'Profil',
  ),
];

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({
    Key? key,
    required this.camera, required this.userId,
  }) : super(key: key);
  final CameraDescription camera;
  final String userId;
  @override
  // ignore: library_private_types_in_public_api
  _BottomBarPageState createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  final _pageController = PageController(initialPage: 0);

  int visit = 0;
  double height = 30;
  Color colorSelect = const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const Color(0XFF1752FE);
  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      HomePage(
        userId: widget.userId,
        camera: widget.camera,
      ),
       FalPage(userId: widget.userId),
      ProfilePage(camera: widget.camera,userId: widget.userId,)
    ];

    return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        // body: SingleChildScrollView(
        //   padding: const EdgeInsets.symmetric(vertical: 20),
        //   child: Column(
        //     // ignore: prefer_const_literals_to_create_immutables
        //     children: [
        //       // BottomBarFloating(
        //       //   items: items,
        //       //   backgroundColor: bgColor,
        //       //   color: color2,
        //       //   colorSelected: Colors.white,
        //       //   indexSelected: visit,
        //       //   onTap: (int index) => setState(() {
        //       //     visit = index;
        //       //   }),
        //       // ),
        //     ],
        //   ),
        // ),
        bottomNavigationBar: BottomBarInspiredFancy(
          enableShadow: true,
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                spreadRadius: 1,
                color: Colors.grey.withOpacity(.2))
          ],
          items: items,
          backgroundColor: Colors.white,
          color: color,
          colorSelected: colorSelect,
          indexSelected: visit,
          styleIconFooter: StyleIconFooter.dot,
          onTap: (int index) => setState(() {
            visit = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          }),
        ));
  }
}
