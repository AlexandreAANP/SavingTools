import 'package:saving_tools/Entities/User.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository{
  final Database database;

  final String table = 'User';

  UserRepository(this.database);
	

  Future<void> insertUser(User user) async {
    await this.database.insert(
      table,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<User> getUser(String? username) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'username = ?',
      whereArgs: [username],);

    return User.fromMap(maps.first);
  }

}
