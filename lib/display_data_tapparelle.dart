// import 'dart:io';
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:applicazione_prova/rilievo_persiane.dart';
// import 'package:applicazione_prova/rilievo_tapparelle.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
// //import 'package:sqflite/sqflite.dart';


import 'nuovo_database.dart';
//import 'fotocamera.dart';
import 'nuova_fotocamera.dart';
import 'disegno.dart';

class DisplayDataTapparella extends StatefulWidget {

  const DisplayDataTapparella({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<DisplayDataTapparella> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayDataTapparella> {
  // final rilieviTapparelle = DBHelper.instance.getRilieviTapparelle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     Navigator.of(context).push(
      //         MaterialPageRoute(builder: (context) => RilievoTapparelle()));
      //   },
      //   child: const Icon(Icons.add),
      // ),
      appBar: AppBar(
        title: const Text('Visualizzazione dati tapparelle'),
      ),
      body: FutureBuilder<List<RilievoTapparella>>(
          future: DBHelper.instance.getRilieviTapparelle(),
          builder: (BuildContext context,
              AsyncSnapshot<List<RilievoTapparella>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Caricamento...'));
            }
            return snapshot.data!.isEmpty
                ? const Center(child: Text('Lista vuota'))
                : ListView(
                    children: snapshot.data!.map((rilievoTapparelle) {
                    return Card(
                      color: Colors.white70,
                      child: ListTile(
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  VisualizzaPosizioniTapparelle(
                                      camera: widget.camera,
                                      parentId: rilievoTapparelle.id)));
                        },
                        title: Text('${rilievoTapparelle.cantiere} '
                            ' '
                            '${rilievoTapparelle.cliente} '
                            ' '
                            '${rilievoTapparelle.data}'),
                        subtitle: Text('${rilievoTapparelle.tipologiaInfisso} '
                            ' '
                            '${rilievoTapparelle.guide} '
                            ' '
                            '${rilievoTapparelle.colorazioneInt} '
                            ' '
                            '${rilievoTapparelle.colorazioneEst} '
                            ' '
                            '${rilievoTapparelle.listelliInt} '
                            ' '
                            '${rilievoTapparelle.listelliEst}'
                            ' '
                            '${rilievoTapparelle.larghezzaInfissi}'
                            ' '
                            '${rilievoTapparelle.altezzaInfissi}'
                            ' '
                            '${rilievoTapparelle.misureLuce}'
                            ' '
                            '${rilievoTapparelle.tipoTapparella}'
                            ' '
                            '${rilievoTapparelle.coloreTapparella}'),
                      ),
                    );
                  }).toList());
          }),
    );
  }
}

class VisualizzaPosizioniTapparelle extends StatefulWidget {
  VisualizzaPosizioniTapparelle({super.key, required this.parentId, required this.camera});
  int? parentId;
  final CameraDescription camera;

  @override
  _VisualizzaPosizioniTapparelleState createState() =>
      _VisualizzaPosizioniTapparelleState();
}

class _VisualizzaPosizioniTapparelleState
    extends State<VisualizzaPosizioniTapparelle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ConfigurazioneTapparelle(parentId: widget.parentId)));
        },
      ),
      appBar: AppBar(
        title: const Text('Visualizzazione posizioni'),
      ),
      body: FutureBuilder<List<Configurazione>>(
        future: DBHelper.instance.getConfigurazioni('tapparelle'),
        builder: (BuildContext context,
            AsyncSnapshot<List<Configurazione>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Caricamento ...'));
          }
          return snapshot.data!.isEmpty
              ? const Center(child: Text('Lista vuota'))
              : ListView(
                  children: snapshot.data!.map((configurazioneTapparella) {
                    return Card(
                      color: Colors.white70,
                      child: configurazioneTapparella.idParente ==
                              widget.parentId
                          ? ListTile(
                              title: Text(
                                  '${configurazioneTapparella.riferimento}'),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Disegno(
                                                  id: configurazioneTapparella
                                                      .id,
                                                  tipoConfigurazione:
                                                      'tapparelle',
                                                )),
                                      );
                                      setState(() {});
                                    },
                                    child:
                                        configurazioneTapparella.disegno != null
                                            ? const Icon(Icons.draw)
                                            : const Icon(
                                                Icons.draw,
                                                color: Colors.red,
                                              ),
                                  ),
                                  const VerticalDivider(
                                    thickness: null,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Fotocamera(
                                                    cameraDescription: widget.camera,
                                                    mounted: mounted,
                                                    selectedId:
                                                        configurazioneTapparella
                                                            .id,
                                                    tipoConfigurazione:
                                                        'tapparelle',
                                                  )));
                                      setState(() {});
                                    },
                                    child: configurazioneTapparella.blob != null
                                        ? const Icon(Icons.add_a_photo)
                                        : const Icon(
                                            Icons.add_a_photo,
                                            color: Colors.red,
                                          ),
                                  ),
                                ],
                              ),
                            )
                          : null,
                    );
                  }).toList(),
                );
        },
      ),
    );
  }
}

class ConfigurazioneTapparelle extends StatefulWidget {
  ConfigurazioneTapparelle({super.key, required this.parentId});

  int? parentId;

  @override
  _ConfigurazioneTapparelleState createState() =>
      _ConfigurazioneTapparelleState();
}

class _ConfigurazioneTapparelleState extends State<ConfigurazioneTapparelle>
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
          title: const Text('Inserimento intestazione tapparelle'),
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
                      'tapparelle')
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
                      'tapparelle');
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
