// import 'dart:io';
// import 'dart:async';
// import 'dart:convert';

import 'package:applicazione_prova/nuovo_database.dart';
// import 'package:applicazione_prova/rilievo_persiane.dart';
// import 'package:applicazione_prova/rilievo_tapparelle.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:sqflite/sqflite.dart';


import 'display_data_tapparelle.dart';
// import 'fotocamera.dart';
// import 'disegno.dart';

class RilievoTapparelle extends StatefulWidget {
  const RilievoTapparelle({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<RilievoTapparelle> createState() => _RilievoTapparelleState();
}

class _RilievoTapparelleState extends State<RilievoTapparelle>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          //appBar: AppBar(title: const Text('Dati salvati')),
          body: Center(child: DisplayDataTapparella(
            camera: widget.camera,
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InserimentoIntestazioneTapparelle()));
              setState(() {
              });
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class InserimentoIntestazioneTapparelle extends StatefulWidget {
  const InserimentoIntestazioneTapparelle({super.key});

  @override
  InserimentoIntestazioneTapparelleState createState() =>
      InserimentoIntestazioneTapparelleState();
}

class InserimentoIntestazioneTapparelleState
    extends State<InserimentoIntestazioneTapparelle>
    with WidgetsBindingObserver {
  int? selectedId;

  List<TextEditingController> textController =
      List.generate(14, (int i) => TextEditingController());

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
            title: const Text('Inserimento intestazione tapparelle'),
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
                const Text('Cantiere'),
                TextField(
                  controller: textController[1],
                ),
                const Divider(),
                const Text('Data'),
                TextField(
                  controller: textController[2],
                ),
                const Divider(),
                const Text('Tipologia infisso'),
                TextField(
                  controller: textController[3],
                ),
                const Divider(),
                const Text('Guide'),
                TextField(
                  controller: textController[4],
                ),
                const Divider(),
                const Text('Colorazione interna'),
                TextField(
                  controller: textController[5],
                ),
                const Divider(),
                const Text('Colorazione esterna'),
                TextField(
                  controller: textController[6],
                ),
                const Divider(),
                const Text('Listelli interni'),
                TextField(
                  controller: textController[7],
                ),
                const Divider(),
                const Text('Listelli esterni'),
                TextField(
                  controller: textController[8],
                ),
                const Divider(),
                const Text('Larghezza infissi'),
                TextFormField(
                  validator: (value) {
                    if (value == null ||
                        double.tryParse(value) == null ||
                        value.isEmpty) {
                      return 'Inserire un valore corretto es: 10.2';
                    }
                    return null;
                  },
                  controller: textController[9],
                ),
                const Divider(),
                const Text('Altezza infissi'),
                TextFormField(
                  //onFieldSubmitted: ,
                  validator: (value) {
                    if (value == null ||
                        double.tryParse(value) == null ||
                        value.isEmpty) {
                      return 'Inserire un valore corretto es: 10.2';
                    }
                    return null;
                  },
                  controller: textController[10],
                ),
                const Divider(),
                const Text('Misure Luce (LxH)'),
                TextField(
                  controller: textController[11],
                ),
                const Divider(),
                const Text('Tipo Tapparella'),
                TextField(
                  controller: textController[12],
                ),
                const Divider(),
                const Text('Colore Tapparella'),
                TextField(
                  controller: textController[13],
                ),
                const Divider(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                selectedId != null
                    ? await DBHelper.instance.updateTapparella(
                        RilievoTapparella(
                          id: selectedId,
                          cliente: textController[0].text,
                          cantiere: textController[1].text,
                          data: textController[2].text,
                          tipologiaInfisso: textController[3].text,
                          guide: textController[4].text,
                          colorazioneInt: textController[5].text,
                          colorazioneEst: textController[6].text,
                          listelliInt: textController[7].text,
                          listelliEst: textController[8].text,
                          larghezzaInfissi:
                              double.parse(textController[9].text),
                          altezzaInfissi: double.parse(textController[10].text),
                          misureLuce: textController[11].text,
                          tipoTapparella: textController[12].text,
                          coloreTapparella: textController[13].text,
                        ),
                      )
                    : await DBHelper.instance.addTapparella(
                        RilievoTapparella(
                          cliente: textController[0].text,
                          cantiere: textController[1].text,
                          data: textController[2].text,
                          tipologiaInfisso: textController[3].text,
                          guide: textController[4].text,
                          colorazioneInt: textController[5].text,
                          colorazioneEst: textController[6].text,
                          listelliInt: textController[7].text,
                          listelliEst: textController[8].text,
                          larghezzaInfissi:
                              double.parse(textController[9].text),
                          altezzaInfissi: double.parse(textController[10].text),
                          misureLuce: textController[11].text,
                          tipoTapparella: textController[12].text,
                          coloreTapparella: textController[13].text,
                        ),
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
                  textController[8].clear();
                  textController[9].clear();
                  textController[10].clear();
                  textController[11].clear();
                  textController[12].clear();
                  textController[13].clear();
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
