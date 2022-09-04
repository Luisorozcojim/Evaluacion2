final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [
    id,
    name,
    password,
  ];

  static final String id = 'id';
  static final String name = 'name';
  static final String password = 'password';
}

class UsersModel {
  final int? id;
  final String name;
  final String password;

  UsersModel({
    this.id,
    required this.name,
    required this.password,
  });

  UsersModel copy({
    int? id,
    String? name,
    String? password,
  }) =>
      UsersModel(
        id: id ?? this.id,
        name: name ?? this.name,
        password: password ?? this.password,
      );

  static UsersModel fromJson(Map<String, Object?> json) => UsersModel(
    id: json[UserFields.id] as int,
    name: json[UserFields.name] as String,
    password: json[UserFields.password] as String,
  );

  Map<String, Object?> toJson() => {
    UserFields.id: id,
    UserFields.name: name,
    UserFields.password: password,
  };
}