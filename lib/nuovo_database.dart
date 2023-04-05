import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class RilievoTapparella {
  @required
  final int? id;
  String? cliente;
  String? cantiere;
  String? data;
  String? tipologiaInfisso;
  String? guide;
  String? colorazioneInt;
  String? colorazioneEst;
  String? listelliInt;
  String? listelliEst;
  double? larghezzaInfissi;
  double? altezzaInfissi;
  String? misureLuce;
  String? tipoTapparella;
  String? coloreTapparella;

  RilievoTapparella(
      {this.id,
      this.cliente,
      this.cantiere,
      this.data,
      this.tipologiaInfisso,
      this.guide,
      this.colorazioneInt,
      this.colorazioneEst,
      this.listelliInt,
      this.listelliEst,
      this.larghezzaInfissi,
      this.altezzaInfissi,
      this.misureLuce,
      this.tipoTapparella,
      this.coloreTapparella});

  factory RilievoTapparella.fromMap(Map<String, dynamic> json) =>
      RilievoTapparella(
        id: json['id'],
        cliente: json['cliente'],
        cantiere: json['cantiere'],
        data: json['data'],
        tipologiaInfisso: json['tipologiaInfisso'],
        guide: json['guide'],
        colorazioneInt: json['colorazioneInt'],
        colorazioneEst: json['colorazioneEst'],
        listelliInt: json['listelliInt'],
        listelliEst: json['listelliEst'],
        larghezzaInfissi: json['larghezzaInfissi'],
        altezzaInfissi: json['altezzaInfissi'],
        misureLuce: json['misureLuce'],
        tipoTapparella: json['tipoTapparella'],
        coloreTapparella: json['coloreTapparella'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cantiere': cantiere,
      'cliente': cliente,
      'data': data,
      'tipologiaInfisso': tipologiaInfisso,
      'guide': guide,
      'colorazioneInt': colorazioneInt,
      'colorazioneEst': colorazioneEst,
      'listelliInt': listelliInt,
      'listelliEst': listelliEst,
      'larghezzaInfissi': larghezzaInfissi,
      'altezzaInfissi': altezzaInfissi,
      'misureLuce': misureLuce,
      'tipoTapparella': tipoTapparella,
      'coloreTapparella': coloreTapparella
    };
  }

  RilievoTapparella.fromMapObject(Map<String, dynamic> mappaRilievoTapparelle)
      : id = mappaRilievoTapparelle['id'],
        cliente = mappaRilievoTapparelle['cliente'],
        cantiere = mappaRilievoTapparelle['cantiere'],
        data = mappaRilievoTapparelle['data'],
        tipologiaInfisso = mappaRilievoTapparelle['tipologiaInfisso'],
        guide = mappaRilievoTapparelle['guide'],
        colorazioneInt = mappaRilievoTapparelle['colorazioneInt'],
        colorazioneEst = mappaRilievoTapparelle['colorazioneEst'],
        listelliInt = mappaRilievoTapparelle['listelliInt'],
        listelliEst = mappaRilievoTapparelle['listelliEst'],
        larghezzaInfissi = mappaRilievoTapparelle['larghezzaInfissi'],
        altezzaInfissi = mappaRilievoTapparelle['altezzaInfissi'],
        misureLuce = mappaRilievoTapparelle['misureLuce'],
        tipoTapparella = mappaRilievoTapparelle['tipoTapparella'],
        coloreTapparella = mappaRilievoTapparelle['coloreTapparella'];

  @override
  String toString() {
    return 'RilievoTapparelle {id: $id, cliente: $cliente, cantiere: $cantiere, data: $data, tipologiaInfisso: $tipologiaInfisso, guide: $guide, colorazioneInt: $colorazioneInt, colorazioneEst: $colorazioneEst, listelliInt: $listelliInt, listelliEst: $listelliEst, larghezzaInfissi $larghezzaInfissi, altezzaInfissi: $altezzaInfissi, misureLuce: $misureLuce, tipoTapprella: $tipoTapparella, coloreTapparella: $coloreTapparella}';
  }
}

class RilievoPersiana {
  @required
  final int? id;
  String? cliente;
  String? destinazione;
  String? data;
  String? modelloPorta;
  String? modelloManiglia;
  String? finituraInterna;
  String? commerciale;
  String? ferramenta;

  RilievoPersiana(
      {this.id,
      this.cliente,
      this.destinazione,
      this.data,
      this.modelloPorta,
      this.modelloManiglia,
      this.finituraInterna,
      this.commerciale,
      this.ferramenta});

