
import 'package:saving_tools/DTOs/Mapper.dart';
import 'package:saving_tools/DTOs/UserDTO.dart';
import 'package:saving_tools/Entities/User.dart';
import 'package:saving_tools/Exceptions/UnauthorizedException.dart';
import 'package:saving_tools/Repositories/UserRepository.dart';
import 'package:saving_tools/Repositories/WhoIs.dart';
import 'package:sqflite/sqflite.dart';

class UserService{
  

  UserRepository? _userRepository;

  static Database? database;
  UserService._privateConstructor(Database databaseName) {
    _userRepository = UserRepository(databaseName);
  }

  static final UserService _instance = UserService._privateConstructor(database!);

  factory UserService() {

    return _instance;
  }

  Future<UserDTO> registerUser({required String username, required String email, required String password}) async {
    User user = User(
      username: username,
      email: email,
      password: password
    );
    await _userRepository!.insertUser(user);
    return Mapper.UserToUserDTO(user);
  }

  Future<UserDTO> getUser(String? username) async {
    User? user = await _userRepository!.getUser(username: username);
    if(user == null){
      throw Exception("User doesn't exist");
    }
    return Mapper.UserToUserDTO(user);
  }


  Future<void> register({required String username, required String email, required String password}) async {
    User user = User(
      username: username,
      email: email,
      password: password
    );
    WhoIs.setActualUsername(user.username!);
    await _userRepository!.insertUser(user);
  }

  /// Logs in the user with the provided [username] and [password].
  ///
  /// This method returns a [Future] that completes with [void] when the login process is complete.
  /// Throws an exception if the login fails.
  Future<void> login({required String username, required String password}) async {
    // implementation goes here
    User? user = await _userRepository!.getUser(username: username);
    if(user == null){
      throw UnauthorizedException("User doesn't exist");
    }
    if(user.password != password){
      throw UnauthorizedException("Invalid password");
    }
    WhoIs.setActualUsername(user.username!);
  }
    
}