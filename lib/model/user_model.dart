class User {
  final String name;
  final String email;
  final String password;
  final String language;
  final String gender;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.language,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'language': language,
      'gender': gender,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      language: map['language'] ?? '',
      gender: map['gender'] ?? '',
    );
  }
}
