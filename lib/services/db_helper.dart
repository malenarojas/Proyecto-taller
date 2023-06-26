import 'package:sqflite/sqflite.dart' as sql;
import 'dart:async';


class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE Incidencias(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      descripcion TEXT NOT NULL,
      estado TEXT NOT NULL,
      fecha_creacion DATE NOT NULL,
      id_usuario INTEGER NOT NULL,
      latitud_dispositivo FLOAT NOT NULL,
      longitud_dispositivo FLOAT NOT NULL,
      createdAt TIMESTAMP NOT NULL DEFAULT CONCURRENT_TIMESTAMP
      u
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("database_name.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }
 /* static Future<int> createIncidencias('Incidencias')async{
    final db= await SQLHelper.db();
    final Incidencias= {'descripcion':descripcion,'estado':estado,'fecha_creaacion':fecha_creacion,'id_usuario':id_usuario,'latitud_dispositivo':latitud_dispositivo,'longitud_dispositivo':longitud_dispositivo
    };
    final id = await db.insert('Incidencias',Incidencias,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }*/

  static Future<List<Map<String, dynamic>>> getallIncidencias() async {
    final db = await SQLHelper.db();
    return db.query('data', orderBy: 'id');
  }

  static Future<int> updateIncidencias(int id, String descripcion, String? estado,String fecha_creacion) async {
    final db = await SQLHelper.db();
    final Incidencias = {
      'descripcion': descripcion,
      'estado': estado,
      'fecha_creacion':fecha_creacion,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('Incidencias', Incidencias, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteIncidencias(int id) async {
    final db = await SQLHelper.db();
    try{
      await db.delete('data',where: "id = ?",whereArgs: [id]);
    }catch (e){}
  }
}
