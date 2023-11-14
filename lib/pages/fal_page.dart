// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fall_app/const/colors.dart';
import 'package:fall_app/pages/login_view.dart';
import 'package:fall_app/pages/photo_view.dart';
import 'package:fall_app/services/api_service.dart';
import 'package:flutter/material.dart';


import '../services/assets_manager.dart';
import '../services/fal_service.dart';
// import 'package:kartal/kartal.dart';

class FalPage extends StatelessWidget {
  final String userId;
  const FalPage({Key? key, required this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fallarım',style: TextStyle(color: colorPurple),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
        .collection('fallar')
        .where("user_id", isEqualTo: userId)
        .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      
          List<Fal> fallar =
              snapshot.data!.docs.map((doc) => Fal.fromFirestore(doc)).toList();
      
          return ListView.builder(
            itemCount: fallar.length,
            itemBuilder: (context, index) {
              Fal fal = fallar[index];
      
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          8), // Kenarlık yuvarlaklığını ayarlayın
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          8), // Kenarlık yuvarlaklığını ayarlayın
                      child: 
                      // Image.asset(AssetsManager.logoImage,fit: BoxFit.cover,)
                      Image.file(
                        File(fal.fal_photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    fal.fal_turu,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 16),
                  ),
                  trailing: IconButton(
                    onPressed: () {try {
                        if (fal.fal_photo == "") {
                        print("Object is empty");
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(
                              falId: fal.fal_id,
                              imagePath: fal.fal_photo,
                              falText: ApiService.fal,
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      if (fal.fal_photo == "") {
                        print("Object is empty");
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(
                              falId: AssetsManager.logoImage ,
                              imagePath: fal.fal_photo,
                              falText: ApiService.fal,
                            ),
                          ),
                        );
                      }
                    }
                      
                    },
                    icon: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
