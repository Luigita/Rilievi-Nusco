import 'package:applicazione_prova/mio_database.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'mio_database.dart';

Future main() async {
  // Avoid errors caused by flutter upgrade.
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HELLO WORLD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: InserimentoTesto(title: "Nome Applicazione"),
    );
  }
}

class InserimentoTesto extends StatefulWidget {
  InserimentoTesto({super.key, required this.title});

  final String title;

  @override
  _InserimentoTestoState createState() => _InserimentoTestoState();
}

class _InserimentoTestoState extends State<InserimentoTesto> {

  String numeroUtente = '';
  String nomeUtente = '';

  int? selectedId;
  //final textController = TextEditingController();

  List<TextEditingController> textController = List.generate(2, (int i) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child:
            ListView(
              padding: const EdgeInsets.only(top: 20, left:10 , right: 10),
              children: [
                const Text('NOME'),
                TextField(
                  autofocus: true,
                  controller: textController[0],
                  // onSubmitted: (String stringa) async{
                  //   await DBHelper.instance.add(
                  //     Operaio(nome: stringa, cognome: 'cognome')
                  //   );
                  // },
                ),
                const Divider(),
                const Text('COGNOME'),
                TextField(
                  controller: textController[1],
                  // onSubmitted: (String stringa) async{
                  //   await DBHelper.instance.add(
                  //     Operaio(nome: stringa, cognome: 'cognome')
                  //   );
                  // },
                ),
                const Divider(),
                FutureBuilder<List<Operaio>>(
                    future: DBHelper.instance.getOperai(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Operaio>> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Caricamento...'));
                      }
                      return snapshot.data!.isEmpty
                          ? const Center(child: Text('Nessun operaio in lista'))
                          : Column(
                        children: snapshot.data!.map((operaio) {
                          return Center(
                            child: Card(
                              color: selectedId == operaio.id
                                  ? Colors.white70
                                  : Colors.white,
                              child: ListTile(
                                title: Text(operaio.nome + ' ' + operaio.cognome),
                                onTap: () {
                                  setState(() {
                                    if (selectedId == null) {
                                      textController[0].text = operaio.nome;
                                      textController[1].text = operaio.cognome;
                                      selectedId = operaio.id;
                                    } else {
                                      textController[0].text = '';
                                      textController[1].text = '';
                                      selectedId = null;
                                    }
                                  });
                                },
                                onLongPress: () {
                                  setState(() {
                                    DBHelper.instance.remove(operaio.id!);
                                  });
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }),
              ],
            ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () async {
            selectedId != null
                ? await DBHelper.instance.update(
              Operaio(id: selectedId, nome: textController[0].text, cognome: textController[1].text),
            )
                : await DBHelper.instance.add(
              Operaio(nome: textController[0].text, cognome: textController[1].text),
            );
            setState(() {
              textController[0].clear();
              textController[1].clear();
              selectedId = null;
            });
          },
        ),
      ),
    );
  }
}