  factory RilievoPersiana.fromMap(Map<String, dynamic> json) => RilievoPersiana(
        id: json['id'],
        cliente: json['cliente'],
        destinazione: json['destinazione'],
        data: json['data'],
        modelloPorta: json['modelloPorta'],
        modelloManiglia: json['modelloManiglia'],
        finituraInterna: json['finituraInterna'],
        commerciale: json['commerciale'],
        ferramenta: json['ferramenta'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cliente': cliente,
      'destinazione': destinazione,
      'data': data,
      'modelloPorta': modelloPorta,
      'modelloManiglia': modelloManiglia,
      'finituraInterna': finituraInterna,
      'commerciale': commerciale,
      'ferramenta': ferramenta,
    };
  }

  RilievoPersiana.fromMapObject(Map<String, dynamic> mappaRilievoTapparelle)
      : id = mappaRilievoTapparelle['id'],
        cliente = mappaRilievoTapparelle['cliente'],
        destinazione = mappaRilievoTapparelle['destinazione'],
        data = mappaRilievoTapparelle['data'],
        modelloPorta = mappaRilievoTapparelle['modelloPorta'],
        modelloManiglia = mappaRilievoTapparelle['modelloManiglia'],
        finituraInterna = mappaRilievoTapparelle['finituraInterna'],
        commerciale = mappaRilievoTapparelle['commerciale'],
        ferramenta = mappaRilievoTapparelle['ferramenta'];

  @override
  String toString() {
    return 'RilievoPersiane {id: $id, cliente: $cliente, destinazione: $destinazione, data: $data, modelloPorta: $modelloPorta, modelloManiglia: $modelloManiglia, finituraInterna: $finituraInterna, commerciale: $commerciale, ferramenta: $ferramenta}';
  }
}

class Configurazione {
  @required
  final int? id;
  String? riferimento;
  int? quantita;
  double? larghezza;
  double? altezza;
  String? tipo;
  String? dxsx;
  String? vetro;
  String? telaio;
  double? larghezzaLuce;
  double? altezzaLuce;
  String? note;
  String? blob;
  String? disegno;
  final int? idParente;

  Configurazione({
    this.id,
    this.riferimento,
    this.quantita,
    this.larghezza,
    this.altezza,
    this.tipo,
    this.dxsx,
    this.vetro,
    this.telaio,
    this.larghezzaLuce,
    this.altezzaLuce,
    this.blob,
    this.disegno,
    this.note,
    required this.idParente,
  });

  factory Configurazione.fromMap(Map<String, dynamic> json) => Configurazione(
      id: json['id'],
      riferimento: json['riferimento'],
      quantita: json['quantita'],
      larghezza: json['larghezza'],
      altezza: json['altezza'],
      tipo: json['tipo'],
      dxsx: json['dxsx'],
      vetro: json['vetro'],
      telaio: json['telaio'],
      larghezzaLuce: json['larghezzaLuce'],
      altezzaLuce: json['altezzaLuce'],
      note: json['note'],
      blob: json['blob'],
      disegno: json['disegno'],
      idParente: json['idParente']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'riferimento': riferimento,
      'quantita': quantita,
      'larghezza': larghezza,
      'altezza': altezza,
      'tipo': tipo,
      'dxsx': dxsx,
      'vetro': vetro,
      'telaio': telaio,
      'larghezzaLuce': larghezzaLuce,
      'altezzaLuce': altezzaLuce,
      'note': note,
      'blob': blob,
      'disegno': disegno,
      'idParente': idParente,
    };
  }

  Configurazione.fromMapObject(Map<String, dynamic> mappaConfigurazione)
      : id = mappaConfigurazione['id'],
        riferimento = mappaConfigurazione['riferimento'],
        quantita = mappaConfigurazione['quantita'],
        larghezza = mappaConfigurazione['larghezza'],
        altezza = mappaConfigurazione['altezza'],
        tipo = mappaConfigurazione['tipo'],
        dxsx = mappaConfigurazione['dxsx'],
        vetro = mappaConfigurazione['vetro'],
        telaio = mappaConfigurazione['telaio'],
        larghezzaLuce = mappaConfigurazione['larghezzaLuce'],
        altezzaLuce = mappaConfigurazione['altezzaLuce'],
        note = mappaConfigurazione['note'],
        blob = mappaConfigurazione['blob'],
        disegno = mappaConfigurazione['disegno'],
        idParente = mappaConfigurazione['idParente'];

  @override
  String toString() {
    return 'ConfigurazioneInfissi {id: $id, riferimento: $riferimento, quantita: $quantita, larghezza: $larghezza, altezza: $altezza, tipo: $tipo, dxsx: $dxsx, vetro: $vetro, telaio: $telaio, larghezzaLuce: $larghezzaLuce, altezzaLuce: $altezzaLuce, note: $note, blob: $blob, disegno: $disegno, idParente: $idParente}';
  }
}

