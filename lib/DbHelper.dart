import 'dart:async';

import 'package:littlewords/word_dto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DbHelper{
  static const dbName = 'littlewords.db';  //nom du shema
  static const dbPathName = 'littlewords.path'; //nom du fichier sur le tel
  static const dbVersion = 1; // numéro de la version du shema (pour upgrade)

  //instance de la connexion à la bdd
  static Database? _database;

  //Constructeur de DbHelper
  DbHelper._privateConstructeur();
  static final DbHelper instance = DbHelper._privateConstructeur();

  // Getter de database avec init si neccessaire
  Future<Database> get database async => _database ??= await _init();

  // Initialisation de database
  Future<Database> _init() async{
    // On utilise path pour récupérer un emplacement de stockage
    final String dbPath = await getDatabasesPath();

    // On ouvre la connexion
    return await openDatabase(
        join(dbPath, dbPathName),
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        version: dbVersion);
  }


  ///Déclenché lorsque la base de données n'existe pas sur le device
  FutureOr<void> _onCreate(Database db, int version){
    const String createWordsTableQuery =
        'CREATE TABLE words (uid integer PRIMARY KEY AUTOINCREMENT,content VARCHAR(200) NOT NULL)';
    db.execute(createWordsTableQuery);
  }

  ///Déclenché lorsque le numéro de version est augmenté
  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion){
    const String dropWordsTableQuery = 'DROP TABLE IF EXISTS words';
    db.execute(dropWordsTableQuery);
    _onCreate(db, newVersion);
  }


  Future<void> insert(final WordDTO wordDTO) async{
    Database db = await instance.database;
    final String insertWord =
        "INSERT into words(content) values ('${wordDTO.content}')";
    return db.execute(insertWord);
  }





}