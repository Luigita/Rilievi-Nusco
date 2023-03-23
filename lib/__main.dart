import 'dart:convert';

import 'package:applicazione_prova/mio_database.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:signature/signature.dart';

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//import 'foto.dart';
import '__main.dart';
import 'mio_database.dart';

Future main() async {
  // Avoid errors caused by flutter upgrade.
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    title: 'TITOLO APPLICAZIONE',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      useMaterial3: true,
    ),
    home: InserimentoTesto(title: "Nome Applicazione", camera: firstCamera),
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'HELLO WORLD',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//         useMaterial3: true,
//       ),
//       home: InserimentoTesto(title: "Nome Applicazione"),
//     );
//   }
// }

class InserimentoTesto extends StatefulWidget {
  const InserimentoTesto(
      {super.key, required this.title, required this.camera});

  final CameraDescription camera;
  final String title;

  @override
  _InserimentoTestoState createState() => _InserimentoTestoState();
}

class _InserimentoTestoState extends State<InserimentoTesto> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  int? selectedId;
  //final textController = TextEditingController();

  //DA MODIFICARE PER FARE PIU DI DUE TEXTFIELD//
  List<TextEditingController> textController =
      List.generate(2, (int i) => TextEditingController());

  //controller dell'area di firma (disegno)
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              OutlinedButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DisplayData(),
                      ),
                    );
                  },
                  child: const Text('Dati Salvati')
              ),
            ],
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: Center(
            child: ListView(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              children: [
                //TODO aggiungere gli altri campi da alimentare
                const Text('NOME'),
                TextField(
                  controller: textController[0],
                  // onSubmitted: (String stringa) async{
                  //   await DBHelper.instance.add(
                  //     Operaio(nome: stringa, cognome: 'cognome')
                  //   );
                  // },
                ),
                const Divider(),
                const Text('COGNOME'),
                TextField(
                  controller: textController[1],
                  // onSubmitted: (String stringa) async{
                  //   await DBHelper.instance.add(
                  //     Operaio(nome: stringa, cognome: 'cognome')
                  //   );
                  // },
                ),
                const Divider(),

                ////////////////
                // FOTOCAMERA //
                ////////////////

                Column(
                  children: [
                    FutureBuilder<void>(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return CameraPreview(_controller);
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
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
                          final image = await _controller.takePicture();

                          if (!mounted) return;

                          //SALVA L'IMMAGINE NELLA GALLERIA
                          GallerySaver.saveImage(image.path, albumName: 'RILIEVI');

                          final bytes = await File(image.path).readAsBytes();

                          final base64Image = base64Encode(bytes);

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
                ),
                FutureBuilder<List<Rilievo>>(
                    future: DBHelper.instance.getRilievi(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Rilievo>> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Caricamento...'));
                      }
                      return snapshot.data!.isEmpty
                          ? const Center(child: Text('Nessun operaio in lista'))
                          : Column(
                              children: snapshot.data!.map((operaio) {
                                return Center(
                                  child: Card(
                                    color: selectedId == operaio.id
                                        ? Colors.white70
                                        : Colors.white,
                                    child: ListTile(
                                      title: Text(
                                          operaio.nome! + ' ' + operaio.cognome!),
                                      onTap: () {
                                        setState(() {
                                          if (selectedId == null) {
                                            textController[0].text =
                                                operaio.nome!;
                                            textController[1].text =
                                                operaio.cognome!;
                                            selectedId = operaio.id;
                                          } else {
                                            textController[0].text = '';
                                            textController[1].text = '';
                                            selectedId = null;
                                          }
                                        });
                                      },
                                      onLongPress: () {
                                        setState(() {
                                          DBHelper.instance.remove(operaio.id!);
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                    }),
                Signature(
                  controller: _signatureController,
                  width: 300,
                  height: 300,
                  backgroundColor: Colors.lightBlueAccent,
                )
              ],
            ),
          ),

          //TODO implementare finestra sei sicuro, non refresha lo stato
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.delete_forever),
                  onPressed: () {
                    setState(() {
                      dialogAlertButton(context, textController, selectedId);
                    });
                    },
                ),
              ),
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: FloatingActionButton(
                  child: const Icon(Icons.save),
                  onPressed: () async {
                    selectedId != null
                        ? await DBHelper.instance.update(
                      Rilievo(
                          id: selectedId,
                          nome: textController[0].text,
                          cognome: textController[1].text,
                      ),
                    )
                        : await DBHelper.instance.add(
                            Rilievo(
                                nome: textController[0].text,
                                cognome: textController[1].text),
                          );
                    setState(() {
                      textController[0].clear();
                      textController[1].clear();
                      selectedId = null;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String base64Image;
  final int? id;

  const DisplayPictureScreen(
      {super.key, required this.base64Image, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(base64Image.toString())),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          //Text(imagePath.toString()),
          Image.file(File(base64Image)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          id != null
              ? await DBHelper.instance.update(
            Rilievo(
              id: id,
              blob: base64Image,
            ),
          )
              : await DBHelper.instance.add(
            Rilievo(
              id: id,
              blob: base64Image,
            ),
          );
        },
      ),
    );
  }
}

class DisplayData extends StatelessWidget {
  DisplayData({super.key});

  final operai = DBHelper.instance.getRilievi();

  get selectedId => null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizzazione dati'),
      ),
      body: FutureBuilder<List<Rilievo>>(
          future: DBHelper.instance.getRilievi(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Rilievo>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Caricamento...'));
            }
            return snapshot.data!.isEmpty
                ? const Center(child: Text('Nessun operaio in lista'))
                : Column(
              children: snapshot.data!.map((operaio) {
                return Center(
                  child: Card(
                    color: selectedId == operaio.id
                        ? Colors.white70
                        : Colors.white,
                    child: ListTile(
                      title: Text(
                          operaio.nome! + ' ' + operaio.cognome!),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}

//TODO: disegno tramite signature widget

//class SignatureWidget extends StatefulWidget{}

//TODO: implementare salvataggio database in excel

void dialogAlertButton(context, List<TextEditingController> textController, int? selectedId) {

  @override
     var dialog = SimpleDialog(
      title: const Row(
        children: <Widget>[
          //TODO: CAMBIARE ICONA
          Icon(Icons.error_outline),
          Text(
            "ATTENZIONE",
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.white,
      elevation: 10,
      children: [
        const Text(
          "Stai per eliminare tutti i dati salvati. Continuare?",
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.center,
        ),
        const Divider(
          thickness: 1,
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              child: const Icon(Icons.check),
              onPressed: () async {
                await DBHelper.instance.deleteAll();
                textController[0].clear();
                textController[1].clear();
                selectedId = null;
                Navigator.of(context).pop();
              },
            ),
            FloatingActionButton(
              child: const Icon(Icons.highlight_remove),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            )
          ],
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