class DBHelper {
  DBHelper._privateConstructor();

  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await initDatabase();

  Database? getDatabase() {
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'rilievi.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tapparelle(
        id INTEGER PRIMARY KEY,
        cliente STRING,
        cantiere STRING,
        data STRING,
        tipologiaInfisso STRING,
        guide STRING,
        colorazioneInt STRING,
        colorazioneEst STRING,
        listelliInt STRING,
        listelliEst STRING,
        larghezzaInfissi REAL,
        altezzaInfissi REAL,
        misureLuce STRING,
        tipoTapparella STRING,
        coloreTapparella STRING
      )
      ''');

    await db.execute('''
      CREATE TABLE configurazioneTapparelle(
        id INTEGER PRIMARY KEY,
        riferimento STRING,
        quantita INT,
        larghezza REAL,
        altezza REAL,
        tipo STRING,
        dxsx STRING,
        vetro STRING,
        telaio STRING,
        larghezzaLuce REAL,
        altezzaLuce REAL,
        note STRING,
        idParente STRING,        
        disegno STRING,
        blob STRING
      )
      ''');

    await db.execute('''
      CREATE TABLE persiane(
        id INTEGER PRIMARY KEY,
        cliente STRING,
        destinazione STRING,
        data STRING,
        modelloPorta STRING,
        modelloManiglia STRING,
        finituraInterna STRING,
        commerciale STRING,
        ferramenta STRING
      )
      ''');

    await db.execute('''
      CREATE TABLE configurazionePersiane(
        id INTEGER PRIMARY KEY,
        riferimento STRING,
        quantita INT,
        larghezza REAL,
        altezza REAL,
        tipo STRING,
        dxsx STRING,
        vetro STRING,
        telaio STRING,
        larghezzaLuce REAL,
        altezzaLuce REAL,
        note STRING,
        idParente STRING,        
        disegno STRING,
        blob STRING        
      )
      ''');
  }

  Future<String> getDatabasePath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'rilievi.db');
    return path;
  }

  Future<List<RilievoTapparella>> getRilieviTapparelle() async {
    Database db = await instance.database;
    var rilieviTapparelle = await db.query('tapparelle', orderBy: 'id');
    List<RilievoTapparella> listaRilieviTapparelle = rilieviTapparelle
            .isNotEmpty
        ? rilieviTapparelle.map((c) => RilievoTapparella.fromMap(c)).toList()
        : [];
    return listaRilieviTapparelle;
  }

  Future<List<RilievoPersiana>> getRilieviPersiane() async {
    Database db = await instance.database;
    var rilieviPersiane = await db.query('persiane', orderBy: 'id');
    List<RilievoPersiana> listaRilieviPersiane = rilieviPersiane.isNotEmpty
        ? rilieviPersiane.map((c) => RilievoPersiana.fromMap(c)).toList()
        : [];
    return listaRilieviPersiane;
  }

  Future<List<Configurazione>> getConfigurazioni(
      String tipoConfigurazione) async {
    Database db = await instance.database;

    if (tipoConfigurazione.compareTo('persiane') == 0) {
      var configurazioniPersiane =
          await db.query('configurazionePersiane', orderBy: 'id');
      List<Configurazione> listaConfigurazioniPersiane =
          configurazioniPersiane.isNotEmpty
              ? configurazioniPersiane
                  .map((c) => Configurazione.fromMap(c))
                  .toList()
              : [];
      return listaConfigurazioniPersiane;
    } else if (tipoConfigurazione.compareTo('tapparelle') == 0) {
      var configurazioniTapparelle =
          await db.query('configurazioneTapparelle', orderBy: 'id');
      List<Configurazione> listaConfigurazioniTapparelle =
          configurazioniTapparelle.isNotEmpty
              ? configurazioniTapparelle
                  .map((c) => Configurazione.fromMap(c))
                  .toList()
              : [];
      return listaConfigurazioniTapparelle;
    }
    throw (0);
  }

  Future<RilievoTapparella?> getRilievoTapparella(int id) async {
    Database db = await instance.database;
    var result = await db.query('tapparelle', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return RilievoTapparella.fromMap(result.first);
    }
    return null;
  }

  Future<RilievoPersiana?> getRilievoPersiana(int id) async {
    Database db = await instance.database;
    var result = await db.query('persiane', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return RilievoPersiana.fromMap(result.first);
    }
    return null;
  }

  Future<Configurazione?> getConfigurazione(
      int id, String tipoConfigurazione) async {
    Database db = await instance.database;

    if (tipoConfigurazione.compareTo('persiane') == 0) {
      var result = await db
          .query('configurazionePersiane', where: 'id = ?', whereArgs: [id]);
      if (result.isNotEmpty) {
        return Configurazione.fromMap(result.first);
      }
    } else if (tipoConfigurazione.compareTo('tapparelle') == 0) {
      var result = await db
          .query('configurazioneTapparelle', where: 'id = ?', whereArgs: [id]);
      if (result.isNotEmpty) {
        return Configurazione.fromMap(result.first);
      }
    }
    return null;
  }

  Future<int> addTapparella(RilievoTapparella tapparella) async {
    Database db = await instance.database;
    return await db.insert('tapparelle', tapparella.toMap());
  }

  Future<int> addPersiana(RilievoPersiana persiana) async {
    Database db = await instance.database;
    return await db.insert('persiane', persiana.toMap());
  }

  Future<int> addConfigurazione(
      Configurazione configurazione, String tipoConfigurazione) async {
    Database db = await instance.database;
    if (tipoConfigurazione.compareTo('persiane') == 0) {
      return await db.insert('configurazionePersiane', configurazione.toMap());
    } else if (tipoConfigurazione.compareTo('tapparelle') == 0) {
      return await db.insert(
          'configurazioneTapparelle', configurazione.toMap());
    }
    return 0;
  }

  Future<int> removeTapparella(int id) async {
    Database db = await instance.database;
    return await db.delete('tapparelle', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> removePersiane(int id) async {
    Database db = await instance.database;
    return await db.delete('persiane', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> removeConfigurazione(int id, String tipoConfigurazione) async {
    Database db = await instance.database;
    if (tipoConfigurazione.compareTo('persiane') == 0) {
      return await db
          .delete('configurazionePersiane', where: 'id = ?', whereArgs: [id]);
    } else if (tipoConfigurazione.compareTo('tapparelle') == 0) {
      return await db
          .delete('configurazioneTapparelle', where: 'id = ?', whereArgs: [id]);
    }
    return 0;
  }

  Future<int> removeMoreConfigurazione(
      int idPadre, String tipoConfigurazione) async {
    Database db = await instance.database;
    if (tipoConfigurazione.compareTo('persiane') == 0) {
      return await db.delete('configurazionePersiane',
          where: 'idPadre = ?', whereArgs: [idPadre]);
    } else if (tipoConfigurazione.compareTo('tapparelle') == 0) {
      return await db.delete('configurazioneTapparelle',
          where: 'idPadre = ?', whereArgs: [idPadre]);
    }
    return 0;
  }

  Future<int> updateTapparella(RilievoTapparella tapparella) async {
    Database db = await instance.database;
    return await db.update('tapparelle', tapparella.toMap(),
        where: 'id = ?', whereArgs: [tapparella.id]);
  }

  Future<int> updatePersiana(RilievoPersiana persiana) async {
    Database db = await instance.database;
    return await db.update('persiane', persiana.toMap(),
        where: 'id = ?', whereArgs: [persiana.id]);
  }

  Future<int> updateConfigurazione(
      Configurazione configurazione, String tipoConfigurazione) async {
    Database db = await instance.database;
    if (tipoConfigurazione.compareTo('persiane') == 0) {
      return await db.update('configurazionePersiane', configurazione.toMap(),
          where: 'id = ?', whereArgs: [configurazione.id]);
    } else if (tipoConfigurazione.compareTo('tapparelle') == 0) {
      return await db.update('configurazioneTapparelle', configurazione.toMap(),
          where: 'id = ?', whereArgs: [configurazione.id]);
    }
    return 0;
  }

  Future<int> deleteTableContent(String tableName) async {
    Database db = await instance.database;
    return await db.delete(tableName);
  }

  Future<int?> tableIsEmpty(String tableName) async {
    Database db = await instance.database;
    int? count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
    return (count);
  }
}
