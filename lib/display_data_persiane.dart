// import 'dart:io';
// import 'dart:async';
// import 'dart:convert';

// import 'package:applicazione_prova/display_data_tapparelle.dart';
// import 'package:applicazione_prova/rilievo_persiane.dart';
// import 'package:applicazione_prova/rilievo_tapparelle.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
//import 'package:sqflite/sqflite.dart';

import 'nuovo_database.dart';
//import 'fotocamera.dart';
import 'nuova_fotocamera.dart';
import 'disegno.dart';

class DisplayDataPersiana extends StatefulWidget {
  const DisplayDataPersiana({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<DisplayDataPersiana> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayDataPersiana> {
  // final rilieviPersiane = DBHelper.instance.getRilieviPersiane();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizzazione dati persiane'),
      ),
      body: FutureBuilder<List<RilievoPersiana>>(
        future: DBHelper.instance.getRilieviPersiane(),
        builder: (BuildContext context,
            AsyncSnapshot<List<RilievoPersiana>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Caricamento ...'));
          }
          return snapshot.data!.isEmpty
              ? const Center(child: Text('Lista vuota'))
              : ListView(
                  children: snapshot.data!.map((rilievoPersiane) {
                  return Card(
                    color: Colors.white70,
                    child: ListTile(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VisualizzaPosizioniPersiane(
                                camera: widget.camera,
                                parentId: rilievoPersiane.id)));
                      },
                      title: Text('${rilievoPersiane.cliente} '
                          ' '
                          '${rilievoPersiane.destinazione} '
                          ' '
                          '${rilievoPersiane.data}'),
                      subtitle: Text('${rilievoPersiane.modelloPorta} '
                          ' '
                          '${rilievoPersiane.finituraInterna} '
                          ' '
                          '${rilievoPersiane.modelloManiglia} '
                          ' '
                          '${rilievoPersiane.ferramenta} '),
                    ),
                  );
                }).toList());
        },
      ),
    );
  }
}

class VisualizzaPosizioniPersiane extends StatefulWidget {
  VisualizzaPosizioniPersiane(
      {super.key, required this.parentId, required this.camera});
  int? parentId;
  final CameraDescription camera;

  @override
  _VisualizzaPosizioniPersianeState createState() =>
      _VisualizzaPosizioniPersianeState();
}

class _VisualizzaPosizioniPersianeState
    extends State<VisualizzaPosizioniPersiane> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ConfigurazionePersiane(parentId: widget.parentId)));
        },
      ),
      appBar: AppBar(
        title: const Text('Visualizza posizioni'),
      ),
      body: FutureBuilder<List<Configurazione>>(
        future: DBHelper.instance.getConfigurazioni('persiane'),
        builder: (BuildContext context,
            AsyncSnapshot<List<Configurazione>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Caricamento ...'));
          }
          return snapshot.data!.isEmpty
              ? const Center(child: Text('Lista vuota'))
              : ListView(
                  children: snapshot.data!.map((configurazionePersiana) {
                    return Card(
                        color: Colors.white70,
                        child: configurazionePersiana.idParente ==
                                widget.parentId
                            ? ListTile(
                                title: Text(
                                    '${configurazionePersiana.riferimento}'),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Disegno(
                                                    id: configurazionePersiana
                                                        .id,
                                                    tipoConfigurazione:
                                                        'persiane')));
                                        setState(() {});
                                      },
                                      child:
                                          configurazionePersiana.disegno != null
                                              ? const Icon(Icons.draw)
                                              : const Icon(Icons.draw,
                                                  color: Colors.red),
                                    ),
                                    const VerticalDivider(
                                      thickness: null,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Fotocamera(
                                                        cameraDescription:
                                                            widget.camera,
                                                        mounted: mounted,
                                                        selectedId:
                                                            configurazionePersiana
                                                                .id,
                                                        tipoConfigurazione:
                                                            'persiane',
                                                      )));
                                          setState(() {});
                                        },
                                        child:
                                            configurazionePersiana.blob != null
                                                ? const Icon(Icons.add_a_photo)
                                                : const Icon(Icons.add_a_photo,
                                                    color: Colors.red)),
                                  ],
                                ),
                              )
                            : null);
                  }).toList(),
                );
        },
      ),
    );
  }
}

