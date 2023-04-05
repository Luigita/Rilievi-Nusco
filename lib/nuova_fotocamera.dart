import 'dart:convert';
// import 'dart:developer';
import 'dart:io';

// import 'package:applicazione_prova/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
// import 'package:signature/signature.dart';
// import 'dart:typed_data';

//import 'mio_database.dart';
import 'nuovo_database.dart';

class Fotocamera extends StatefulWidget{
  Fotocamera({
    super.key,
    required this.cameraDescription,
    //required CameraController? controller,
    required this.mounted,
    required this.selectedId,
    required this.tipoConfigurazione,
  });

  final CameraDescription cameraDescription;
  final bool mounted;
  final int? selectedId;
  final String tipoConfigurazione;

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
    _controller =
        CameraController(widget.cameraDescription, ResolutionPreset.max);
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
                      tipoConfigurazione: widget.tipoConfigurazione,
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

class DisplayPictureScreen extends StatelessWidget {
  final String base64Image;
  final int? id;
  final String tipoConfigurazione;

  const DisplayPictureScreen(
      {super.key,
      required this.base64Image,
      required this.id,
      required this.tipoConfigurazione});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(base64Image.toString())),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          //Text(imagePath.toString()),
          Image.memory(base64Decode(base64Image)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: id == null
            ? const Icon(Icons.save, color: Colors.red)
            : const Icon(Icons.save, color: Colors.white),
        onPressed: () async {
          try {
            Configurazione? configurazione = await DBHelper.instance
                .getConfigurazione(id!, tipoConfigurazione);
            await DBHelper.instance.updateConfigurazione(
                Configurazione(
                  id: id,
                  riferimento: configurazione?.riferimento,
                  quantita: configurazione?.quantita,
                  larghezza: configurazione?.larghezza,
                  altezza: configurazione?.altezza,
                  tipo: configurazione?.tipo,
                  dxsx: configurazione?.dxsx,
                  vetro: configurazione?.vetro,
                  telaio: configurazione?.telaio,
                  larghezzaLuce: configurazione?.larghezzaLuce,
                  altezzaLuce: configurazione?.altezzaLuce,
                  note: configurazione?.note,
                  blob: base64Image,
                  disegno: configurazione?.disegno,
                  idParente: configurazione?.idParente,
                ),
                tipoConfigurazione);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } catch (e) {
            print(e);
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
