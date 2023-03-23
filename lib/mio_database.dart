import 'dart:io';
//import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Rilievo {
  @required
  final int? id;
  //@required
  String? nome;
  //@required
  String? cognome;

  String? blob;

  //costrutore
  Rilievo({this.id, this.nome, this.cognome, this.blob});

  factory Rilievo.fromMap(Map<String, dynamic> json) => Rilievo(
    id: json['id'],
    nome: json['name'],
    cognome: json['cognome'],
    blob: json['foto'],
  );

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'name': nome,
      'cognome': cognome,
      'foto': blob,
    };
  }

  Rilievo.fromMapObject(Map<String, dynamic> mappaRilievo)
      : id = mappaRilievo['id'],
        nome = mappaRilievo['name'],
        cognome = mappaRilievo['cognome'],
        blob = mappaRilievo['foto'];

  @override
  String toString(){
    return 'Rilievo{id: $id, name: $nome, cognome: $cognome, foto: $blob}';
  }
}

class DBHelper{
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  String tableName = 'rilievi';

  Future<Database> _initDatabase() async {
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
        foto TEXT
      )
    ''');
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

  // Future<int> addPhoto() async {
  //   Database db = await instance.database;
  //   return await db.update(tableName, );
  // }
}