import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class databaseConfig {

  Future<Database>? database;

  databaseConfig(){
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    database = initDatabase();
  }

  Future<Database> initDatabase() async {
    database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'saving_tools_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE Invoice(id INTEGER PRIMARY KEY, invoice TEXT, date TEXT, category TEXT, type TEXT, amount REAL)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
    return database!;
  }

  Future<Database> getDatabase() async {
    return await database!;
  }
}