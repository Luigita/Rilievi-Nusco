// import 'dart:io';
import 'dart:async';

// import 'dart:convert';

// import 'package:applicazione_prova/display_data_tapparelle.dart';
import 'package:applicazione_prova/rilievo_persiane.dart';
import 'package:applicazione_prova/rilievo_tapparelle.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:share_plus/share_plus.dart';

// import 'package:sqflite/sqflite.dart';

import 'package:google_fonts/google_fonts.dart';

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

  runApp(MaterialApp(
    title: 'Rilievi Nusco',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      useMaterial3: true,
    ),
    home: SelezionaModulo(camera: firstCamera),
  ));
}

class SelezionaModulo extends StatelessWidget {
  //final String title;

  const SelezionaModulo({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.share),
              onPressed: () async {
                await DBHelper.instance.exportDatabase();
                // // Future<void> shareFile() async {
                // //   List<dynamic> docs = await DBHelper.instance.getDatabasePath();
                // //   if (docs == null || docs.isEmpty) return null;
                // Share.shareXFiles(
                //   [XFile(await DBHelper.instance.getDatabasePath())],
                // );
                // // dbExportSql(DBHelper.instance.getDatabase()!);
                // // Share.shareXFiles(
                // //   [XFile(dbExportSql(DBHelper.instance.getDatabase()!))],
                // // );
              }),
          appBar: AppBar(
              leading: ElevatedButton(
                child: const Icon(Icons.delete_forever),
                onPressed: () async {
                  dialogAlertButton(context);
                },
                // child: const Icon(Icons.share),
                // onPressed:() async {
                //   // Future<void> shareFile() async {
                //   //   List<dynamic> docs = await DBHelper.instance.getDatabasePath();
                //   //   if (docs == null || docs.isEmpty) return null;
                //
                //
                //   Share.shareXFiles(
                //     [XFile(await DBHelper.instance.getDatabasePath())],
                //   );
                //   // dbExportSql(DBHelper.instance.getDatabase()!);
                //   // Share.shareXFiles(
                //   //   [XFile(dbExportSql(DBHelper.instance.getDatabase()!))],
                //   // );
                // } ,
              ),
              title: Text('Rilievi Nusco',
                  style: GoogleFonts.titilliumWeb(
                      fontWeight: FontWeight.w700, fontSize: 30))),
          body: Center(
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
                                camera: camera,
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
                              image: AssetImage("assets/images/Cattura.PNG"),
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
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RilievoTapparelle(
                                camera: camera,
                              )));
                    })
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
