// import 'dart:io';
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:applicazione_prova/rilievo_persiane.dart';
// import 'package:applicazione_prova/rilievo_tapparelle.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// import 'package:share_plus/share_plus.dart';
// import 'package:sqflite/sqflite.dart';

import 'display_data_tapparelle.dart';
import 'nuovo_database.dart';
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
          body: Center(
              child: DisplayDataTapparella(
            camera: widget.camera,
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InserimentoIntestazioneTapparelle()));
              setState(() {});
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

  List<FocusNode> focusNodeList = List.generate(2, (_) => FocusNode());

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
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[0],
                ),
                const Divider(),
                const Text('Cantiere'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[1],
                ),
                const Divider(),
                const Text('Data'),
                TextField(
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2019, 1),
                        lastDate: DateTime(2024, 12),
                      );
                      if (pickedDate != null) {
                        print(pickedDate
                            .toLocal()); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('d/M/y').format(pickedDate);
                        //print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          textController[2].text = formattedDate
                              .toString(); //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  )),
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[2],
                ),
                const Divider(),
                const Text('Tipologia infisso'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[3],
                ),
                const Divider(),
                const Text('Guide'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[4],
                ),
                const Divider(),
                const Text('Colorazione interna'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[5],
                ),
                const Divider(),
                const Text('Colorazione esterna'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[6],
                ),
                const Divider(),
                const Text('Listelli interni'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[7],
                ),
                const Divider(),
                const Text('Listelli esterni'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[8],
                ),
                const Divider(),
                const Text('Larghezza infissi'),
                TextFormField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[9],
                ),
                const Divider(),
                const Text('Altezza infissi'),
                TextFormField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[10],
                ),
                const Divider(),
                const Text('Misure Luce (LxH)'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[11],
                ),
                const Divider(),
                const Text('Tipo Tapparella'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[12],
                ),
                const Divider(),
                const Text('Colore Tapparella'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
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
                          larghezzaInfissi: (textController[9].text),
                          altezzaInfissi: (textController[10].text),
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
                          larghezzaInfissi:(textController[9].text),
                          altezzaInfissi: (textController[10].text),
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
                });
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
