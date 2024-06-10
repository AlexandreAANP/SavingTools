class UserAlreadyExistException implements Exception {
  String message;
  UserAlreadyExistException(this.message);
}