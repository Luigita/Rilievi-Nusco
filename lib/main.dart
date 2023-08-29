// import 'dart:io';
import 'dart:async';

// import 'dart:convert';

// import 'package:applicazione_prova/display_data_tapparelle.dart';
import 'package:applicazione_prova/display_data_persiane.dart';
import 'package:applicazione_prova/rilievo_persiane.dart';
import 'package:applicazione_prova/rilievo_tapparelle.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

import 'package:in_app_update/in_app_update.dart';
//import 'package:share_plus/share_plus.dart';

// import 'package:sqflite/sqflite.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

import 'nuovo_database.dart';
// import 'fotocamera.dart';
// import 'disegno.dart';

// initFotocamera() async {
//   final cameras = await availableCameras();
//   final firstCamera = cameras.first;
//   return firstCamera;
// }

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  //await Upgrader.clearSavedSettings();

  runApp(MaterialApp(

    //TODO: CREARE ROUTES E PROVARE A FARE NAVIGATOR PUSH E POP CON I NOMI DELLE ROUTES Navigator.popUntil(context, ModalRoute.withName('/scrren'));

    title: 'Rilievi Nusco',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      useMaterial3: true,
    ),
    home: SelezionaModulo(camera: firstCamera),
  ));
}

class SelezionaModulo extends StatefulWidget {
  //final String title;

  const SelezionaModulo({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<SelezionaModulo> createState() => _SelezionaModuloState();
}

class _SelezionaModuloState extends State<SelezionaModulo> {
  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  //bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    checkForUpdate();
    _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable
        ? () {
            InAppUpdate.performImmediateUpdate()
                .catchError((e) => showSnack(e.toString()));
          }
        : null;

    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: _scaffoldKey,
          // floatingActionButton: FloatingActionButton(
          //     child: const Icon(Icons.share),
          //     onPressed: () async {
          //       await DBHelper.instance.exportDatabase();
          //     }),
          appBar: AppBar(
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 0,
                        child: Row(
                          children: [
                            Text("Elimina dati "),
                            Icon(
                              Icons.delete_forever,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Text("Condividi "),
                              Icon(Icons.share, color: Colors.black)
                            ],
                          )),
                      PopupMenuItem(child: Text("Update info: $_updateInfo"))
                    ];
                  },
                  onSelected: (value) async {
                    if (value == 0) {
                      dialogAlertButton(context);
                    } else if (value == 1) {
                      await DBHelper.instance.exportDatabase();
                    }
                  },
                ),
              ],
              // leading: ElevatedButton(
              //   child: const Icon(Icons.delete_forever),
              //   onPressed: () async {
              //     dialogAlertButton(context);
              //   },
              // ),
              title: Text('Rilievi Nusco',
                  style: GoogleFonts.titilliumWeb(
                      fontWeight: FontWeight.w700, fontSize: 34))
          ),
          body: Center(
            // Column(
            //   children: <Widget>[
            //     Center(
            //       child: Text('Update info: $_updateInfo'),
            //     ),
            //
            //     ElevatedButton(
            //       child: Text('Perform immediate update'),
            //       onPressed: _updateInfo?.updateAvailability ==
            //           UpdateAvailability.updateAvailable
            //           ? () {
            //         InAppUpdate.performImmediateUpdate()
            //             .catchError((e) => showSnack(e.toString()));
            //       }
            //           : null,
            //     ),
            //   ],
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => RilievoTapparelle(
                //                 camera: camera,
                //               )));
                //     },
                //     child: const Text('Modulo tapparelle')),
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => RilievoPersiane(
                //                 camera: camera,
                //               )));
                //     },
                //     child: const Text(' Modulo persiane ')),
                GestureDetector(
                    child: Container(
                        width: 170,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.5),
                          color: Colors.black,
                          image: const DecorationImage(
                              image:
                                  AssetImage("assets/images/PersianaIron.jpg"),
                              fit: BoxFit.fill),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.cyan,
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.black, width: 0.5))),
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "Modulo persiane",
                            style: GoogleFonts.openSans(fontSize: 16),
                          ),
                        )),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RilievoPersiane(
                                camera: widget.camera,
                              )));
                    }),
                GestureDetector(
                    child: Container(
                        width: 170,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.5),
                          color: Colors.black,
                          image: const DecorationImage(
                              image: AssetImage("assets/images/Tapparella.PNG"),
                              fit: BoxFit.fill),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.cyan,
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.black, width: 0.5))),
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "Modulo tapparelle",
                            style: GoogleFonts.openSans(fontSize: 16),
                          ),
                        )),
                    ///************************///
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => RilievoTapparelle(
                                camera: widget.camera,
                              )));
                    }
                    ///*************************///
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void dialogAlertButton(context) {
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
              await DBHelper.instance.deleteTableContent('tapparelle');
              await DBHelper.instance
                  .deleteTableContent('configurazioneTapparelle');
              await DBHelper.instance.deleteTableContent('persiane');
              await DBHelper.instance
                  .deleteTableContent('configurazionePersiane');
              Navigator.of(context).pop();
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.highlight_remove),
            onPressed: () {
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
