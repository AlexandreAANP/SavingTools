class User {
  int? id;
  String? username;
  String? email;
  String? password;

  User({this.id, this.username, this.email, this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, password: $password}';
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }
}