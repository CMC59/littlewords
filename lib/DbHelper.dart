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

  Future<int> countWords() async {
    final Database db = await instance.database;
    var res = await db.rawQuery("SELECT count(*) from words");
    var count = Sqflite.firstIntValue(res);
    return Future.value(count);
  }
  /// Permet de récupérer la liste complete des mots détenus
  Future<List<WordDTO>> getAllWords() async {
    // Récupération instance de la db
    final Database db = await instance.database;

    // execution query
    final resultSet =
        await db.rawQuery("SELECT * from words");

    // On initialise une liste de mot vide
    final List<WordDTO> results = <WordDTO>[];

    // On parcours les résultats
    for (var r in resultSet) {
      // on instancie un WordDTO sur la base de r
      var word = WordDTO.fromMap(r);
      // on l'ajoute dans la liste de resultat
      results.add(word);
    }
    // On retourne la liste des résultats
    return Future.value(results);
  }




}