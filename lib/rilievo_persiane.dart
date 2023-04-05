// import 'dart:io';
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:applicazione_prova/rilievo_persiane.dart';
// import 'package:applicazione_prova/rilievo_tapparelle.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:sqflite/sqflite.dart';

import 'display_data_persiane.dart';
import 'nuovo_database.dart';
// import 'fotocamera.dart';
// import 'disegno.dart';

class RilievoPersiane extends StatefulWidget {
  const RilievoPersiane({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<RilievoPersiane> createState() => _RilievoPersianeState();
}

class _RilievoPersianeState extends State<RilievoPersiane>
  with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: Center(child: DisplayDataPersiana(
            camera: widget.camera,
          )),
          floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(builder: (context) => InserimentoIntestazionePersiane()));
              },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class InserimentoIntestazionePersiane extends StatefulWidget {
  const InserimentoIntestazionePersiane({super.key});

  @override
  InserimentoIntestazionePersianeState createState() =>
      InserimentoIntestazionePersianeState();
}

class InserimentoIntestazionePersianeState
  extends State<InserimentoIntestazionePersiane>
  with WidgetsBindingObserver {

  int? selectedId;

  List<TextEditingController> textController =
      List.generate(8, (int i) => TextEditingController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Insermento intestazione persiane'),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              children: [
                const Text('Cliente'),
                TextField(
                  controller: textController[0],
                ),
                const Divider(),
                const Text('Destinazione'),
                TextField(
                  controller: textController[1],
                ),
                const Divider(),
                const Text('Data'),
                TextField(
                  controller: textController[2],
                ),
                const Divider(),
                const Text('Modello porta'),
                TextField(
                  controller: textController[3],
                ),
                const Divider(),
                const Text('Modello maniglia'),
                TextField(
                  controller: textController[4],
                ),
                const Divider(),
                const Text('Finitura interna'),
                TextField(
                  controller: textController[5],
                ),
                const Divider(),
                const Text('Commerciale'),
                TextField(
                  controller: textController[6],
                ),
                const Divider(),
                const Text('Ferramenta'),
                TextField(
                  controller: textController[7],
                ),
                const Divider(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if(_formKey.currentState!.validate()) {
                  selectedId != null
                      ? await DBHelper.instance.updatePersiana(
                    RilievoPersiana(
                      id: selectedId,
                      cliente: textController[0].text,
                      destinazione: textController[1].text,
                      data: textController[2].text,
                      modelloPorta: textController[3].text,
                      modelloManiglia: textController[4].text,
                      finituraInterna: textController[5].text,
                      commerciale: textController[6].text,
                      ferramenta: textController[7].text,
                    ),
                  )
                      : await DBHelper.instance.addPersiana(
                    RilievoPersiana(
                      cliente: textController[0].text,
                      destinazione: textController[1].text,
                      data: textController[2].text,
                      modelloPorta: textController[3].text,
                      modelloManiglia: textController[4].text,
                      finituraInterna: textController[5].text,
                      commerciale: textController[6].text,
                      ferramenta: textController[7].text,
                    )
                  );
                  setState(() {
                    textController[0].clear();
                    textController[1].clear();
                    textController[2].clear();
                    textController[3].clear();
                    textController[4].clear();
                    textController[5].clear();
                    textController[6].clear();
                    textController[7].clear();
                    selectedId = null;
                  }
                  );
                  Navigator.of(context).pop();
                }
              },
            child: const Icon(Icons.save),
          ),
        ),
      ),
    );
  }
}