import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0) // Unique ID for your object type
class UserModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String userName;

  @HiveField(2)
  String password;

  @HiveField(3)
  bool isCompleted;

  UserModel({
    required this.id,
    required this.userName,
    required this.password,
    this.isCompleted = false,
  });
}
