import 'dart:io';

//import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Rilievo {
  @required
  final int? id;
  //@required
  String? nome;
  //@required
  String? cognome;
  String? note;
  String? blob;
  String? disegno;


  //costrutore
  Rilievo({this.id, this.nome, this.cognome, this.blob, this.disegno, this.note});

  factory Rilievo.fromMap(Map<String, dynamic> json) => Rilievo(
    id: json['id'],
    nome: json['name'],
    cognome: json['cognome'],
    blob: json['foto'],
    disegno: json['disegno'],
    note: json['note'],
  );

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'name': nome,
      'cognome': cognome,
      'foto': blob,
      'disegno': disegno,
      'note': note,
    };
  }

  Rilievo.fromMapObject(Map<String, dynamic> mappaRilievo)
      : id = mappaRilievo['id'],
        nome = mappaRilievo['name'],
        cognome = mappaRilievo['cognome'],
        blob = mappaRilievo['foto'],
        disegno = mappaRilievo['disegno'],
        note = mappaRilievo['note'];

  @override
  String toString(){
    return
      'Rilievo{id: $id, name: $nome, cognome: $cognome, foto: $blob, disegno: $disegno, note: $note}';
  }
}

class DBHelper{
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDatabase();

  String tableName = 'rilievi';

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'rilievi.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE rilievi(
        id INTEGER PRIMARY KEY,
        name TEXT,
        cognome TEXT,
        note TEXT,
        foto TEXT,
        disegno TEXT
      )
    ''');
  }

  Future<String> getDatabasePath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'rilievi.db');
    return path;
  }

  Future<List<Rilievo>> getRilievi() async {
    Database db = await instance.database;
    var rilievi = await db.query(tableName, orderBy: 'name');
    List<Rilievo> listaRilievi = rilievi.isNotEmpty
      ? rilievi.map((c) => Rilievo.fromMap(c)).toList()
        : [];
    return listaRilievi;
  }

  Future<Rilievo?> getRilievo(int id) async {
    Database db = await instance.database;
    var result = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Rilievo.fromMap(result.first);
    }
    return null;
  }

  Future<int> add(Rilievo rilievo) async {
    Database db = await instance.database;
    return await db.insert(tableName, rilievo.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Rilievo rilievo) async {
    Database db = await instance.database;
    return await db.update(tableName, rilievo.toMap(), where: 'id = ?', whereArgs: [rilievo.id]);
  }

  Future<int> deleteAll() async {
    Database db = await instance.database;
    return await db.delete(tableName);
  }

  Future<int?> tableIsEmpty() async {
    Database db = await instance.database;
    int? count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM rilievi'));
    return(count);
  }

  // Future<int> addPhoto() async {
  //   Database db = await instance.database;
  //   return await db.update(tableName, );
  // }
}