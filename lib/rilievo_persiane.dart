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

import 'display_data_persiane.dart';
import 'nuovo_database.dart';
// import 'fotocamera.dart';
// import 'disegno.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

String finituraInterna = "";
String finituraEsterna = "";
String modelloPersiana = "";
String colorazionePersianaInt = "";
String colorazionePersianaEst = "";
String controtelaio = "";

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
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: Center(
              child: DisplayDataPersiana(
            camera: widget.camera,
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InserimentoIntestazionePersiane()));
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class InserimentoIntestazionePersiane extends StatefulWidget {
  const InserimentoIntestazionePersiane({
    super.key,
  });

  @override
  InserimentoIntestazionePersianeState createState() =>
      InserimentoIntestazionePersianeState();
}

class InserimentoIntestazionePersianeState
    extends State<InserimentoIntestazionePersiane> with WidgetsBindingObserver {
  int? selectedId;

  List<TextEditingController> textController =
      List.generate(14, (int i) => TextEditingController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Testata persiane'),
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
                const Text('Destinazione'),
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
                        lastDate: DateTime(2099, 12),
                      );
                      if (pickedDate != null) {
                        //print(pickedDate.toLocal());  //pickedDate output format => 2021-03-10 00:00:00.000
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
                const Text('Tipologia Infisso'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[3],
                ),
                const Divider(),
                const Text('Finitura Interna'),
                Dropdown(
                    variabile: finituraInterna,
                    stringa: "finituraInterna",
                    condizione: "finituraInterna"),
                const Divider(),
                const Text('Finitura Esterna'),
                Dropdown(
                    variabile: finituraEsterna,
                    stringa: "finituraEsterna",
                    condizione: "finituraEsterna"),
                const Divider(),
                const Text('Modello Persiana'),
                Dropdown(
                    variabile: modelloPersiana,
                    stringa: "modelloPersiana",
                    condizione: "modelloPersiana"),
                const Divider(),
                const Text('Colorazione Persiana Interna'),
                Dropdown(
                    variabile: colorazionePersianaInt,
                    stringa: "colorazionePersianaInt",
                    condizione: "colorazionePersianaInt"),
                const Divider(),
                const Text('Colorazione Persiana Esterna'),
                Dropdown(
                    variabile: colorazionePersianaEst,
                    stringa: "colorazionePersianaEst",
                    condizione: "colorazionePersianaEst"),
                const Divider(),
                const Text('Riferimento Larghezza'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[10],
                ),
                // Dropdown(variabile: riferimentoLarghezza, stringa: "riferimentoLarghezza", condizione: "riferimentoLarghezza"),
                const Divider(),
                const Text('Riferimento Altezza'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[11],
                ),
                // Dropdown(variabile: riferimentoAltezza, stringa: "riferimentoAltezza", condizione: "riferimentoAltezza"),
                const Divider(),
                const Text('Controtelaio'),
                Dropdown(
                    variabile: controtelaio,
                    stringa: "controtelaio",
                    condizione: "controtelaio"),
                const Divider(),
                const Text('Riferimento Larghezza Persiana'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[12],
                ),
                // Dropdown(variabile: riferimentoAltezza, stringa: "riferimentoAltezza", condizione: "riferimentoAltezza"),
                const Divider(),
                const Text('Riferimento Altezza Persiana'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  textInputAction: TextInputAction.next,
                  controller: textController[13],
                ),
                // Dropdown(variabile: riferimentoAltezza, stringa: "riferimentoAltezza", condizione: "riferimentoAltezza"),
                const Divider(),

                ///TODO: DA CONTINUARE
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                selectedId != null
                    ? await DBHelper.instance.updatePersiana(
                        RilievoPersiana(
                          id: selectedId,
                          cliente: textController[0].text,
                          destinazione: textController[1].text,
                          data: textController[2].text,
                          tipologiaInfisso: textController[3].text,
                          finituraInfissoInt: finituraInterna,
                          finituraInfissoEst: finituraEsterna,
                          modelloPersiana: modelloPersiana,
                          colorazionePersianaInt: colorazionePersianaInt,
                          colorazionePersianaEst: colorazionePersianaEst,
                          riferimentoAltezza: textController[11].text,
                          riferimentoLarghezza: textController[10].text,
                          controtelai: controtelaio,
                          riferimentoLarghezzaPersiane: textController[12].text,
                          riferimentoAltezzaPersiane: textController[13].text,
                        ),
                      )
                    : await DBHelper.instance.addPersiana(RilievoPersiana(
                        cliente: textController[0].text,
                        destinazione: textController[1].text,
                        data: textController[2].text,
                        tipologiaInfisso: textController[3].text,
                        finituraInfissoInt: finituraInterna,
                        finituraInfissoEst: finituraEsterna,
                        modelloPersiana: modelloPersiana,
                        colorazionePersianaInt: colorazionePersianaInt,
                        colorazionePersianaEst: colorazionePersianaEst,
                        riferimentoAltezza: textController[11].text,
                        riferimentoLarghezza: textController[10].text,
                        controtelai: controtelaio,
                        riferimentoLarghezzaPersiane: textController[12].text,
                        riferimentoAltezzaPersiane: textController[13].text,
                      ));
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
