import 'package:saving_tools/DTOs/Mapper.dart';
import 'package:saving_tools/DTOs/UserDTO.dart';
import 'package:saving_tools/Entities/User.dart';
import 'package:saving_tools/Repositories/UserRepository.dart';
import 'package:sqflite/sqflite.dart';

class UserService{
  

  UserRepository? _userRepository;

  static Database? database;
  UserService._privateConstructor(Database databaseName) {
    _userRepository = UserRepository(databaseName);
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
    return Mapper.UserToUserDTO(await _userRepository!.getUser(username));
  }
}