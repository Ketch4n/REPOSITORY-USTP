class UserModel {
  final int id;
  final String username;
  final String email;
  final int type;
  final int status;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.type,
    required this.status,
  });

  // Factory constructor to create a UserModel instance from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      type: json['type'],
      status: json['status'],
    );
  }

  // Method to convert a UserModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'type': type,
      'status': status,
    };
  }
}
