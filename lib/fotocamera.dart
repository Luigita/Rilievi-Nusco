import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'main.dart';

class Fotocamera extends StatelessWidget {
  const Fotocamera({
    super.key,
    required Future<void> initializeControllerFuture,
    required CameraController? controller,
    required this.mounted,
    required this.selectedId,
  })  : _initializeControllerFuture = initializeControllerFuture,
        _controller = controller;

  final Future<void> _initializeControllerFuture;
  final CameraController? _controller;
  final bool mounted;
  final int? selectedId;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            // Take the Picture in a try / catch block. If anything goes wrong,
            // catch the error.
            try {
              // Ensure that the camera is initialized.
              await _initializeControllerFuture;

              // Attempt to take a picture and get the file `image`
              // where it was saved.
              final image = await _controller?.takePicture();

              if (!mounted) return;

              //SALVA L'IMMAGINE NELLA GALLERIA
              GallerySaver.saveImage(image!.path, albumName: 'RILIEVI');

              final bytes = await File(image.path).readAsBytes();

              final base64Image = base64Encode(bytes);

              //displayPicture(context, base64Image, selectedId);
              // If the picture was taken, display it on a new screen.
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    id: selectedId,
                    // Pass the automatically generated path to
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
    );
  }
}
