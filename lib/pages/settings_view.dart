import 'package:fall_app/pages/profil_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/Padding.dart';
import '../services/assets_manager.dart';

class SettingsView extends StatefulWidget {
  SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // açık tema
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
        title: Text(
          "Ayarlar",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 78),
          child: Column(
            children: [
              Padding(
                padding: PaddingApp.paddingLargeTop,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _setTitle(context, "Hesap"),
                    Padding(
                      padding: PaddingApp.paddingTop,
                      child: CustomListTileWidget(
                          leading: Image.asset(
                            AssetsManager.logoImage,
                            width: 25,
                            height: 25,
                          ),
                          title: "Falcınız - Kahve & El Falınız Premium",
                          trailing: _rightIcon(),
                          onTap: () {
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(
                              title: Text('Yakında Gelecek'),
                              content: Text('Bu özellik yakında eklenecektir.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                            },);
                            
                          }),
                    ),
                    CustomListTileWidget(
                        leading: const Icon(Icons.help_center),
                        title: "Yardım Merkezi",
                        trailing: _rightIcon(),
                        onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Icon _rightIcon() => const Icon(Icons.chevron_right_outlined);
Text _setTitle(BuildContext context, String title) => Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
    );
