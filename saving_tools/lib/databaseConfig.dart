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

    onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      
      db.execute("CREATE TABLE Invoice(id INTEGER PRIMARY KEY, invoice TEXT, date TEXT, category TEXT, type TEXT, amount REAL, user_id INTEGER NOT NULL DEFAULT 0)");
      db.execute(
        """CREATE TABLE User(
                id INTEGER PRIMARY KEY,
                username UNIQUE TEXT,
                email TEXT,
                password TEXT)""",  
      );
      db.insert("User", {"id": 0, "username": "default", "email": "default", "password": "default"});
      
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