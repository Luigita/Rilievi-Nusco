// import 'dart:io';
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:applicazione_prova/rilievo_persiane.dart';
// import 'package:applicazione_prova/rilievo_tapparelle.dart';
import 'package:applicazione_prova/dropdown.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// import 'package:share_plus/share_plus.dart';
// import 'package:sqflite/sqflite.dart';

import 'display_data_tapparelle.dart';
import 'nuovo_database.dart';
// import 'fotocamera.dart';
// import 'disegno.dart';

String tipoGuidaTapparelle = "";
String tipoColoreIntTapparelle = "";
String tipoColoreEstTapparelle = "";
String tipoListelliIntTapparelle = "";
String tipoListelliEstTapparelle = "";
String tipoTapparellaTapparelle = "";
String coloreTapparellaTapparelle = "";

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
            title: const Text('Testata tapparelle'),
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
                        // print(pickedDate
                        //     .toLocal()); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('d/M/y').format(pickedDate);
                        //print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          textController[2].text = formattedDate
                              .toString(); //set output date to TextField value.
                        });
                      } else {
                        if (kDebugMode) {
                          print("Date is not selected");
                        }
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
                Dropdown(variabile: tipoGuidaTapparelle, stringa: "tipoGuidaTapparelle", condizione: "guida"),
                const Text('Colorazione interna'),
                Dropdown(variabile: tipoColoreIntTapparelle, stringa: "tipoColoreIntTapparelle", condizione: "colore_int"),
                const Divider(),
                const Text('Colorazione esterna'),
                Dropdown(variabile: tipoColoreEstTapparelle, stringa: "tipoColoreEstTapparelle", condizione: "colore_est"),
                const Divider(),
                const Text('Listelli interni'),
                Dropdown(variabile: tipoListelliIntTapparelle, stringa: "tipoListelliIntTapparelle", condizione: "listelli_int"),
                const Divider(),
                const Text('Listelli esterni'),
                Dropdown(variabile: tipoListelliEstTapparelle, stringa: "tipoListelliEstTapparelle", condizione: "listelli_est"),
                const Divider(),
                const Text('Riferimento misura infissi (L)'),
                TextFormField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[9],
                ),
                const Divider(),
                const Text('Riferimento misura infissi (H)'),
                TextFormField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[10],
                ),
                const Divider(),
                const Text('Riferimento misure luce'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[11],
                ),
                const Divider(),
                const Text('Tipo Tapparella'),
                Dropdown(variabile: tipoTapparellaTapparelle, stringa: "tipoTapparellaTapparelle", condizione: "tipo_tapparella"),
                const Divider(),
                const Text('Colore Tapparella'),
                Dropdown(variabile: coloreTapparellaTapparelle, stringa: "coloreTapparellaTapparelle", condizione: "colore_tapparella"),
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
                          guide: tipoGuidaTapparelle,
                          colorazioneInt: tipoColoreIntTapparelle,
                          colorazioneEst: tipoColoreEstTapparelle,
                          listelliInt: tipoListelliIntTapparelle,
                          listelliEst: tipoListelliEstTapparelle,
                          larghezzaInfissi: (textController[9].text),
                          altezzaInfissi: (textController[10].text),
                          misureLuce: textController[11].text,
                          tipoTapparella: tipoTapparellaTapparelle,
                          coloreTapparella: coloreTapparellaTapparelle,
                        ),
                      )
                    : await DBHelper.instance.addTapparella(
                        RilievoTapparella(
                          cliente: textController[0].text,
                          cantiere: textController[1].text,
                          data: textController[2].text,
                          tipologiaInfisso: textController[3].text,
                          guide: tipoGuidaTapparelle,
                          colorazioneInt: tipoColoreIntTapparelle,
                          colorazioneEst: tipoColoreEstTapparelle,
                          listelliInt: tipoListelliIntTapparelle,
                          listelliEst: tipoListelliEstTapparelle,
                          larghezzaInfissi: (textController[9].text),
                          altezzaInfissi: (textController[10].text),
                          misureLuce: textController[11].text,
                          tipoTapparella: tipoTapparellaTapparelle,
                          coloreTapparella: coloreTapparellaTapparelle,
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
