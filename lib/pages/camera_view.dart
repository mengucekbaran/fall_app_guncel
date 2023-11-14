// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'dart:async';

import 'package:fall_app/const/colors.dart';
import 'package:fall_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'fal_setting.view.dart';

String imagePa = "";

class CameraExampleHome extends StatefulWidget {
  final CameraDescription camera;
  final FalTuru falTuru;
  final String userId;


  const CameraExampleHome({
    Key? key,
    required this.camera, required this.falTuru, required this.userId, 
  }) : super(key: key);

  @override
  _CameraExampleHomeState createState() => _CameraExampleHomeState();
}

class _CameraExampleHomeState extends State<CameraExampleHome> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.max,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  AspectRatio(
                    aspectRatio: .5028,
                    child: CameraPreview(_controller),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: colorPurple,
          child: const Icon(Icons.camera_alt),
          onPressed: () async {
            try {
              await _initializeControllerFuture;

              final image = await _controller.takePicture();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FalSetting(
                    imagePath: image.path,
                    camera: widget.camera,
                    falTuru: widget.falTuru,
                    userId: widget.userId,
                  ),
                ),
              );
            } catch (e) {
              print(e);
            }
          },
        ),
      ),
    );
  }
}
