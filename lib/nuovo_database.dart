import 'dart:io';

import 'package:applicazione_prova/rilievo_persiane.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:sqflite_common_porter/sqflite_porter.dart';
import 'utils_csv.dart';

int posizioni = 0;

class RilievoTapparella {
  late int posizioni = 0;
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
  String? larghezzaInfissi;
  String? altezzaInfissi;
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
        cliente: json['cliente'].toString(),
        cantiere: json['cantiere'].toString(),
        data: json['data'].toString(),
        tipologiaInfisso: json['tipologiaInfisso'].toString(),
        guide: json['guide'].toString(),
        colorazioneInt: json['colorazioneInt'].toString(),
        colorazioneEst: json['colorazioneEst'].toString(),
        listelliInt: json['listelliInt'].toString(),
        listelliEst: json['listelliEst'].toString(),
        larghezzaInfissi: json['larghezzaInfissi'],
        altezzaInfissi: json['altezzaInfissi'],
        misureLuce: json['misureLuce'].toString(),
        tipoTapparella: json['tipoTapparella'].toString(),
        coloreTapparella: json['coloreTapparella'].toString(),
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
  late int posizioni = 0;
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
        cliente: json['cliente'].toString(),
        destinazione: json['destinazione'].toString(),
        data: json['data'].toString(),
        modelloPorta: json['modelloPorta'].toString(),
        modelloManiglia: json['modelloManiglia'].toString(),
        finituraInterna: json['finituraInterna'].toString(),
        commerciale: json['commerciale'].toString(),
        ferramenta: json['ferramenta'].toString(),
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
  double? larghezzaCassonetto = 0;
  double? altezzaCassonetto = 0;
  double? spessoreCassonetto = 0;
  double? profonditaCielino = 0;
  String? note;
  String? blob;
  String? disegno;
  String? audioVideo;
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
    this.larghezzaCassonetto,
    this.altezzaCassonetto,
    this.spessoreCassonetto,
    this.profonditaCielino,
    this.blob,
    this.disegno,
    this.note,
    this.audioVideo,
    required this.idParente,
  });

  factory Configurazione.fromMap(Map<String, dynamic> json) => Configurazione(
      id: json['id'],
      riferimento: json['riferimento'].toString(),
      quantita: json['quantita'],
      larghezza: json['larghezza'],
      altezza: json['altezza'],
      tipo: json['tipo'].toString(),
      dxsx: json['dxsx'].toString(),
      vetro: json['vetro'].toString(),
      telaio: json['telaio'].toString(),
      larghezzaLuce: json['larghezzaLuce'],
      altezzaLuce: json['altezzaLuce'],
      larghezzaCassonetto: json['larghezzaCassonetto'],
      altezzaCassonetto: json['altezzaCassonetto'],
      spessoreCassonetto: json['spessoreCassonetto'],
      profonditaCielino: json['profonditaCielino'],
      note: json['note'].toString(),
      blob: json['blob'],
      disegno: json['disegno'],
      audioVideo: json['audioVideo'],
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
      'larghezzaCassonetto': larghezzaCassonetto,
      'altezzaCassonetto': altezzaCassonetto,
      'spessoreCassonetto': spessoreCassonetto,
      'profonditaCielino': profonditaCielino,
      'note': note,
      'blob': blob,
      'disegno': disegno,
      'audioVideo': audioVideo,
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
        larghezzaCassonetto = mappaConfigurazione['larghezzaCassonetto'],
        altezzaCassonetto = mappaConfigurazione['altezzaCassonetto'],
        spessoreCassonetto = mappaConfigurazione['spessoreCassonetto'],
        profonditaCielino = mappaConfigurazione['profonditaCielino'],
        note = mappaConfigurazione['note'],
        blob = mappaConfigurazione['blob'],
        disegno = mappaConfigurazione['disegno'],
        audioVideo = mappaConfigurazione['audioVideo'],
        idParente = mappaConfigurazione['idParente'];

  @override
  String toString() {
    return 'Configurazione Infissi {id: $id, riferimento: $riferimento, quantita: $quantita, larghezza: $larghezza, altezza: $altezza, tipo: $tipo, dxsx: $dxsx, vetro: $vetro, telaio: $telaio, larghezzaLuce: $larghezzaLuce, altezzaLuce: $altezzaLuce, larghezzaCassonetto: $larghezzaCassonetto, altezzaCassonetto: $altezzaCassonetto, spessoreCassonetto: $spessoreCassonetto, profonditaCielino: $profonditaCielino, note: $note, blob: $blob, disegno: $disegno, audioVideo: $audioVideo, idParente: $idParente}';
  }

  List<String> toStringFormatted() {
    return [("Riferimento: $riferimento \n"),
        ("Quantita: $quantita \n"),
        ("Larghezza: $larghezza \n"),
        ("Altezza: $altezza \n"),
        ("Tipo: $tipo \n"),
        ("Dxsx: $dxsx \n"),
        ("Vetro: $vetro \n"),
        ("Telaio: $telaio \n"),
        ("Larghezza luce: $larghezzaLuce \n"),
        ("Altezza luce: $altezzaLuce \n"),
        ("Larghezza cassonetto: $larghezzaCassonetto \n"),
        ("Altezza cassonetto: $altezzaCassonetto \n"),
        ("Spessore cassonetto: $spessoreCassonetto \n"),
        ("Profondita cielino: $profonditaCielino \n"),
        ("Note: $note")];
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
        larghezzaInfissi STRING,
        altezzaInfissi STRING,
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
        larghezzaCassonetto REAL,
        altezzaCassonetto REAL,
        spessoreCassonetto REAL,
        profonditaCielino REAL,
        note STRING,
        idParente STRING,        
        disegno STRING,
        audioVideo STRING,
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
        larghezzaCassonetto REAL,
        altezzaCassonetto REAL,
        spessoreCassonetto REAL,
        profonditaCielino REAL,
        note STRING,
        idParente STRING,        
        disegno STRING,
        audioVideo STRING,
        blob STRING        
      )
      ''');
  }

  Future<List<String>> exportDatabase() async {
    Database db = await instance.database;

    DateTime now = DateTime.now();
    String date = "${now.day}-${now.month}-${now.year}";

    ///directory dell'app
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    //var export = await dbExportSql(db);

    var resultPersiane = await db.query('persiane');
    var resultTapparelle = await db.query('tapparelle');
    var resultConfigurazioneP = await db.query('configurazionePersiane');
    var resultConfigurazioneT = await db.query('configurazioneTapparelle');

    var csvPersiane = mapListToCsv(resultPersiane);
    var csvTapparelle = mapListToCsv(resultTapparelle);
    var csvConfigurazioneP = mapListToCsv(resultConfigurazioneP);
    var csvConfigurazioneT = mapListToCsv(resultConfigurazioneT);

    var csvPersianePath = '$path/persiane.csv';
    var csvTapparellePath = '$path/tapparelle.csv';
    var csvConfigurazionePPath = '$path/configurazionePersiane.csv';
    var csvConfigurazioneTPath = '$path/configurazioneTapparelle.csv';

    var zipDatabasePath = '$path/rilevi-$date.zip';

    await File(csvPersianePath).writeAsString(csvPersiane!);
    await File(csvTapparellePath).writeAsString(csvTapparelle!);
    await File(csvConfigurazionePPath).writeAsString(csvConfigurazioneP!);
    await File(csvConfigurazioneTPath).writeAsString(csvConfigurazioneT!);

    var encoder = ZipFileEncoder();
    encoder.create(zipDatabasePath);

    /// if (!resultConfigurazioneT.isempty) per evitare csv vuoti che danno problemi con convertitore python
    if (resultPersiane.isNotEmpty) {
      encoder.addFile(File(csvPersianePath));
    }
    if (resultTapparelle.isNotEmpty) {
      encoder.addFile(File(csvTapparellePath));
    }
    if (resultConfigurazioneP.isNotEmpty) {
      encoder.addFile(File(csvConfigurazionePPath));
    }
    if (resultConfigurazioneT.isNotEmpty) {
      encoder.addFile(File(csvConfigurazioneTPath));
    }

    encoder.close();

    Share.shareXFiles([
      XFile(zipDatabasePath)
    ]);

    List<String> paths = [
      '$path/persiane.csv',
      '$path/tapparelle.csv',
      '$path/configurazionePersiane.csv',
      '$path/configurazioneTapparelle.csv'
    ];

    return paths;
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

  Future<Configurazione> getConfigurazione(
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
    throw (e) {
      print('error');
    };
    //return null;
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
    await db.delete('tapparelle', where: 'id = ?', whereArgs: [id]);
    return await DBHelper.instance
        .removeMoreConfigurazione(id, 'configurazioneTapparelle');
  }

  Future<int> removePersiana(int id) async {
    Database db = await instance.database;
    await db.delete('persiane', where: 'id = ?', whereArgs: [id]);
    return await DBHelper.instance
        .removeMoreConfigurazione(id, 'configurazionePersiane');
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
      int idParente, String tipoConfigurazione) async {
    Database db = await instance.database;
    if (tipoConfigurazione.compareTo('configurazionePersiane') == 0) {
      return await db.delete('configurazionePersiane',
          where: 'idParente = ?', whereArgs: [idParente]);
    } else if (tipoConfigurazione.compareTo('configurazioneTapparelle') == 0) {
      return await db.delete('configurazioneTapparelle',
          where: 'idParente = ?', whereArgs: [idParente]);
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
  
  Future<int> contaPosizioniPersiane(String tableName, RilievoPersiana rilievoPersiana) async {
    Database db = await instance.database;
    var result = await db.query(tableName, where: 'idParente = ${rilievoPersiana.id}');
    return rilievoPersiana.posizioni = result.length;
  }
  Future<int> contaPosizioniTapparelle(String tableName, RilievoTapparella rilievoTapparelle) async {
    Database db = await instance.database;
    var result = await db.query(tableName, where: 'idParente = ${rilievoTapparelle.id}');
    return rilievoTapparelle.posizioni = result.length;
  }
}
