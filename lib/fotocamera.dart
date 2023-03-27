import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'main.dart';

///TODO: FARE FOTOCAMERA UNO STATEFUL WIDGET E SPOSTARE initState(E FORSE PURE IL DISPOSE) DAL MAIN A QUA PER FAR AVVIARE LA FOTOCAMERA NON ALLA PRIMA SCHERMATA

class Fotocamera extends StatefulWidget {
  const Fotocamera({
    super.key,
    required this.cameraDescription,
    //required Future<void> initializeControllerFuture,
    required CameraController? controller,
    required this.mounted,
    required this.selectedId,
  });  //: //_initializeControllerFuture = initializeControllerFuture,
        //_controller = controller;

  final CameraDescription cameraDescription;

  final bool mounted;
  final int? selectedId;

  @override
  State<Fotocamera> createState() => _FotocameraState();
}

class _FotocameraState extends State<Fotocamera> {

  //CameraController? _cameraController;
  late Future<void> _initializeControllerFuture;
  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller = CameraController(
        widget.cameraDescription, ResolutionPreset.medium
    );
    _initializeControllerFuture = _controller!.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller!);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          FloatingActionButton(
            // Provide an onPressed callback.
            onPressed: () async {
              // Take the Picture in a try/catch block. If anything goes wrong,
              // catch the error.
              try {
                // Ensure that the camera is initialized.
                await _initializeControllerFuture;

                // Attempt to take a picture and get the file `image`
                // where it was saved.
                final image = await _controller?.takePicture();

                if (!widget.mounted) return;

                //SALVA L'IMMAGINE NELLA GALLERIA
                GallerySaver.saveImage(image!.path, albumName: 'RILIEVI');

                final bytes = await File(image.path).readAsBytes();

                final base64Image = base64Encode(bytes);

                //displayPicture(context, base64Image, selectedId);
                // If the picture was taken, display it on a new screen.
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(
                      id: widget.selectedId,
                      // Pass the base64 string to
                      // the DisplayPictureScreen widget.
                      base64Image: base64Image,
                    ),
                  ),
                );
              } catch (e) {
                // If an error occurs, log the error to the console.
                print(e);
              }
            },
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
