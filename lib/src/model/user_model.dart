class UserModel {
  final int id;
  final String username;
  final String email;
  final String password;
  final int type;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.type,
  });

  // Factory constructor to create a UserModel instance from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      type: json['type'],
    );
  }

  // Method to convert a UserModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'type': type,
    };
  }
}
