import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Operaio {
  @required
  final int? id;
  @required
  String nome;
  @required
  String cognome;

  //costrutore
  Operaio({this.id, required this.nome, required this.cognome});

  factory Operaio.fromMap(Map<String, dynamic> json) => Operaio(
    id: json['id'],
    nome: json['name'],
    cognome: json['cognome'],
  );

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'name': nome,
      'cognome': cognome,
    };
  }

  Operaio.fromMapObject(Map<String, dynamic> mappaOperai)
      : id = mappaOperai['id'],
        nome = mappaOperai['name'],
        cognome = mappaOperai['cognome'];

  @override
  String toString(){
    return 'Operaio{id: $id, name: $nome, cognome: $cognome}';
  }
}

class DBHelper{
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'operai.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE operai(
        id INTEGER PRIMARY KEY,
        name TEXT,
        cognome TEXT,
        foto BLOB
      )
    ''');
  }

  Future<List<Operaio>> getOperai() async {
    Database db = await instance.database;
    var operai = await db.query('operai', orderBy: 'name');
    List<Operaio> listaOperai = operai.isNotEmpty
      ? operai.map((c) => Operaio.fromMap(c)).toList()
        : [];
    return listaOperai;
  }

  Future<int> add(Operaio operaio) async {
    Database db = await instance.database;
    return await db.insert('operai', operaio.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('operai', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Operaio operaio) async {
    Database db = await instance.database;
    return await db.update('operai', operaio.toMap(), where: 'id = ?', whereArgs: [operaio.id]);
  }

  Future<int> deleteAll() async {
    Database db = await instance.database;
    return await db.delete('operai');
  }
}