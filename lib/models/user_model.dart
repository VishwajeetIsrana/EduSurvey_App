class UserModel {
  String id;
  String email;
  String phone;
  String password;
  String profilePicture;

  UserModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.password,
    this.profilePicture = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'password': password,
      'profilePicture': profilePicture,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'] ?? '',
      phone: map['phone'],
      password: map['password'],
      profilePicture: map['profilePicture'] ?? '',
    );
  }
}
