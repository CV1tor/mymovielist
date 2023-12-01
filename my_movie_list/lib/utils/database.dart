import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class Database {

  static Future<sql.Database> database() async {
    final caminhoDatabase = await sql.getDatabasesPath();

    return await sql.openDatabase(
      path.join(caminhoDatabase, 'filmes.db'),
      version: 4,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE filme (id INTEGER PRIMARY KEY, titulo TEXT, banner TEXT )'
        );
        await db.execute(
          'CREATE TABLE imagem (id INTEGER PRIMARY KEY, url TEXT, filme_id INTEGER NOT NULL, FOREIGN KEY(filme_id) REFERENCES filme (id) ON DELETE NO ACTION ON UPDATE NO ACTION)'
        );
        await db.execute(
          'CREATE TABLE genero (id INTEGER PRIMARY KEY, titulo TEXT)'
        );
        await db.execute (
          'CREATE TABLE filme_genero (id INTEGER PRIMARY KEY, filme_id INTEGER NOT NULL, genero_id INTEGER NOT NULL, FOREIGN KEY (filme_id) REFERENCES filme (id) ON DELETE NO ACTION ON UPDATE NO ACTION, FOREIGN KEY (genero_id) REFERENCES genero (id) ON DELETE NO ACTION ON UPDATE NO ACTION)'
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < newVersion) {
          print('\n NOVA VERSAO \n');
          await db.execute('''
            CREATE TABLE genero (id INTEGER PRIMARY KEY, titulo TEXT, filme_id INTEGER NOT NULL, FOREIGN KEY(filme_id) REFERENCES filme(id) ON DELETE NO ACTION ON UPDATE NO ACTION);
            
            ''');
        }
      },
      
    );
  }

  static Future<void> insert(String tabela, Map<String, Object> dados) async {
    final database = await Database.database();
    await database.insert (
      tabela,
      dados,
      conflictAlgorithm: sql.ConflictAlgorithm.replace

    );
  }

  static Future<void> delete(String tabela, int id) async {
    final database = await Database.database();
    await database.delete(
      tabela,
      where: "id = ?", whereArgs:[id]
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String tabela) async {
    final database = await Database.database();
    return database.query(tabela);
  }





  
}