class ConfigurazionePersiane extends StatefulWidget {
  ConfigurazionePersiane({super.key, required this.parentId});

  int? parentId;

  @override
  _ConfigurazionePersianeState createState() => _ConfigurazionePersianeState();
}

class _ConfigurazionePersianeState extends State<ConfigurazionePersiane>
    with WidgetsBindingObserver {
  int? selectedId;

  //DA MODIFICARE PER FARE PIU DI DUE TEXTFIELD//
  List<TextEditingController> textController =
      List.generate(11, (int i) => TextEditingController());

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
          title: const Text('Inserimento intestazione persiane'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            children: [
              const Text('Riferimento'),
              TextField(
                controller: textController[0],
              ),
              const Divider(),
              const Text('Quantità'),
              TextFormField(
                validator: (value) {
                  if (value == null ||
                      int.tryParse(value) == null ||
                      value.isEmpty) {
                    return 'Inserire un valore corretto es: 10';
                  }
                  return null;
                },
                controller: textController[1],
              ),
              const Divider(),
              const Text('Larghezza'),
              TextFormField(
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      value.isEmpty) {
                    return 'Inserire un valore corretto es: 10.2';
                  }
                  return null;
                },
                controller: textController[2],
              ),
              const Divider(),
              const Text('Altezza'),
              TextFormField(
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      value.isEmpty) {
                    return 'Inserire un valore corretto es: 10.2';
                  }
                  return null;
                },
                controller: textController[3],
              ),
              const Divider(),
              const Text('Tipo'),
              TextField(
                controller: textController[4],
              ),
              const Divider(),
              const Text('DX/SX'),
              TextField(
                controller: textController[5],
              ),
              const Divider(),
              const Text('Vetro'),
              TextField(
                controller: textController[6],
              ),
              const Divider(),
              const Text('Telaio'),
              TextField(
                controller: textController[7],
              ),
              const Divider(),
              const Text('Larghezza luce'),
              TextFormField(
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      value.isEmpty) {
                    return 'Inserire un valore corretto es: 10.2';
                  }
                  return null;
                },
                controller: textController[8],
              ),
              const Divider(),
              const Text('Altezza luce'),
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
              const Text('Note'),
              TextField(
                controller: textController[10],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              selectedId != null
                  ? await DBHelper.instance.updateConfigurazione(
                      Configurazione(
                        id: selectedId,
                        riferimento: textController[0].text,
                        quantita: int.parse(textController[1].text),
                        larghezza: double.parse(textController[2].text),
                        altezza: double.parse(textController[3].text),
                        tipo: textController[4].text,
                        dxsx: textController[5].text,
                        vetro: textController[6].text,
                        telaio: textController[7].text,
                        larghezzaLuce: double.parse(textController[8].text),
                        altezzaLuce: double.parse(textController[9].text),
                        note: textController[10].text,
                        idParente: widget.parentId,
                      ),
                      'persiane')
                  : await DBHelper.instance.addConfigurazione(
                      Configurazione(
                        riferimento: textController[0].text,
                        quantita: int.parse(textController[1].text),
                        larghezza: double.parse(textController[2].text),
                        altezza: double.parse(textController[3].text),
                        tipo: textController[4].text,
                        dxsx: textController[5].text,
                        vetro: textController[6].text,
                        telaio: textController[7].text,
                        larghezzaLuce: double.parse(textController[8].text),
                        altezzaLuce: double.parse(textController[9].text),
                        note: textController[10].text,
                        idParente: widget.parentId,
                      ),
                      'persiane');
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
                selectedId = null;
              });
              Navigator.of(context).pop();
            }
          },
          child: const Icon(Icons.save),
        ),
      ),
    ));
  }
}
