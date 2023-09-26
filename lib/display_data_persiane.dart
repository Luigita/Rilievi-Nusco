// import 'dart:io';
// import 'dart:async';
// import 'dart:convert';

// import 'package:applicazione_prova/display_data_tapparelle.dart';
// import 'package:applicazione_prova/rilievo_persiane.dart';
// import 'package:applicazione_prova/rilievo_tapparelle.dart';
import 'package:applicazione_prova/dropdownVetro.dart';
import 'package:applicazione_prova/nuovo_registratore.dart';
import 'package:applicazione_prova/rilievo_persiane.dart';
import 'package:applicazione_prova/tendinaTipologia.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'nuovo_database.dart';
import 'dettaglio_posizione.dart';
import 'disegno.dart';
//import 'fotocamera.dart';
import 'dropdownTelaio.dart';
import 'nuova_fotocamera.dart';

import 'nuovo_database.dart';
import 'registratore_audio.dart';

String _riferimento = "";
String _quantita = "0";
String _larghezza = "0";
String _altezza = "0";
String tipoPersiane = "";
String _dxsx = "";
String _vetro = "";
String _telaio = "";
String _larghezzaLuce = "0";
String _altezzaLuce = "0";
String _note = "";

String tipoProfiloPersiane = "";
String tipoVetroPersiane = "";
String tipoTelaioPersiane = "";

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
        // actions: [
        //   ElevatedButton(
        //     onPressed: () async {
        //       setState(() {});
        //     },
        //     child: const Icon(Icons.update),
        //   )
        // ],
        title: const Text('Persiane - Visualizzazione dati'),
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
                    DBHelper.instance.contaPosizioniPersiane("configurazionePersiane", rilievoPersiane);
                  return Card(
                    color: Colors.white70,
                    child: Slidable(
                      key: UniqueKey(),
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),
                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(confirmDismiss: () async {
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
                                          "Conferma eliminazione",
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
                                    "Stai per eliminare \"${rilievoPersiane.cliente}\" e tutti i suoi dati. Continuare?",
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
                                        child:
                                            const Icon(Icons.highlight_remove),
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
                              .removePersiana(rilievoPersiane.id!);
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
                                // TODO: aggiungere modifica come per le singole posizioni
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
                                  builder: (context) => VisualizzaPosizioniPersiane(
                                      camera: widget.camera,
                                      parentId: rilievoPersiane.id)));
                              setState(() {});
                            },
                            trailing: FutureBuilder<Widget>(
                              future: numeroPosizioniPersiane(rilievoPersiane),
                              builder: (context, snaposhot){
                                if(snapshot.connectionState == ConnectionState.done){
                                  return Text("${rilievoPersiane.posizioni} posizioni");
                                }
                                else if(snapshot.hasError){
                                  throw snapshot.error!;
                                }
                                else{
                                  return Center(child: CircularProgressIndicator());
                                }
                              }
                            ),
                            title: Text('${rilievoPersiane.cliente} '
                                ' '
                                '${rilievoPersiane.destinazione} '
                                ' '
                                '${rilievoPersiane.data}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${rilievoPersiane.modelloPorta} '
                                    ' '
                                    '${rilievoPersiane.finituraInterna} '
                                    ' '
                                    '${rilievoPersiane.modelloManiglia} '
                                    ' '
                                    '${rilievoPersiane.ferramenta} '),
                              ],
                            ),
                          ),
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
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ConfigurazionePersiane(parentId: widget.parentId)));
          setState(() {});
        },
      ),
      appBar: AppBar(
        // actions: [
        //   ElevatedButton(
        //     onPressed: () async {
        //       Navigator.of(context).pop;
        //     },
        //     child: const Icon(Icons.arrow_back),
        //   )
        // ],
        title: const Text('Posizioni persiane'),
      ),
      body: FutureBuilder<List<Configurazione>>(
        future: DBHelper.instance.getConfigurazioni('persiane'),
        builder: (BuildContext context,
            AsyncSnapshot<List<Configurazione>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return snapshot.data!.isEmpty
              ? const Center(child: Text('Lista vuota'))
              : ListView(
                  children: snapshot.data!.map((configurazionePersiana) {
                    return Card(
                      color: Colors.white70,
                      child: configurazionePersiana.idParente == widget.parentId
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
                                            "Stai per eliminare \"${configurazionePersiana.riferimento}\" e tutti i suoi dati. Continuare?",
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
                                      configurazionePersiana.id!, "persiane");
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
                                    '${configurazionePersiana.riferimento}'),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DettaglioPosizione(
                                                        id: configurazionePersiana
                                                            .id,
                                                        tipoConfigurazione:
                                                            'persiane',
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
                                                        configurazionePersiana,
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
                                    const VerticalDivider(
                                      width: 5,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ConfigurazionePersiane(
                                                      parentId: widget.parentId,
                                                      configurazionePersiane:
                                                          configurazionePersiana,
                                                    )));
                                        setState(() {});
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                      ),
                                    ),
                                    const VerticalDivider(
                                      width: 5,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          if (configurazionePersiana.blob !=
                                              null) {
                                            await Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SoundRecorder(configurazione: configurazionePersiana, tipoConfigurazione: "persiane")
                                                        // RegistraAudio(
                                                        //   configurazione:
                                                        //       configurazionePersiana,
                                                        //   tipoConfigurazione:
                                                        //       'persiane',
                                                        // )));
                                                        ));
                                          }
                                        },
                                        child:
                                            configurazionePersiana.blob != null
                                                ? const Icon(Icons.mic)
                                                : const Icon(Icons.mic,
                                                    color: Colors.red)),
                                  ],
                                ),
                              ),
                            )
                          /// TODO: mette un widget vuoto, da cambiare
                          : const SizedBox.shrink(),
                    );
                  }).toList(),
                );
        },
      ),
    );
  }
}

