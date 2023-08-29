// import 'dart:io';
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:applicazione_prova/rilievo_persiane.dart';
// import 'package:applicazione_prova/rilievo_tapparelle.dart';
import 'package:applicazione_prova/dropdownTelaio.dart';
import 'package:applicazione_prova/tendinaTipologia.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'disegno.dart';
//import 'fotocamera.dart';
import 'dropdownVetro.dart';
import 'nuova_fotocamera.dart';
// import 'package:share_plus/share_plus.dart';
// //import 'package:sqflite/sqflite.dart';
import 'dettaglio_posizione.dart';
import 'nuovo_database.dart';

String _riferimento = "";
String _quantita = "0";
String _larghezza = "0";
String _altezza = "0";
String tipoTapparelle = "";
String _dxsx = "";
String _vetro = "";
String _telaio = "";
String _larghezzaLuce = "0";
String _altezzaLuce = "0";
String _larghezzaCassonetto = "0";
String _altezzaCassonetto = "0";
String _spessoreCassonetto = "0";
String _profonditaCielino = "0";
String _note = "";

String tipoProfiloTapparelle = "";

String tipoVetroTapparelle = "";

String tipoTelaioTapparelle = "";

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
        // actions: [
        //   ElevatedButton(
        //     onPressed: () async {
        //       ///TODO: VA IN SCHERMO NERO, DA SISTEMARE
        //       Navigator.of(context).pop();
        //     },
        //     child: const Icon(Icons.arrow_back),
        //   )
        // ],
        title: const Text('Tapparelle - Visualizzazione dati'),
      ),
      body: FutureBuilder<List<RilievoTapparella>>(
          future: DBHelper.instance.getRilieviTapparelle(),
          builder: (BuildContext context,
              AsyncSnapshot<List<RilievoTapparella>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Caricamento ...'));
            }
            return snapshot.data!.isEmpty
                ? const Center(child: Text('Lista vuota'))
                : ListView(
                    children: snapshot.data!.map((rilievoTapparelle) {
                    return Card(
                      color: Colors.white70,
                      child: Slidable(
                        key: UniqueKey(),
                        startActionPane: ActionPane(
                          // A motion is a widget used to control how the pane animates.
                          motion: const ScrollMotion(),
                          // A pane can dismiss the Slidable.
                          dismissible:
                              DismissiblePane(confirmDismiss: () async {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                  title: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Conferma",
                                          ),
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
                                    Text(
                                      "Stai per eliminare \"${rilievoTapparelle.cliente}\" e tutti i suoi dati. Continuare?",
                                      style: const TextStyle(fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                    // const Divider(
                                    //   thickness: null,
                                    // ),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.center,
                                      children: [
                                        FloatingActionButton(
                                          child: const Icon(Icons.check),
                                          onPressed: () async {
                                            Navigator.of(context).pop(true);
                                          },
                                        ),
                                        FloatingActionButton(
                                          child: const Icon(
                                              Icons.highlight_remove),
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          }, onDismissed: () async {
                            await DBHelper.instance
                                .removeTapparella(rilievoTapparelle.id!);
                            setState(() {});
                          }),

                          // All actions are defined in the children parameter.
                          children: const [
                            // A SlidableAction can have an icon and/or a label.
                            SlidableAction(
                              onPressed: print,
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          // A motion is a widget used to control how the pane animates.
                          motion: const ScrollMotion(),
                          // A pane can dismiss the Slidable.
                          dismissible: DismissiblePane(onDismissed: () {
                            setState(() {});
                          }),
                          // All actions are defined in the children parameter.
                          children: const [
                            // A SlidableAction can have an icon and/or a label.
                            SlidableAction(
                              onPressed: print,
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Modifica',
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    VisualizzaPosizioniTapparelle(
                                        camera: widget.camera,
                                        parentId: rilievoTapparelle.id)));
                            setState(() {});
                          },
                          title: Text('${rilievoTapparelle.cantiere} '
                              ' '
                              '${rilievoTapparelle.cliente} '
                              ' '
                              '${rilievoTapparelle.data}'),
                          subtitle: Column(
                            children: [
                              Text('${rilievoTapparelle.tipologiaInfisso} '
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
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList());
          }),
    );
  }
}

class VisualizzaPosizioniTapparelle extends StatefulWidget {
  VisualizzaPosizioniTapparelle(
      {super.key, required this.parentId, required this.camera});
  int? parentId;
  final CameraDescription camera;

  @override
  _VisualizzaPosizioniTapparelleState createState() =>
      _VisualizzaPosizioniTapparelleState();
}

class _VisualizzaPosizioniTapparelleState
    extends State<VisualizzaPosizioniTapparelle> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ConfigurazioneTapparelle(parentId: widget.parentId)));
          setState(() {});
        },
      ),
      appBar: AppBar(
        title: const Text('Posizioni tapparelle'),
      ),
      body: FutureBuilder<List<Configurazione>>(
        future: DBHelper.instance.getConfigurazioni('tapparelle'),
        builder: (BuildContext context,
            AsyncSnapshot<List<Configurazione>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return snapshot.data!.isEmpty
              ? const Center(child: Text('Lista vuota'))
              : ListView(
                  children: snapshot.data!.map((configurazioneTapparella) {
                    return Card(
                      color: Colors.white70,
                      child: configurazioneTapparella.idParente ==
                              widget.parentId
                          ? Slidable(
                              key: UniqueKey(),
                              startActionPane: ActionPane(
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),
                                // A pane can dismiss the Slidable.
                                dismissible:
                                    DismissiblePane(confirmDismiss: () async {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SimpleDialog(
                                        title: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Conferma",
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        backgroundColor: Colors.white,
                                        elevation: 10,
                                        children: [
                                          Text(
                                            "Stai per eliminare "
                                            "\"${configurazioneTapparella.riferimento}\""
                                            " e tutti i suoi dati. Continuare?",
                                            style:
                                                const TextStyle(fontSize: 15),
                                            textAlign: TextAlign.center,
                                          ),
                                          // const Divider(
                                          //   thickness: null,
                                          // ),
                                          ButtonBar(
                                            alignment: MainAxisAlignment.center,
                                            children: [
                                              FloatingActionButton(
                                                child: const Icon(Icons.check),
                                                onPressed: () async {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                              ),
                                              FloatingActionButton(
                                                child: const Icon(
                                                    Icons.highlight_remove),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }, onDismissed: () async {
                                  await DBHelper.instance.removeConfigurazione(
                                      configurazioneTapparella.id!,
                                      "tapparelle");
                                  setState(() {});
                                }),

                                // All actions are defined in the children parameter.
                                children: const [
                                  // A SlidableAction can have an icon and/or a label.
                                  SlidableAction(
                                    onPressed: print,
                                    backgroundColor: Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                    '${configurazioneTapparella.riferimento}'),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DettaglioPosizione(
                                                        id: configurazioneTapparella
                                                            .id,
                                                        tipoConfigurazione:
                                                            'tapparelle',
                                                      )));
                                          setState(() {});
                                        },
                                        child: const Icon(Icons.visibility)),
                                    const VerticalDivider(
                                      width: 5,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Disegno(
                                                    configurazionePersiana:
                                                        configurazioneTapparella,
                                                    tipoConfigurazione:
                                                        'tapparelle',
                                                  )),
                                        );
                                        setState(() {});
                                      },
                                      child: configurazioneTapparella.disegno !=
                                              null
                                          ? const Icon(Icons.draw)
                                          : const Icon(
                                              Icons.draw,
                                              color: Colors.red,
                                            ),
                                    ),
                                    const VerticalDivider(
                                      width: 5,
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
                                                          configurazioneTapparella
                                                              .id,
                                                      tipoConfigurazione:
                                                          'tapparelle',
                                                    )));
                                        setState(() {});
                                      },
                                      child:
                                          configurazioneTapparella.blob != null
                                              ? const Icon(Icons.add_a_photo)
                                              : const Icon(
                                                  Icons.add_a_photo,
                                                  color: Colors.red,
                                                ),
                                    ),
                                    const VerticalDivider(
                                      width: 5,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ConfigurazioneTapparelle(
                                                      parentId: widget.parentId,
                                                      configurazioneTapparelle:
                                                          configurazioneTapparella,
                                                    )));
                                        setState(() {});
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const VerticalDivider(
                                      width: 5,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {},
                                      child: const Icon(Icons.mic),
                                    ),
                                  ],
                                ),
                              ),
                            )

                          ///TODO: mette un widget vuoto, da cambiare
                          : const SizedBox.shrink(),
                    );
                  }).toList(),
                );
        },
      ),
    );
  }
}

