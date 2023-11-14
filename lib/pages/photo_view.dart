// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fall_app/services/api_service.dart';
import 'package:flutter/material.dart';

import '../const/Padding.dart';
import '../services/fal_service.dart';
import '../services/fetching_fals_with_id.dart';
class DisplayPictureScreen extends StatelessWidget {
  const DisplayPictureScreen({Key? key, required this.imagePath, this.falText, required this.falId})
      : super(key: key);
  final String? falText;
  final String falId;
  final String imagePath;
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
        title:  Text("Fal Sonucunuz"),
      ),
      body: 
      FutureBuilder<Fal?>(
        future: getFalDataByFalId(falId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('Fal not found.'),
            );
          }

          Fal fal = snapshot.data!;

          return SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .23,
                    width: MediaQuery.of(context).size.width * .3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.file(
                        File(fal.fal_photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      fal.fal_turu,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Text(
                  fal.fal_icerik ,
                  // ?? "${fal.fal_turu}nıza bakılıyor",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                ),
                // const LinkFashinWidget(
                //   image:
                //       "https://cdn.dsmcdn.com/ty574/product/media/images/20221022/7/199601941/603053150/1/1_org_zoom.jpg",
                //   url:
                //       "https://www.trendyol.com/mavi/logo-baskili-sweatshirt-oversize-genis-kesim-1600361-70722-p-373159434?boutiqueId=61&merchantId=63",
                // ),
              ],
            ),
          ),
        ),
      );
        },
      ),
      // SafeArea(
      //   child: Padding(
      //     padding: EdgeInsets.all(20),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Center(
      //             child: SizedBox(
      //               height: MediaQuery.of(context).size.height * .23,
      //               width: MediaQuery.of(context).size.width * .3,
      //               child: ClipRRect(
      //                 borderRadius: const BorderRadius.all(Radius.circular(10)),
      //                 child: Image.file(
      //                   File(imagePath),
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             height: MediaQuery.of(context).size.height * .02,
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 "El Falın",
      //                 style: Theme.of(context).textTheme.titleMedium
      //                     ?.copyWith(fontWeight: FontWeight.w500),
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: MediaQuery.of(context).size.height * .01,
      //           ),
      //           Text(
      //             falText ?? "El falınıza bakılıyor",
      //             style: Theme.of(context).textTheme.titleMedium?.copyWith(),
      //           ),
      //           // const LinkFashinWidget(
      //           //   image:
      //           //       "https://cdn.dsmcdn.com/ty574/product/media/images/20221022/7/199601941/603053150/1/1_org_zoom.jpg",
      //           //   url:
      //           //       "https://www.trendyol.com/mavi/logo-baskili-sweatshirt-oversize-genis-kesim-1600361-70722-p-373159434?boutiqueId=61&merchantId=63",
      //           // ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

class LinkFashinWidget extends StatelessWidget {
  const LinkFashinWidget({
    Key? key,
    required this.image,
    required this.url,
  }) : super(key: key);
  final String image;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                color: Colors.grey.withOpacity(.2))
          ]),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 4,
            width: MediaQuery.of(context).size.width / 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    width: 4, color: const Color.fromARGB(56, 255, 255, 255)),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overflow: TextOverflow.fade,
                "title",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                overflow: TextOverflow.fade,
                "Açıklama",
                style:
                    Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              // CustomButton(
              //   sizeWidth: 230,
              //   title: "Ürün Linki",
              //   onPressed: () async {
              //     launchUrl(Uri.parse(url));
              //   },
              // )
            ],
          ),
          // Row(
          //   children: [
          //     Text(
          //       overflow: TextOverflow.fade,
          //       "title",
          //       style: context.textTheme.labelMedium,
          //     ),
          //     const Spacer(),
          //     const Icon(
          //       Icons.star,
          //       color: Colors.deepOrangeAccent,
          //     ),
          //     Text(
          //       "degere",
          //       style: context.textTheme.labelSmall,
          //     ),
          //   ],
          // ),
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Text(
          //     maxLines: 2,
          //     "desc",
          //     style: context.textTheme.labelSmall
          //         ?.copyWith(color: Colors.grey),
          //   ),
          // ),
          // CustomButton(
          //   title: "Ürün Linki",
          //   onPressed: () async {
          //     if (await canLaunch(
          //       "https://www.trendyol.com/mavi/logo-baskili-sweatshirt-oversize-genis-kesim-1600361-70722-p-373159434?boutiqueId=61&merchantId=63",
          //     )) {
          //       await launch(
          //         "https://www.trendyol.com/mavi/logo-baskili-sweatshirt-oversize-genis-kesim-1600361-70722-p-373159434?boutiqueId=61&merchantId=63",
          //       );
          //     } else {}
          //   },
          // )
        ],
      ),
    );
  }
}
