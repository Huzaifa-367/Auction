import 'dart:convert';

class USER {
  int? id;
  String name;
  String email;
  String password;
  String userType;
  USER({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.userType,
  });

  USER copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? userType,
  }) {
    return USER(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'userType': userType});

    return result;
  }

  factory USER.fromMap(Map<String, dynamic> map) {
    return USER(
      id: int.parse(map['id']),
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      userType: map['userType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory USER.fromJson(String source) => USER.fromMap(json.decode(source));

  @override
  String toString() {
    return 'USER(id: $id, name: $name, email: $email, password: $password, userType: $userType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is USER &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.userType == userType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        userType.hashCode;
  }
}