class ConfigurazionePersiane extends StatefulWidget {
  ConfigurazionePersiane(
      {super.key, required this.parentId, this.configurazionePersiane});

  int? parentId;
  Configurazione? configurazionePersiane;

  @override
  _ConfigurazionePersianeState createState() => _ConfigurazionePersianeState();
}

class _ConfigurazionePersianeState extends State<ConfigurazionePersiane>
    with WidgetsBindingObserver {
  int? selectedId;

  final List<bool> _numberInputIsValid = List.filled(5, true);

  List<FocusNode> focusNodeList = List.generate(5, (_) => FocusNode());

  //DA MODIFICARE PER FARE PIU DI DUE TEXTFIELD//
  List<TextEditingController> textController =
      List.generate(11, (int i) => TextEditingController());

  @override
  void initState() {
    super.initState();
    if (widget.configurazionePersiane != null) {
      selectedId = widget.configurazionePersiane!.id;
      textController[0].text = widget.configurazionePersiane!.riferimento!;
      textController[1].text =
          widget.configurazionePersiane!.quantita!.toString();
      textController[2].text =
          widget.configurazionePersiane!.larghezza!.toString();
      textController[3].text =
          widget.configurazionePersiane!.altezza!.toString();
      textController[4].text = widget.configurazionePersiane!.tipo!;
      textController[5].text = widget.configurazionePersiane!.dxsx!;
      textController[6].text = widget.configurazionePersiane!.vetro!;
      textController[7].text = widget.configurazionePersiane!.telaio!;
      textController[8].text =
          widget.configurazionePersiane!.larghezzaLuce!.toString();
      textController[9].text =
          widget.configurazionePersiane!.altezzaLuce!.toString();
      textController[10].text = widget.configurazionePersiane!.note!;
    } else {
      textController[0].text = _riferimento;
      textController[1].text = _quantita;
      textController[2].text = _larghezza;
      textController[3].text = _altezza;
      textController[4].text = tipoPersiane;
      textController[5].text = _dxsx;
      textController[6].text = _vetro;
      textController[7].text = _telaio;
      textController[8].text = _larghezzaLuce;
      textController[9].text = _altezzaLuce;
      textController[10].text = _note;
    }
  }

  final _formKey = GlobalKey<FormState>();

  bool shouldPop = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          //resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text('Configurazione persiana'),
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
                TendinaTipologia(text: tipoPersiane, stringa: "tipoPersiane"),
                const Divider(),
                const Text('Profilo'),
                TendinaTipologia(
                    text: tipoProfiloPersiane, stringa: "tipoProfiloPersiane"),
                // TextField(
                //   scrollPadding: EdgeInsets.only(
                //       bottom: MediaQuery.of(context).viewInsets.bottom),
                //   textInputAction: TextInputAction.next,
                //   controller: textController[4],
                // ),
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
                DropdownVetro(text: tipoVetroPersiane, stringa: "tipoVetroPersiane"),
                // TextField(
                //   scrollPadding: EdgeInsets.only(
                //       bottom: MediaQuery.of(context).viewInsets.bottom),
                //   textInputAction: TextInputAction.next,
                //   controller: textController[6],
                // ),
                const Divider(),
                const Text('Telaio'),
                DropdownTelaio(text: tipoTelaioPersiane, stringa: "tipoTelaioPersiane"),
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
                const Text('Note'),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  controller: textController[10],
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
                                tipo: "$tipoPersiane-$tipoProfiloPersiane",
                                dxsx: textController[5].text,
                                vetro: tipoVetroPersiane,
                                telaio: tipoTelaioPersiane,
                                larghezzaLuce:
                                    double.parse(textController[8].text),
                                altezzaLuce:
                                    double.parse(textController[9].text),
                                note: textController[10].text,
                                idParente: widget.parentId,
                                disegno: widget.configurazionePersiane?.disegno,
                                blob: widget.configurazionePersiane?.blob),
                            'persiane')
                        : await DBHelper.instance.addConfigurazione(
                            Configurazione(
                              riferimento: textController[0].text,
                              quantita: int.parse(textController[1].text),
                              larghezza: double.parse(textController[2].text),
                              altezza: double.parse(textController[3].text),
                              tipo: "$tipoPersiane-$tipoProfiloPersiane",
                              dxsx: textController[5].text,
                              vetro: tipoVetroPersiane,
                              telaio: tipoTelaioPersiane,
                              larghezzaLuce:
                                  double.parse(textController[8].text),
                              altezzaLuce: double.parse(textController[9].text),
                              note: textController[10].text,
                              idParente: widget.parentId,
                            ),
                            'persiane');
                    setState(() {
                      _riferimento = textController[0].text;
                      _quantita = textController[1].text;
                      _larghezza = textController[2].text;
                      _altezza = textController[3].text;
                      //tipoPersiane = textController[4].text;
                      _dxsx = textController[5].text;
                      //_vetro = textController[6].text;
                      //_telaio = textController[7].text;
                      _larghezzaLuce = textController[8].text;
                      _altezzaLuce = textController[9].text;
                      _note = textController[10].text;
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
                  setState(() {
                    shouldPop = !shouldPop;
                  });
                },
                child: const Icon(Icons.save),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
Future<Widget> numeroPosizioniPersiane(RilievoPersiana rilievoPersiane) async {

  await DBHelper.instance.contaPosizioniPersiane("configurazionePersiane", rilievoPersiane);

  return Text("${rilievoPersiane.posizioni} posizioni");

}