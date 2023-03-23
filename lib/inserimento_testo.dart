import 'package:applicazione_prova/mio_database.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'mio_database.dart';
//import 'database.dart';
//import 'article_repository.dart';

Future main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'TITOLO APPLICAZIONE',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: (Colors.green)),
      useMaterial3: true,
    ),
    home: InserimentoTesto(title: 'Nome Applicazione',),
  ));
  //await DBHelper().initDatabase();
  //Future pathDatabase = DBHelper().getDatabasePath('personale');
  //print(db);
  //InserimentoTesto.inserimenti()
  //print(InserimentoTesto.inserimenti());
}

// class Database {
//   // Open the database and store the reference.
//   final database = openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//       join(getDatabasesPath() as String, 'local_database.db'),
//   // When the database is first created, create a table to store dogs.
//       onCreate: (db, version) {
//   // Run the CREATE TABLE statement on the database.
//   return db.execute(
//   'CREATE TABLE utenti(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
//   );
// },
// // Set the version. This executes the onCreate function and provides a
// // path to perform database upgrades and downgrades.
// version: 1,
// );
//
// Future<void> insertStringa(Utente utente) async {
//
//   final db = await database;
//
//   await db.insert(
//     'utenti',
//     utente.toMap(),
//     conflictAlgorithm: ConflictAlgorithm.replace,
//   );
// }
//
// Future<List<Utente>> utenti() async {
//   final db = await database;
//
//   // Query the table for all The utenti.
//   final List<Map<String, dynamic>> maps = await db.query('utenti');
//
//   return List.generate(maps.length, (i){
//     return Utente(
//       id: maps[i]['id'],
//       nome: maps[i]['nome'],
//     );
//   });
// }
//
// Future<void> updateUtente(Utente utente) async {
//   final db = await database;
//
//   await db.update(
//       'utenti',
//       utente.toMap(),
//       where: 'id = ?',
//       whereArgs: [utente.id]
//   );
// }
//
// Future<void> deleteUtente(int id) async {
//   final db = await database;
//
//   await db.delete(
//     'utenti',
//     where: 'id = ?',
//     whereArgs: [id],
//   );
// }
// }

// class Utente {
//
//   final int id;
//   final String nome;
//
//   const Utente({
//     required this.id,
//     required this.nome,
// });
//
//   Map<String, dynamic> toMap(){
//     return{
//       'id': id,
//       'nome': nome,
//     };
//   }
//
//   @override
//   String toString() {
//     return 'Utente{id:$id, nome: $nome}';
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'HELLO WORLD',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//         useMaterial3: true,
//       ),
//       home: InserimentoTesto(title: "Nome Applicazione"),
//     );
//   }
// }

class InserimentoTesto extends StatefulWidget {
  InserimentoTesto({super.key, required this.title});

  final String title;

  @override
  _InserimentoTestoState createState() => _InserimentoTestoState();

  //Future db = DBHelper().initDatabase();

  // static String inserimenti(String stringa) {
  //   return stringa;
  // }

}

class _InserimentoTestoState extends State<InserimentoTesto> {

  //late TextEditingController _controller;
  String numeroUtente = '';
  String nomeUtente = '';

  int? selectedId;
  final textController = TextEditingController();


  // @override
  // void initState() {
  //   super.initState();
  //   _controller = TextEditingController();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 20, left:10 , right: 10),
          children: <Widget>[
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "SCRIVI QUI:",
                textAlign: TextAlign.left,
              ),
              TextField(
                controller: textController,
                //scrollPadding: EdgeInsets.zero,
                autofocus: true,
                //decoration:,
                onSubmitted: (String stringa) async {
                  await DBHelper.instance.add(
                      Rilievo(nome: stringa, cognome: 'cognome')
                  );
                  context: context;
                  setState(() {
                    nomeUtente = stringa;
                    //Article articolo = Article(0, nomeUtente, 'pippo');
                    //ArticleRepository.addArticle(articolo);
                    //ArticleRepository.printDatabase();
                    //InserimentoTesto.inserimenti(nomeUtente);
                  });
                },
              ),
              Text(
                  nomeUtente
              ),
              const Divider(),
              const Text(
                "SCRIVI QUI:",
                textAlign: TextAlign.left,
              ),
              TextField(
                //scrollPadding: EdgeInsets.zero,
                autofocus: true,
                //decoration:,
                onSubmitted: (String stringa){
                  context: context;
                  setState(() {
                    numeroUtente = stringa;
                    //InserimentoTesto.inserimenti(numeroUtente);
                  });
                },
              ),
              Text(
                  numeroUtente
              ),
              const Divider(),
              const Text(
                "SCRIVI QUI:",
                textAlign: TextAlign.left,
              ),
              TextField(
                //scrollPadding: EdgeInsets.zero,
                autofocus: true,
                //decoration:,
                onSubmitted: (String stringa){
                  context: context;
                  setState(() {
                    numeroUtente = stringa;
                    //InserimentoTesto.inserimenti(numeroUtente);
                  });
                },
              ),
              Text(
                  numeroUtente
              ),
              const Divider(),
              const Text(
                "SCRIVI QUI:",
                textAlign: TextAlign.left,
              ),
              TextField(
                //scrollPadding: EdgeInsets.zero,
                autofocus: true,
                //decoration:,
                onSubmitted: (String stringa){
                  context: context;
                  setState(() {
                    numeroUtente = stringa;
                  });
                },
              ),
              Text(
                  numeroUtente
              ),
              const Divider(),
              const Text(
                  "SCRIVI QUI:"
              ),
              TextField(
                //scrollPadding: const EdgeInsets.all(50),
                onSubmitted: (String stringa){
                  context: context;
                  setState(() {
                    nomeUtente = stringa;
                  }
                  );
                },
              ),
              Text(
                  nomeUtente
              ),
            ],
          ),
            FutureBuilder<List<Rilievo>>(
              future: DBHelper.instance.getRilievi(),
                builder: (BuildContext context, AsyncSnapshot<List<Rilievo>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text('Caricamento ...'));
                  }
                  return snapshot.data!.isEmpty
                    ? Center(child: Text('Nessun operaio in lista.'),)
                    : ListView(
                      children: snapshot.data!.map((operaio) {
                        return Center(
                          child: ListTile(
                            title: Text(operaio.nome),
                          ),
                        );
                      }).toList(),
                    );
                }
            ),
          ]
        )
    );
  }
}
