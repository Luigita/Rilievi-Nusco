//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Article {
  @required
  final int id;
  @required
  String title;
  @required
  String author;
  Article(this.id, this.title, this.author);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
    };
  }
  Article.fromMapObject(Map<String, dynamic> authorMap)
      : id = authorMap['id'],
        title = authorMap['title'],
        author = authorMap['author'];
  @override
  String toString() {
    return 'Article{id: $id, title: $title, author: $author}';
  }
}
Database? db;
//Database db
class DBHelper {
  static const dbName = 'personale';
  static const articlesTable = 'articles';
  static const id = 'id';
  static const title = 'title';
  static const author = 'author';
  Future<void> createArticleTable(Database db) async {
    final todoSql = '''CREATE TABLE $articlesTable (
      $id INTEGER PRIMARY KEY,
      $title TEXT,
      $author TEXT)''';
    await db.execute(todoSql);
  }
  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);
    if (await Directory(dirname(path)).exists()) {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }
  Future<void> initDatabase() async {
    final path = await getDatabasePath(dbName);
    await openDatabase(path, version: 1, onCreate: onCreate);
    print(path);
  }
  Future<void> onCreate(Database db, int version) async {
    await createArticleTable(db);
  }
}
// class ArticleRepository{
//   static Future<void> addArticle(Database db, Article article) async {
//     await db.insert(DBHelper.articlesTable, article.toMap(),
//     conflictAlgorithm: ConflictAlgorithm.replace);
//   }
// }
class ArticleRepository{
  static Future<void> addArticle (Article article) async {
    await db.insert(
        DBHelper.title,
        article.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    await db.query(DBHelper.articlesTable);
  }
  Future<void> getCountries() async {
    List<Map> list = await db.rawQuery('SELECT * FROM Article');
    print(list);
    //return list.map((articles) => Article.fromMapObject(DBHelper.articlesTable)).toList();
  }
}



