
// 1.Create a private constructor that can be used only inside the class :
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:path/path.dart';
import '../model/client.dart';



class DB_Provider {

  final String _databaseName="TestDB.db";
  //private constructor
  DB_Provider._();
  // here instance claa the private constructor
  static final DB_Provider db = DB_Provider._();

  // private object of db
   Database __database;

   Future<Database> get _database async {
    if (__database != null)
      return __database;

    // if _database is null we instantiate it
    __database = await initDB();
    return __database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return
      await
      openDatabase(path,
          version: 1,
          onOpen: (db) {},
          onCreate: (Database db, int version)
          async {
                    await db.execute("CREATE TABLE Client ("
                        "id INTEGER PRIMARY KEY,"
                        "first_name TEXT,"
                        "last_name TEXT "
                        ")");
                }
      );
  }

   // row
/*  newClient(Client newClient) async {
    final db = await _database;
    var res = await db.rawInsert(
        "INSERT Into Client (id,first_name)"
            " VALUES (${newClient.id},${newClient.firstName})");
    return res;
  }*/

  newClient(Client newClient) async {
    final db = await _database;
    var res = await db.insert("Client", newClient.toMap());
    print("client data inseted log status ${res}");

  }

  Future<List<Client>>getAllClients() async {
    final db = await _database;
    var res = await db.query("Client");
    List<Client> list =
    res.isNotEmpty ?
    res.map(    (c)
              => Client.fromMap(c)
    ).toList()
        : [];
    return list;
  }

  deleteClient(int id) async {
    final db = await _database;
    db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

}

