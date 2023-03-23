import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:applicazione_prova/fotocamera.dart';
import 'package:applicazione_prova/mio_database.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import 'disegno.dart';

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

class _InserimentoTestoState extends State<InserimentoTesto>
  with WidgetsBindingObserver {

  CameraController? _cameraController;
  late Future<void> _initializeControllerFuture;

  int? selectedId;
  //final textController = TextEditingController();

  //DA MODIFICARE PER FARE PIU DI DUE TEXTFIELD//
  List<TextEditingController> textController =
      List.generate(2, (int i) => TextEditingController());

  // //controller dell'area di firma (disegno)
  // final SignatureController _signatureController = SignatureController(
  //   penStrokeWidth: 3,
  //   penColor: Colors.red,
  //   exportBackgroundColor: Colors.blue,
  // );

  @override
  void dispose() {
    // _signatureController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
        widget.camera, ResolutionPreset.medium
    );
    _initializeControllerFuture = _cameraController!.initialize();
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
              ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DisplayData(
                          initializeControllerFuture:
                            _initializeControllerFuture,
                          mounted: mounted,
                          cameraController: _cameraController,
                          selectedId: selectedId,
                        ),
                      ),
                    );
                  },
                  child: const Text('Dati Salvati')),
            ],
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: Center(
            child: ListView(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              children: [
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
                FutureBuilder<List<Rilievo>>(
                    future: DBHelper.instance.getRilievi(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Rilievo>> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Caricamento...'));
                      }
                      return snapshot.data!.isEmpty
                          ? const Center(child: Text('Lista vuota'))
                          : Column(
                              children: snapshot.data!.map((rilievo) {
                                return Center(
                                  child: Card(
                                    color: selectedId == rilievo.id
                                        ? Colors.white70
                                        : Colors.white,
                                    child: ListTile(
                                      title: Text(
                                          '${rilievo.nome!} ${rilievo.cognome!}'
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (selectedId == null) {
                                            textController[0].text =
                                                rilievo.nome!;
                                            textController[1].text =
                                                rilievo.cognome!;
                                            selectedId = rilievo.id;
                                          } else {
                                            textController[0].text = '';
                                            textController[1].text = '';
                                            selectedId = null;
                                          }
                                        });
                                      },
                                      onLongPress: () {
                                        setState(() {
                                          DBHelper.instance.remove(rilievo.id!);
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                    }),
                // Signature(
                //   controller: _signatureController,
                //   width: 300,
                //   height: 300,
                //   backgroundColor: Colors.lightBlueAccent,
                // )
              ],
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ///TODO: ESPORTAZIONE DATABASE
              FloatingActionButton(
                  onPressed: () {
                    DBHelper.instance.getDatabasePath();
                  }
              ),

              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.delete_forever),
                  onPressed: () {
                    dialogAlertButton(context, textController, selectedId);
                    setState(() {});
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

// void displayPicture(context, String base64Image, int? id) {
//   @override
//   var widget = Scaffold(
//     appBar: AppBar(title: Text(base64Image.toString())),
//     body: Column(
//       children: [
//         Image.memory(base64Decode(base64Image)),
//       ],
//     ),
//     floatingActionButton: FloatingActionButton(onPressed: () async {
//       try {
//         Rilievo? rilievo = await DBHelper.instance.getRilievo(id!);
//
//         id != null
//             ? await DBHelper.instance.update(
//                 Rilievo(
//                   id: id,
//                   nome: rilievo?.nome,
//                   cognome: rilievo?.cognome,
//                   blob: base64Image,
//                 ),
//               )
//             : await DBHelper.instance.update(
//                 Rilievo(
//                   id: id,
//                   nome: rilievo?.nome,
//                   cognome: rilievo?.cognome,
//                   blob: base64Image,
//                 ),
//               );
//         Navigator.of(context).pop();
//       } catch (e) {
//         print(e);
//       }
//     }),
//   );
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return widget;
//       });
//   //restituisce la stringa base64 dell'immagine
// }

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
          Image.memory(base64Decode(base64Image)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: id == null
            ? const Icon(Icons.save, color: Colors.red)
            : const Icon(Icons.save, color: Colors.white),
        onPressed: () async {
          try {
            Rilievo? rilievo = await DBHelper.instance.getRilievo(id!);

            id != null
                ? await DBHelper.instance.update(
                    Rilievo(
                      id: id,
                      nome: rilievo?.nome,
                      cognome: rilievo?.cognome,
                      blob: base64Image,
                      disegno: rilievo?.disegno,
                    ),
                  )
                : await DBHelper.instance.update(
                    Rilievo(
                      id: id,
                      nome: rilievo?.nome,
                      cognome: rilievo?.cognome,
                      blob: base64Image,
                      disegno: rilievo?.disegno,
                    ),
                  );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } catch (e) {
            print(e);
            Navigator.of(context).pop();
            // TODO
          }
        },
      ),
    );
  }
}

class DisplayData extends StatelessWidget {

  DisplayData({
    super.key,
    required Future<void> initializeControllerFuture,
    required CameraController? cameraController,
    required this.mounted,
    required this.selectedId,
  })  : _initializeControllerFuture = initializeControllerFuture,
        _cameraController = cameraController;

  final Future<void> _initializeControllerFuture;
  final CameraController? _cameraController;
  final bool mounted;
  final int? selectedId;

  final rilievi = DBHelper.instance.getRilievi();

  //get selectedId => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButtonAnimator: NoScalingAnimation(),
      appBar: AppBar(
        title: const Text('Visualizzazione dati'),
      ),
      body: FutureBuilder<List<Rilievo>>(
          future: DBHelper.instance.getRilievi(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Rilievo>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Caricamento...'));
            }
            return snapshot.data!.isEmpty
                ? const Center(child: Text('Lista vuota'))
                : ListView(
                    children: snapshot.data!.map((rilievo) {
                      return Card(
                        color: Colors.white70,
                        child: ListTile(
                          //contentPadding: const EdgeInsets.all(20.0),
                          title: Text('${rilievo.nome!} ${rilievo.cognome!}'),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                // heroTag: null,
                                // mini: true,
                                onPressed: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Disegno(id: rilievo.id)
                                      //     Fotocamera(
                                      //   initializeControllerFuture:
                                      //     _initializeControllerFuture,
                                      //   mounted: mounted,
                                      //   selectedId: rilievo.id,
                                      //   controller: _cameraController,
                                      // ),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.draw),
                              ),
                              const VerticalDivider(
                                thickness: null,
                              ),
                              ElevatedButton(
                                // heroTag: null,
                                // mini: true,
                                onPressed: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Fotocamera(
                                        initializeControllerFuture:
                                          _initializeControllerFuture,
                                        mounted: mounted,
                                        selectedId: rilievo.id,
                                        controller: _cameraController,
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.add_a_photo),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
          }),
    );
  }
}

//class SignatureWidget extends StatefulWidget{}

void dialogAlertButton(
    context, List<TextEditingController> textController, int? selectedId) {
  @override
  var dialog = SimpleDialog(
    title: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning),
            Text(
              "ATTENZIONE",
            ),
            Icon(Icons.warning),
          ],
        ),
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

// //blocca l'animazione di un floating action button
// class NoScalingAnimation extends FloatingActionButtonAnimator{
//   late double _x;
//   late double _y;
//
//   @override
//   Offset getOffset({
//         required Offset begin,
//         required Offset end,
//         required double progress
//       }) {
//     _x = begin.dx +(end.dx - begin.dx)*progress ;
//     _y = begin.dy +(end.dy - begin.dy)*progress;
//     return Offset(_x,_y);
//   }
//
//   @override
//   Animation<double> getRotationAnimation({required Animation<double> parent}) {
//     return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
//   }
//
//   @override
//   Animation<double> getScaleAnimation({required Animation<double> parent}) {
//     return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
//   }
// }