class ConfigurazioneTapparelle extends StatefulWidget {
  ConfigurazioneTapparelle(
      {super.key, required this.parentId, this.configurazioneTapparelle});

  int? parentId;
  Configurazione? configurazioneTapparelle;

  @override
  _ConfigurazioneTapparelleState createState() =>
      _ConfigurazioneTapparelleState();
}

class _ConfigurazioneTapparelleState extends State<ConfigurazioneTapparelle>
    with WidgetsBindingObserver {
  int? selectedId;
  //bool _numberInputIsValid = true;

  final List<bool> _numberInputIsValid = List.filled(9, true);

  List<FocusNode> focusNodeList = List.generate(9, (_) => FocusNode());

  //DA MODIFICARE PER FARE PIU DI DUE TEXTFIELD//
  List<TextEditingController> textController =
      List.generate(15, (int i) => TextEditingController());

  @override
  void initState() {
    super.initState();
    if (widget.configurazioneTapparelle != null) {
      selectedId = widget.configurazioneTapparelle!.id;
      textController[0].text = widget.configurazioneTapparelle!.riferimento!;
      textController[1].text =
          widget.configurazioneTapparelle!.quantita!.toString();
      textController[2].text =
          widget.configurazioneTapparelle!.larghezza!.toString();
      textController[3].text =
          widget.configurazioneTapparelle!.altezza!.toString();
      textController[4].text = widget.configurazioneTapparelle!.tipo!;
      textController[5].text = widget.configurazioneTapparelle!.dxsx!;
      textController[6].text = widget.configurazioneTapparelle!.vetro!;
      textController[7].text = widget.configurazioneTapparelle!.telaio!;
      textController[8].text =
          widget.configurazioneTapparelle!.larghezzaLuce!.toString();
      textController[9].text =
          widget.configurazioneTapparelle!.altezzaLuce!.toString();
      textController[10].text =
          widget.configurazioneTapparelle!.larghezzaCassonetto!.toString();
      textController[11].text =
          widget.configurazioneTapparelle!.altezzaCassonetto!.toString();
      textController[12].text =
          widget.configurazioneTapparelle!.spessoreCassonetto!.toString();
      textController[13].text =
          widget.configurazioneTapparelle!.profonditaCielino!.toString();
      textController[14].text = widget.configurazioneTapparelle!.note!;
    } else {
      textController[0].text = _riferimento;
      textController[1].text = _quantita;
      textController[2].text = _larghezza;
      textController[3].text = _altezza;
      textController[4].text = tipoTapparelle;
      textController[5].text = _dxsx;
      textController[6].text = _vetro;
      textController[7].text = _telaio;
      textController[8].text = _larghezzaLuce;
      textController[9].text = _altezzaLuce;
      textController[10].text = _larghezzaCassonetto;
      textController[11].text = _altezzaCassonetto;
      textController[12].text = _spessoreCassonetto;
      textController[13].text = _profonditaCielino;
      textController[14].text = _note;
    }
  }

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
          title: const Text('Configurazione tapparella'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            children: [
              const Text('Riferimento'),
              TextField(
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                textInputAction: TextInputAction.next,
                controller: textController[0],
              ),
              const Divider(),
              const Text('Quantità'),
              TextFormField(
                onTap: () => textController[1].selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: textController[1].value.text.length),
                decoration: InputDecoration(
                  //labelText: "Inserisci un intero (es. 10)",
                  errorText: _numberInputIsValid[0]
                      ? null
                      : "Inserisci un intero (es. 10)",
                ),
                onChanged: (String val) {
                  final v = int.tryParse(val);
                  if (v == null) {
                    setState(() {
                      _numberInputIsValid[0] = false;
                    });
                  } else {
                    setState(() {
                      _numberInputIsValid[0] = true;
                    });
                  }
                },
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                textInputAction: TextInputAction.next,
                focusNode: focusNodeList[0],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      int.tryParse(value) == null ||
                      value.isEmpty) {
                    focusNodeList[0].requestFocus();
                    return 'Inserire un valore corretto es: 10';
                  }
                  return null;
                },
                controller: textController[1],
              ),
              const Divider(),
              const Text('Larghezza'),
              TextFormField(
                onTap: () => textController[2].selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: textController[2].value.text.length),
                decoration: InputDecoration(
                  errorText: _numberInputIsValid[1]
                      ? null
                      : "Inserisci un numero (es. 10.5)",
                ),
                onChanged: (String val) {
                  final v = double.tryParse(val);
                  if (v == null) {
                    setState(() {
                      _numberInputIsValid[1] = false;
                    });
                  } else {
                    setState(() {
                      _numberInputIsValid[1] = true;
                    });
                  }
                },
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                textInputAction: TextInputAction.next,
                focusNode: focusNodeList[1],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      value.isEmpty) {
                    focusNodeList[1].requestFocus();
                    return 'Inserire un valore corretto es: 10.2';
                  }
                  return null;
                },
                controller: textController[2],
              ),
              const Divider(),
              const Text('Altezza'),
              TextFormField(
                onTap: () => textController[3].selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: textController[3].value.text.length),
                decoration: InputDecoration(
                  errorText: _numberInputIsValid[2]
                      ? null
                      : "Inserisci un numero (es. 10.5)",
                ),
                onChanged: (String val) {
                  final v = double.tryParse(val);
                  if (v == null) {
                    setState(() {
                      _numberInputIsValid[2] = false;
                    });
                  } else {
                    setState(() {
                      _numberInputIsValid[2] = true;
                    });
                  }
                },
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                textInputAction: TextInputAction.next,
                focusNode: focusNodeList[2],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      value.isEmpty) {
                    focusNodeList[2].requestFocus();
                    return 'Inserire un valore corretto es: 10.2';
                  }
                  return null;
                },
                controller: textController[3],
              ),
              const Divider(),
              const Text('Tipo'),
              TendinaTipologia(text: tipoTapparelle, stringa: "tipoTapparelle",),
              const Divider(),
              const Text('Profilo'),
              TendinaTipologia(text: tipoProfiloTapparelle, stringa: "tipoProfiloTapparelle"),
              const Divider(),
              const Text('DX/SX'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        textController[5].text = "Dx";
                      },
                      child: const Text("DX")),
                  ElevatedButton(
                      onPressed: () {
                        textController[5].text = "Sx";
                      },
                      child: const Text("SX"))
                ],
              ),
              TextField(
                enabled: false,
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                textInputAction: TextInputAction.next,
                controller: textController[5],
              ),
              const Divider(),
              const Text('Vetro'),
              DropdownVetro(text: tipoVetroTapparelle, stringa: "tipoVetroTapparelle"),
              const Divider(),
              const Text('Telaio'),
              DropdownTelaio(text: tipoTelaioTapparelle, stringa: "tipoTelaioTapparelle"),
              const Divider(),
              const Text('Larghezza luce'),
              TextFormField(
                onTap: () => textController[8].selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: textController[8].value.text.length),
                decoration: InputDecoration(
                  errorText: _numberInputIsValid[3]
                      ? null
                      : "Inserisci un numero (es. 10.5)",
                ),
                onChanged: (String val) {
                  final v = double.tryParse(val);
                  if (v == null) {
                    setState(() {
                      _numberInputIsValid[3] = false;
                    });
                  } else {
                    setState(() {
                      _numberInputIsValid[3] = true;
                    });
                  }
                },
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                textInputAction: TextInputAction.next,
                focusNode: focusNodeList[3],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      value.isEmpty) {
                    focusNodeList[3].requestFocus();
                    return 'Inserire un valore corretto es: 10.2';
                  }
                  return null;
                },
                controller: textController[8],
              ),
              const Divider(),
              const Text('Altezza luce'),
              TextFormField(
                onTap: () => textController[9].selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: textController[9].value.text.length),
                decoration: InputDecoration(
                  errorText: _numberInputIsValid[4]
                      ? null
                      : "Inserisci un numero (es. 10.5)",
                ),
                onChanged: (String val) {
                  final v = double.tryParse(val);
                  if (v == null) {
                    setState(() {
                      _numberInputIsValid[4] = false;
                    });
                  } else {
                    setState(() {
                      _numberInputIsValid[4] = true;
                    });
                  }
                },
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                textInputAction: TextInputAction.next,
                focusNode: focusNodeList[4],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      value.isEmpty) {
                    focusNodeList[4].requestFocus();
                    return 'Inserire un valore corretto es: 10.2';
                  }
                  return null;
                },
                controller: textController[9],
              ),
              const Divider(),
              const Text('Larghezza cassonetto'),
              TextFormField(
                onTap: () => textController[10].selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: textController[10].value.text.length),
                decoration: InputDecoration(
                  errorText: _numberInputIsValid[5]
                      ? null
                      : "Inserisci un numero (es. 10.5)",
                ),
                onChanged: (String val) {
                  final v = double.tryParse(val);
                  if (v == null) {
                    setState(() {
                      _numberInputIsValid[5] = false;
                    });
                  } else {
                    setState(() {
                      _numberInputIsValid[5] = true;
                    });
                  }
                },
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                textInputAction: TextInputAction.next,
                focusNode: focusNodeList[5],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      value.isEmpty) {
                    focusNodeList[5].requestFocus();
                    return 'Inserire un valore corretto es: 10.2';
                  }
                  return null;
                },
                controller: textController[10],
              ),
              const Divider(),
              const Text('Altezza cassonetto'),
              TextFormField(
                onTap: () => textController[11].selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: textController[11].value.text.length),
                decoration: InputDecoration(
                  errorText: _numberInputIsValid[6]
                      ? null
                      : "Inserisci un numero (es. 10.5)",
                ),
                onChanged: (String val) {
                  final v = double.tryParse(val);
                  if (v == null) {
                    setState(() {
                      _numberInputIsValid[6] = false;
                    });
                  } else {
                    setState(() {
                      _numberInputIsValid[6] = true;
                    });
                  }
                },
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                textInputAction: TextInputAction.next,
                focusNode: focusNodeList[6],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      value.isEmpty) {
                    focusNodeList[6].requestFocus();
                    return 'Inserire un valore corretto es: 10.2';
                  }
                  return null;
                },
                controller: textController[11],
              ),
              const Divider(),
              const Text('Spessore cassonetto'),
              TextFormField(
                onTap: () => textController[12].selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: textController[12].value.text.length),
                decoration: InputDecoration(
                  errorText: _numberInputIsValid[7]
                      ? null
                      : "Inserisci un numero (es. 10.5)",
                ),
                onChanged: (String val) {
                  final v = double.tryParse(val);
                  if (v == null) {
                    setState(() {
                      _numberInputIsValid[7] = false;
                    });
                  } else {
                    setState(() {
                      _numberInputIsValid[7] = true;
                    });
                  }
                },
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                textInputAction: TextInputAction.next,
                focusNode: focusNodeList[7],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      value.isEmpty) {
                    focusNodeList[7].requestFocus();
                    return 'Inserire un valore corretto es: 10.2';
                  }
                  return null;
                },
                controller: textController[12],
              ),
              const Divider(),
              const Text('Profondità cielino'),
              TextFormField(
                onTap: () => textController[13].selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: textController[13].value.text.length),
                decoration: InputDecoration(
                  errorText: _numberInputIsValid[8]
                      ? null
                      : "Inserisci un numero (es. 10.5)",
                ),
                onChanged: (String val) {
                  final v = double.tryParse(val);
                  if (v == null) {
                    setState(() {
                      _numberInputIsValid[8] = false;
                    });
                  } else {
                    setState(() {
                      _numberInputIsValid[8] = true;
                    });
                  }
                },
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                textInputAction: TextInputAction.next,
                focusNode: focusNodeList[8],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      value.isEmpty) {
                    focusNodeList[8].requestFocus();
                    return 'Inserire un valore corretto es: 10.2';
                  }
                  return null;
                },
                controller: textController[13],
              ),
              const Divider(),
              const Text('Note'),
              TextField(
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                textInputAction: TextInputAction.next,
                controller: textController[14],
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                backgroundColor: Colors.red,
                mini: true,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.cancel, size: 25)),
            FloatingActionButton(
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
                              tipo: "$tipoTapparelle-$tipoProfiloTapparelle",
                              dxsx: textController[5].text,
                              vetro: tipoVetroTapparelle,
                              telaio: tipoTelaioTapparelle,
                              larghezzaLuce:
                                  double.parse(textController[8].text),
                              altezzaLuce: double.parse(textController[9].text),
                              larghezzaCassonetto:
                                  double.parse(textController[10].text),
                              altezzaCassonetto:
                                  double.parse(textController[11].text),
                              spessoreCassonetto:
                                  double.parse(textController[12].text),
                              profonditaCielino:
                                  double.parse(textController[13].text),
                              note: textController[14].text,
                              idParente: widget.parentId,
                              disegno: widget.configurazioneTapparelle?.disegno,
                              blob: widget.configurazioneTapparelle?.blob),
                          'tapparelle')
                      : await DBHelper.instance.addConfigurazione(
                          Configurazione(
                            riferimento: textController[0].text,
                            quantita: int.parse(textController[1].text),
                            larghezza: double.parse(textController[2].text),
                            altezza: double.parse(textController[3].text),
                            tipo: "$tipoTapparelle-$tipoProfiloTapparelle",
                            dxsx: textController[5].text,
                            vetro: tipoVetroTapparelle,
                            telaio: tipoTelaioTapparelle,
                            larghezzaLuce: double.parse(textController[8].text),
                            altezzaLuce: double.parse(textController[9].text),
                            larghezzaCassonetto:
                                double.parse(textController[10].text),
                            altezzaCassonetto:
                                double.parse(textController[11].text),
                            spessoreCassonetto:
                                double.parse(textController[12].text),
                            profonditaCielino:
                                double.parse(textController[13].text),
                            note: textController[14].text,
                            idParente: widget.parentId,
                          ),
                          'tapparelle');
                  setState(() {
                    _riferimento = textController[0].text;
                    _quantita = textController[1].text;
                    _larghezza = textController[2].text;
                    _altezza = textController[3].text;
                    //tipoTapparelle = textController[4].text;
                    _dxsx = textController[5].text;
                    //_vetro = textController[6].text;
                    //_telaio = textController[7].text;
                    _larghezzaLuce = textController[8].text;
                    _altezzaLuce = textController[9].text;
                    _larghezzaCassonetto = textController[10].text;
                    _altezzaCassonetto = textController[11].text;
                    _spessoreCassonetto = textController[12].text;
                    _profonditaCielino = textController[13].text;
                    _note = textController[14].text;
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
                    textController[14].clear();
                    selectedId = null;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Icon(Icons.save),
            ),
          ],
        ),
      ),
    ));
  }
}
