import 'package:saving_tools/Entities/User.dart';
import 'package:saving_tools/Exceptions/UserAlreadyExistException.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository{
  final Database database;

  final String table = 'User';

  UserRepository(this.database);
	

  Future<void> insertUser(User user) async {
    User? userif = await userExists(user);
    if(userif != null){
      if (user.username == userif.username) {
        throw UserAlreadyExistException("Username already exists");
      }else if(user.email == userif.email){
        throw UserAlreadyExistException("Email already exists");
      }
    }
    await this.database.insert(
      table,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<User?> userExists(User user) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'username = ? OR email = ?',
      whereArgs: [user.username, user.email],);
    if(maps.isEmpty){
      return null;
    }
    return User.fromMap(maps.first);
  }

  Future<User?> getUser({String? username}) async {
    
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'username = ?',
      whereArgs: [username],);
    if(maps.isEmpty){
      return null;
    }
    return User.fromMap(maps.first);
  }

  

}
