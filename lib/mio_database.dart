import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Operaio {
  @required
  final int id;
  @required
  String nome;
  @required
  String cognome;

  //costrutore
  Operaio(this.id, this.nome, this.cognome);

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'nome': nome,
      'cognome': cognome,
    };
  }

  Operaio.fromMapObject(Map<String, dynamic> mappaOperai)
      : id = mappaOperai['id'],
        nome = mappaOperai['nome'],
        cognome = mappaOperai['cognome'];

  @override
  String toString(){
    return 'Operaio{id: $id, nome: $nome, cognome: $cognome}';
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
        name TEXT
      )
    ''');
  }

  Future<List<Operaio>> getOperai() async {
    Database db = instance.database;
    var operai = db.query('operai', orderBy: 'name');
    List<Operaio> listaOperai = operai.isNotEmpty;

  }
}